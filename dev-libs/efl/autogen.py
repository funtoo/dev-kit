#!/usr/bin/env python3

from packaging import version

from bs4 import BeautifulSoup

# Get official Enlightenment library, application, and development tool releases from the Enlightenment download page
# The Enlightenment releases are structured in an two column HTML table located at https://www.enlightenment.org/download
# HTML data extraction is from this table is handled with BeautifulSoup (https://beautiful-soup-4.readthedocs.io)
#
# Example HTML table data cell tag's columnar data:
# <td class="col0"><a class="urlextern" href="https://download.enlightenment.org/rel/libs/efl/efl-1.26.1.tar.xz" rel="nofollow" title="https://download.enlightenment.org/rel/libs/efl/efl-1.26.1.tar.xz">EFL</a></td>, <td class="col1">1.26.1</td>
#
# From the bs4.element.Tag td objects created, the upstream Enlightenment packages names, versions, and URL tarball sources are extracted, grouped into lists, then constructed into a list of tuples
#
# Example constructed package tuple: ('enlightenment', '0.25.1', 'https://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.25.1.tar.xz')
#
# From the list of Enlightenment package tuples, a dictionary is constructed for easy package lookup based on the upstream name
# Example package data lookup:
# enlight_releases['enlightenment']
# {'version': '0.25.1', 'tarball_url': 'https://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.25.1.tar.xz'}
#
# The data in the BeautifulSoup derived dictionary can be then used for ebuild package info like version and url
async def get_enlight_releases(hub, **pkginfo):
	html = await hub.pkgtools.fetch.get_page("https://www.enlightenment.org/download")
	soup = BeautifulSoup(html, features="html.parser").find_all("td")
	release_names = []
	release_versions = []
	release_hrefs = []
	for td in soup:
		if td['class'][0] == "col0":
			release_names.append(str.lower(td.a.contents[0]))
			release_hrefs.append(td.a['href'])
		elif td['class'][0] == "col1":
			release_versions.append(td.contents[0])
	enlight_releases = {}
	for enlight_package in list(zip(release_names,release_versions,release_hrefs)):
		package = { enlight_package[0]: { 'version': enlight_package[1], 'tarball_url': enlight_package[2] } }
		enlight_releases.update(package)
	return enlight_releases

async def generate(hub, **pkginfo):
	# This package name should match the lowercase string pulled from the
	# Enlightenment Release section tables' first column located at: https://www.enlightenment.org/download
	upstream_release_name = "efl"
	enlight_releases = await get_enlight_releases(hub, **pkginfo)
	if enlight_releases is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {upstream_release_name}")
	version = enlight_releases[upstream_release_name]['version']
	url = enlight_releases[upstream_release_name]['tarball_url']
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[src_artifact]
	)
	ebuild.push()
