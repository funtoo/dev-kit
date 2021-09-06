#!/usr/bin/env python3

from packaging import version


def get_release(release_data):
	releases = list(filter(lambda x: x["prerelease"] is False and x["draft"] is False, release_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()



async def generate(hub, **pkginfo):
	user = "fmtlib"
	repo = "fmt"
	release_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True)
	latest_release = get_release(release_data)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find suitable release of {repo}")
	version = latest_release["tag_name"].lstrip("v")
	url = latest_release["tarball_url"]
	final_name = f"{repo}-{version}.tar.gz"
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=user,
		github_repo=repo,
		artifacts=[src_artifact],
	)
	ebuild.push()
