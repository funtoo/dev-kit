#!/usr/bin/env python3

import json

GLOBAL_DEFAULTS = {"cat": "dev-util"}


async def generate(hub, **pkginfo):
	jid = pkginfo["jid"]  # jetbrains id
	name = pkginfo["name"]
	data = await hub.pkgtools.fetch.get_page(
		f"https://data.services.jetbrains.com/products/releases?code={jid}&latest=true&type=release", is_json=True
	)
	rel = data[jid][0]
	version = rel["version"]
	url = rel["downloads"]["linux"]["link"]
	final_name = f"{name}-{version}.tar.gz"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		template="jetbrains.tmpl",
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
