#!/usr/bin/env python3

import re
from packaging import version


def get_release(release_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x["draft"] is False, release_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()


async def get_gosum_artifacts(hub, github_user, github_repo, version):
	gosum_raw = await hub.pkgtools.fetch.get_page(f"https://github.com/{github_user}/{github_repo}/raw/{version}/go.sum")
	gosum_lines = gosum_raw.split("\n")
	gosum = ""
	gosum_artifacts = []
	for line in gosum_lines:
		module = line.split()
		if not len(module):
			continue
		gosum = gosum + '\t"' + module[0] + " " + module[1] + '"\n'
		module_path = re.sub("([A-Z]{1})", r"!\1", module[0]).lower()
		module_ver = module[1].split("/")
		module_ext = "zip"
		if "go.mod" in module[1]:
			module_ext = "mod"
		module_uri = module_path + "/@v/" + module_ver[0] + "." + module_ext
		module_file = re.sub("/", "%2F", module_uri)
		gosum_artifacts.append(
			hub.pkgtools.ebuild.Artifact(url="https://proxy.golang.org/" + module_uri, final_name=module_file)
		)
	return dict(gosum=gosum, gosum_artifacts=gosum_artifacts)


async def generate(hub, **pkginfo):
	user = "boyter"
	repo = pkginfo["name"]
	json_dict = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True)
	latest_release = get_release(json_dict)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {repo}")
	version = latest_release["tag_name"]
	artifacts = await get_gosum_artifacts(hub, user, repo, version)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version.lstrip("v"),
		gosum=artifacts["gosum"],
		artifacts=[
			hub.pkgtools.ebuild.Artifact(url=f"https://github.com/{user}/{repo}/archive/{version}.tar.gz",final_name=f"{repo}-{version}.tar.gz"),
			*artifacts["gosum_artifacts"],
		],
	)
	ebuild.push()
