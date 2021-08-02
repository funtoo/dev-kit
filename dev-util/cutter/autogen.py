#!/usr/bin/env python3

from packaging import version


def get_release(releases_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x["draft"] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()


async def generate(hub, **pkginfo):
	python_compat = "python3+"
	user = "radareorg"
	name = pkginfo["name"]
	releases_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{name}/releases", is_json=True
	)
	latest_release = get_release(releases_data)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {name}")
	version = latest_release["tag_name"]
	ebuild_version = version.lstrip("v")
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=ebuild_version,
		python_compat=python_compat,
		artifacts=[
			hub.pkgtools.ebuild.Artifact(
				url=f"https://github.com/{user}/{name}/archive/{version}.tar.gz",
				final_name=f"{name}-{ebuild_version}.tar.gz",
			)
		],
	)
	ebuild.push()
