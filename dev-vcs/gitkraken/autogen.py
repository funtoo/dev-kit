#!/usr/bin/env python3

import json
import re
from datetime import timedelta

RELEASE = re.compile(r"Latest release: ([0-9.]+)")


async def generate(hub, **pkginfo):
	text_data = await hub.pkgtools.fetch.get_page("https://www.gitkraken.com/download")
	text_list = text_data.split("\n")
	release = None

	for text in text_list:
		found = RELEASE.search(text)
		if found:
			release = found.groups()[0]
			break

	if release:
		url = f"https://release.gitkraken.com/linux/GitKraken-v{release}.tar.gz"
		final_name = f"gitkraken-amd64-{release}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo, version=release, artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()


# vim: ts=4 sw=4 noet
