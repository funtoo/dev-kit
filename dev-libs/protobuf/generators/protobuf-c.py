#!/usr/bin/env python3

from packaging import version
import os

def get_release(releases_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x['draft'] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x['tag_name'])).pop()


async def generate(hub, **pkginfo):
	github_user = "protobuf-c"
	github_repo = "protobuf-c"
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
	amfile = os.path.join(src_artifact.extract_path, f"protobuf-c-{ver}/protobuf-c/libprotobuf-c.sym")
	with open(amfile, "r") as amf:
		first_line = amf.readline()
		# expecting this format:
		# LIBPROTOBUF_C_1.0.0 {
		if first_line.startswith("LIBPROTOBUF_C_"):
			soname=first_line.split()[0].split("_")[-1]
	src_artifact.cleanup()
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=ver,
		soname=soname,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[src_artifact]
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
