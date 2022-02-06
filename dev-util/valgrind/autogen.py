#!/usr/bin/env python3

from bs4 import BeautifulSoup
import re

async def generate(hub, **pkginfo):
	html_url = f"https://valgrind.org/downloads/current.html"
	dl_url, version = await hub.pkgtools.pages.iter_links(
		base_url=html_url,
		match_fn=lambda x: re.match(f"(https://.*valgrind-([0-9.]+)\.tar\.bz2)", x),
		fixup_fn=lambda x: x.groups(),
		first_match=True
	)
	artifacts = [hub.pkgtools.ebuild.Artifact(url=dl_url)]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		version=version,
		artifacts=artifacts,
		**pkginfo)
	ebuild.push()


# vim: ts=4 sw=4 noet
