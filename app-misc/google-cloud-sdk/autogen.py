#!/usr/bin/env python3

from bs4 import BeautifulSoup
import re


async def generate(hub, **pkginfo):
	release_notes_data = await hub.pkgtools.fetch.get_page("https://cloud.google.com/sdk/docs/release-notes")
	release_notes_soup = BeautifulSoup(release_notes_data, "lxml")
	version_pattern = re.compile("([\d.]+)\s\([\d-]+\)")
	version_headers = (version_pattern.match(x.get("data-text")) for x in release_notes_soup.find_all("h2", attrs={"data-text": True}))
	version, = next(x.groups() for x in version_headers if x)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=f"https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/{pkginfo['name']}-{version}-linux-x86_64.tar.gz")],
	)
	ebuild.push()
