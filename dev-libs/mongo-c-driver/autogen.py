#!/usr/bin/env python3

async def generate(hub, **pkginfo):

	github_user = "mongodb"
	github_repo = "mongo-c-driver"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)

	for rel in json_list:
		version = rel["tag_name"]
		# skip release if {version} contains prerelease string
		skip = len(list(filter(
			lambda n: n > -1,
			map(
				lambda s : version.find(s),
				["alpha", "beta", "rc"]
			)
		))) > 0
		if skip:
			continue

		if rel["draft"] == False and rel["prerelease"] == False:
			break

	url=f"https://github.com/{github_user}/{github_repo}/archive/{version}.tar.gz"
	url=f"https://github.com/{github_user}/{github_repo}/releases/download/{version}/mongo-c-driver-{version}.tar.gz"
	final_name=f"{pkginfo['name']}-{version}.tar.gz"

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
