#!/usr/bin/env python3

from packaging import version


def get_release(releases_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x["draft"] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()


async def generate(hub, **pkginfo):
	user = "arduino"
	repo = "Arduino"
	name = pkginfo["name"]
	releases_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True
	)
	latest_release = get_release(releases_data)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {repo}")
	version = latest_release["tag_name"]
	ebuild_version = version.lstrip("v")
	arches = [("linux64", "amd64", "amd64"), ("linux32", "i386", "x86")]
	artifacts = [
		hub.pkgtools.ebuild.Artifact(
			url=f"http://www.arduino.cc/download.php?f=/arduino-{version}-{arch_url}.tar.xz",
			final_name=f"{name}_{arch_name}-{version}.tar.xz",
		)
		for arch_url, arch_name, _ in arches
	]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=ebuild_version,
		sources=zip([x[2] for x in arches], artifacts),
		artifacts=artifacts,
	)
	ebuild.push()
