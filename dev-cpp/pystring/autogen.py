#!/usr/bin/env python3

from datetime import datetime, timedelta


async def query_github_api(user, repo, query):
	return await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/{query}",
		is_json=True,
		refresh_interval=timedelta(days=15),
	)


async def generate(hub, **pkginfo):
	github_user = "imageworks"
	github_repo = pkginfo["name"]
	json_data = await query_github_api(github_user, github_repo, "tags")
	for tag in json_data:
		if tag["name"].lstrip("v").upper().isupper():
			continue
		version = tag["name"].lstrip("v")
		break
	commit_data = await query_github_api(github_user, github_repo, "commits/master")
	commit_hash = commit_data["sha"]
	commit_date = datetime.strptime(commit_data["commit"]["committer"]["date"], "%Y-%m-%dT%H:%M:%SZ")
	version += "_p" + commit_date.strftime("%Y%m%d")
	url = f"https://github.com/{github_user}/{github_repo}/archive/{commit_hash}.tar.gz"
	final_name = f'{pkginfo["name"]}-{version}.tar.gz'
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		github_user=github_user,
		github_repo=github_repo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
