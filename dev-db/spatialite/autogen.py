#!/usr/bin/env python3

import re


async def generate(hub, **pkginfo):
	spatialite_sources = "http://www.gaia-gis.it/gaia-sins/libspatialite-sources"
	html_data = await hub.pkgtools.fetch.get_page(spatialite_sources)
	latest = re.findall(f'<a href="libspatialite-([0-9.]*)\.tar.gz', html_data)
	version = latest[-1]
	src_artifact = hub.pkgtools.ebuild.Artifact(url=f"{spatialite_sources}/libspatialite-{version}.tar.gz")
	artifacts = [
		src_artifact,
	]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(**pkginfo, version=version, artifacts=artifacts)
	ebuild.push()


# vim: ts=4 sw=4 noet
