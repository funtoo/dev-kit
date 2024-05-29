#!/usr/bin/env python3

from metatools.version import generic


def get_release(releases_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x["draft"] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: generic.parse(x["tag_name"])).pop()


async def get_latest_release(hub, github_user, github_repo):
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	latest_release = get_release(json_list)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {github_repo}")

	url = latest_release["tarball_url"]
	version =  latest_release["tag_name"].lstrip("v")
	version = version.lstrip("release-")
	final_name = f"{github_repo}-{version}.tar.gz"
	artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	return {
	"url": url,
	"version": version,
	"final_name": final_name,
	"artifact": artifact
	}


async def generate(hub, **pkginfo):
	github_user = "nlohmann"
	github_repo = "json"
	test_repo="json_test_data"
	
	src_info = await get_latest_release(hub, github_user, github_repo)
	test_info = await get_latest_release(hub, github_user, test_repo)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=src_info["version"],
		test_version=test_info["version"],
		github_user=github_user,
		github_repo=github_repo,
		test_repo=test_repo,
		artifacts=[src_info["artifact"], test_info["artifact"]]
	)
	ebuild.push()
