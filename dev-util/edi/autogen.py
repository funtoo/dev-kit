#!/usr/bin/env python3

from metatools.version import generic


def get_release(releases_data):
	releases = list(filter(lambda x: "beta" not in x['name'] and "alpha" not in x['name'], releases_data))
	return None if not releases else sorted(releases, key=lambda x: generic.parse(x['name'])).pop()


async def generate(hub, **pkginfo):
	github_user = "Enlightenment"
	github_repo = "edi"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/tags", is_json=True
	)
	latest_release = get_release(json_list)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {github_repo}")
	version = latest_release['name'].lstrip("v")
	url = latest_release['tarball_url']
	final_name = f"{pkginfo['name']}-{version}.tar.gz"
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[src_artifact]
	)
	ebuild.push()
