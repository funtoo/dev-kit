#!/usr/bin/env python3

import json
from datetime import timedelta

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://data.services.jetbrains.com/products/releases?code=PCP")
	data = json.loads(json_data)['PCP']
	url = None
	version = None

	for rel in data:
		try:
			if rel['type'] == 'release':
				version = rel['majorVersion']
				url = rel['downloads']['linux']['link']
				break

		except KeyError:
			continue

	if version and url:
		final_name = f"pycharm-professional-{version}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
