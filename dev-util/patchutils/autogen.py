#!/usr/bin/env python3

import json


async def generate(hub, **pkginfo):

	github_user = "twaugh"
	github_repo = pkginfo["name"]
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)

	for rel in json_list:
		version = rel["tag_name"]
		if rel["draft"] == False and rel["prerelease"] == False:
			break

	url = f"http://cyberelk.net/tim/data/patchutils/stable/{github_repo}-{version}.tar.xz"

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
