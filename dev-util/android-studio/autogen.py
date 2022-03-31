#!/usr/bin/env python

from bs4 import BeautifulSoup
import re


async def generate(hub, **pkginfo):
	download_page_url = "https://developer.android.com/studio"
	src_pattern = re.compile("android-studio-([\d.]+)-linux.tar.gz")
	download_url_format = (
		"https://redirector.gvt1.com/edgedl/android/studio/ide-zips/{version}/{name}"
	)

	download_page_soup = BeautifulSoup(
		await hub.pkgtools.http.get_page(download_page_url), "lxml"
	)

	downloads_table = download_page_soup.find("table", class_="download")

	downloads_table_rows = downloads_table.find_all("tr")

	for row in downloads_table_rows:
		platform_column = row.find("td")
		if platform_column is None:
			continue

		if platform_column.text.strip() == "Linux(64-bit)":
			linux_row = row
			break

	linux_download_button = linux_row.find("button")
	linux_download_name = linux_download_button.text.strip()

	(linux_version,) = src_pattern.match(linux_download_name).groups()

	linux_source_url = download_url_format.format(
		version=linux_version, name=linux_download_name
	)
	linux_source_artifact = hub.pkgtools.ebuild.Artifact(url=linux_source_url)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=linux_version,
		artifacts=[linux_source_artifact],
	)
	ebuild.push()

