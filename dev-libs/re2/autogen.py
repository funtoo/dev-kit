#!/usr/bin/env python3

import os


# We need to get the SONAME out of the Makefile as it tends to change between releases and doesn't
# even go in order all the time.
async def get_soname(hub, pkginfo):
	artifact = pkginfo["artifacts"][0]
	await artifact.ensure_fetched()
	artifact.extract()
	with open(
			os.path.join(
				artifact.extract_path,
				f"{pkginfo['github_user']}-{pkginfo['github_repo']}-{pkginfo['sha'][:7]}", "Makefile"),
			"r"
	) as makefile:
		for line in makefile.read().splitlines():
			if line.startswith("SONAME="):
				return line.strip("SONAME=")

async def generate(hub, **pkginfo):
	pkginfo.update(dict(
		github_user="google",
		github_repo="re2"
	))
	# FL-11384: Lock to currently-working version:
	pkginfo["version"] = "2022.12.01"
	pkginfo.update(await hub.pkgtools.github.release_gen(hub, transform=lambda x: x.replace('-', '.'), **pkginfo))
	pkginfo['soname'] = await get_soname(hub, pkginfo)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
