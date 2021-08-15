#!/usr/bin/env python3


async def query_github_api(user, repo, query):
	return await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/{query}",
		is_json=True,
	)


async def generate(hub, **pkginfo):
	github_user = pkginfo["name"]
	github_repo = pkginfo["name"]
	json_data = await query_github_api(github_user, github_repo, "releases")
	for release in json_data:
		if release["prerelease"] or release["draft"]:
			continue
		version = release["name"].lstrip("v")
		url = next(x["browser_download_url"] for x in release["assets"] if x["name"].endswith(".tar.bz2"))
		break
	artifact = hub.pkgtools.ebuild.Artifact(url=url)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[artifact],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
