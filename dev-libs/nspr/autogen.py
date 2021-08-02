#!/usr/bin/env python3

from packaging import version
from bs4 import BeautifulSoup


async def generate(hub, **pkginfo):
	url = f"https://ftp.mozilla.org/pub/nspr/releases/"
	html_data = await hub.pkgtools.fetch.get_page(url)
	soup = BeautifulSoup(html_data, "html.parser")
	latest_version = "0"
	for link in soup.find_all("a"):
		href = link.get_text()
		if href is not None and href.startswith("v"):
			ver = href.lstrip("v").rstrip("/")
			if version.parse(latest_version) < version.parse(ver):
				latest_version = ver
				latest_href = href
	src_url = url+latest_href+"src/"
	final_name = f'{pkginfo["name"]}-{latest_version}.tar.gz'

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=latest_version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=src_url+final_name)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
