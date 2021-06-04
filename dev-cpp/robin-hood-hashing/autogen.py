#!/usr/bin/env python3

import json


async def generate(hub, **pkginfo):
	user = "martinus"
	repo = pkginfo["name"]
	json_list = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True)
	for release in json_list:
		if release["prerelease"] or release["draft"]:
			continue
		version = release["tag_name"]
		url = release["tarball_url"]
		break
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=user,
		github_repo=repo,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=f"{repo}-{version}.tar.gz")],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
