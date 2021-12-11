#!/usr/bin/env python3

from packaging import version
import os

def get_release(releases_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x['draft'] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x['tag_name'])).pop()


async def generate(hub, **pkginfo):
	github_user = "protocolbuffers"
	github_repo = "protobuf"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	latest_release = get_release(json_list)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {github_repo}")
	ver = latest_release['tag_name'].lstrip("v")
	url = f"https://github.com/{github_user}/{github_repo}/archive/{latest_release['tag_name']}.tar.gz"
	final_name = f"{pkginfo['name']}-{ver}.tar.gz"
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	await src_artifact.fetch()
	src_artifact.extract()
	amfile = os.path.join(src_artifact.extract_path, f"protobuf-{ver}/src/Makefile.am")
	with open(amfile, "r") as amf:
		lines = amf.read().split('\n')
		for line in lines:
			if line.startswith("PROTOBUF_VERSION ="):
				# First number before colon:
				protobuf_abi=line.split()[-1].split(":")[0]
	src_artifact.cleanup()
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=ver,
		protobuf_abi=protobuf_abi,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[src_artifact]
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
