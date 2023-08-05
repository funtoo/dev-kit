#!/usr/bin/env python3

from packaging import version


async def generate(hub, **pkginfo):
	python_compat = "python3+"
	user = "capstone-engine"
	name = pkginfo["name"]
	pkginfo.update(await hub.pkgtools.github.release_gen(hub, user, name))
	major_version = pkginfo['version'].split(".", 1)[0]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		major_version=major_version,
		python_compat=python_compat
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
