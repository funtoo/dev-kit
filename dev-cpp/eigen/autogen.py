#!/usr/bin/env python3


async def generate(hub, **pkginfo):
	user = "libeigen"
	repo = pkginfo["name"]
	project_path = f"{user}%2F{repo}"
	releases_data = await hub.pkgtools.fetch.get_page(
		f"https://gitlab.com/api/v4/projects/{project_path}/releases", is_json=True
	)
	for release in releases_data:
		if release["tag_name"].upper().isupper():
			continue
		version = release["tag_name"]
		break

	url = f"https://gitlab.com/{user}/{repo}/-/archive/{version}/{repo}-{version}.tar.bz2"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
