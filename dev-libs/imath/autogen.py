#!/usr/bin/env python3

import re
import glob
import os

async def query_github_api(user, repo, query):
	return await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/{query}",
		is_json=True,
	)


async def generate(hub, **pkginfo):
	github_user = "AcademySoftwareFoundation"
	github_repo = "Imath"
	json_data = await query_github_api(github_user, github_repo, "releases")
	for release in json_data:
		if release["prerelease"] or release["draft"]:
			continue
		version = release["tag_name"].lstrip("v")
		url = release["tarball_url"]
		break
	final_name = f'{pkginfo["name"]}-{version}.tar.gz'
	artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	await artifact.fetch()
	artifact.extract()
	cmake_file = open(
		glob.glob(os.path.join(artifact.extract_path, f"{github_user}-{github_repo}-*", "CMakeLists.txt"))[0]
	).read()
	artifact.cleanup()

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		revision={ "3.1.3" : "1" },
		major_ver=version.split(".")[0],
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[artifact],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
