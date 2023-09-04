#!/usr/bin/env python

import os
import re


async def generate(hub, **pkginfo):
	github_user = "anrieff"
	github_repo = pkginfo["name"]

	release_info = await hub.pkgtools.github.release_gen(
		hub, github_user, github_repo, tarball=f"{github_repo}-{{version}}.tar.gz"
	)
	pkginfo.update(release_info)

	src_artifact = pkginfo["artifacts"][0]
	await src_artifact.ensure_fetched()
	src_artifact.extract()

	src_dir = pkginfo["src_dir"] = f"{github_repo}-{pkginfo['version']}"
	src_path = os.path.join(src_artifact.extract_path, src_dir)
	cmake_path = os.path.join(src_path, "CMakeLists.txt")

	with open(cmake_path, "r") as cmake_file:
		cmake_data = cmake_file.read()

	slot_pattern = re.compile("^set\(LIBCPUID_CURRENT\s+(\d+)\)$", re.MULTILINE)
	(pkginfo["slot"],) = slot_pattern.search(cmake_data).groups()

	src_artifact.cleanup()

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
	)
	ebuild.push()
