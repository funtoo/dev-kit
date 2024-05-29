#!/usr/bin/env python3

from os import path

async def generate(hub, **pkginfo):
	github_user = pkginfo["name"]
	github_repo = "OpenSceneGraph"
	select = f"{github_repo}-\d+[\.\d]+"

	newpkginfo = await hub.pkgtools.github.tag_gen(hub, github_user, github_repo, select=select)
	pkginfo.update(newpkginfo)

	artifact = pkginfo['artifacts'][0]
	sha = pkginfo['sha'][:7]
	await artifact.fetch()
	artifact.extract()

	cmfile = path.join(artifact.extract_path, f"{github_user}-{github_repo}-{sha}", "CMakeLists.txt")
	with open(cmfile, "r") as cmf:
		for line in cmf.readlines():
			if 'SOVERSION' in line:
				soversion = line.split()[1].split(')')[0] # remove trailing closing paren
				break

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		github_user=github_user,
		github_repo=github_repo,
		slot=soversion
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
