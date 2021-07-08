#!/usr/bin/env python3

import json
from packaging import version


async def get_latest_version(hub, github_user, github_repo):
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/tags",
		is_json=True
	)

	tags = []
	for t in json_list:
		tag = t["name"]
		if tag.startswith("distrobuilder-"):
			tags.append(tag.lstrip("distrobuilder-"))

	tags = sorted(tags, key=lambda t: version.parse(t))

	print(f"tags={tags}")

	return None if not tags else tags.pop()


async def generate(hub, **pkginfo):

	github_user = "lxc"
	github_repo = pkginfo["name"]

	latest_version = await get_latest_version(hub, github_user, github_repo)

	if latest_version is None:
		raise hub.pkgtools.ebuild.BreezyError(
			f"Can't find a latest version of {pkginfo['cat']}/{pkginfo['name']}"
		)

	#url = f"https://github.com/{github_user}/{github_repo}/archive/refs/tags/{github_repo}-{latest_version}.tar.gz"

	url = f"https://linuxcontainers.org/downloads/distrobuilder/{github_repo}-{latest_version}.tar.gz"

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=latest_version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
