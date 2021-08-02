#!/usr/bin/env python3

import re
from bs4 import BeautifulSoup


async def generate(hub, **pkginfo):
	name = pkginfo["name"]
	homepage_data = await hub.pkgtools.fetch.get_page("http://www.leonerd.org.uk/code/libvterm/")
	homepage_soup = BeautifulSoup(homepage_data, "html.parser")
	name_pattern = re.compile(f"({name}-(.*)\\.tar\\.gz)")
	for link in homepage_soup.find_all("a", href=True):
		curr_href = link["href"]
		curr_match = name_pattern.match(curr_href)
		if curr_match:
			latest_version = curr_match
			break
	if not latest_version:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release for {name}")
	filename, version = latest_version.groups()
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=f"http://www.leonerd.org.uk/code/libvterm/{filename}")],
	)
	ebuild.push()
