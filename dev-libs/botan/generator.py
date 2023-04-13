#!/usr/bin/env python3

from packaging.version import Version

async def generate(hub, **pkginfo):
	github_user = pkginfo["github"]["user"]
	github_repo = pkginfo["github"]["repo"]

	for slot in pkginfo["slots"]:

		newpkginfo = await hub.pkgtools.github.tag_gen(hub, github_user, github_repo, select=f"{slot}+")
		pkginfo.update(newpkginfo)
		version = Version(pkginfo["version"])

		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			github_user=github_user,
			github_repo=github_repo,
			slot=f"{version.major}/{version.major}.{version.minor}",
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
