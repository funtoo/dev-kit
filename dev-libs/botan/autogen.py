#!/usr/bin/env python3

import json


async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/randombit/botan/tags")
	json_dict = json.loads(json_data)
	for r in json_dict:
		if "name" in r and "alpha" in r["name"]:
			continue
		release = r
		break
	version = release["name"]
	url = f"https://github.com/randombit/botan/archive/refs/tags/{version}.tar.gz"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)]
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
