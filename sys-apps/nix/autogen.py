#!/usr/bin/env python3

from packaging import version


async def generate(hub, **pkginfo):
	github_user = "NixOS"
	github_repo = pkginfo["name"]

	release_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/tags",
		is_json=True,
	)

	try:
		latest_release = max(
			release_data,
			key=lambda release: version.parse(release["name"]),
		)
	except ValueError:
		raise hub.pkgtools.ebuild.BreezyError(
			f"Can't find suitable release of {github_repo}"
		)

	latest_version = latest_release["name"]

	source_url = latest_release["tarball_url"]
	source_name = f"{github_repo}-{latest_version}.tar.gz"

	source_artifact = hub.pkgtools.ebuild.Artifact(
		url=source_url, final_name=source_name
	)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=latest_version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[source_artifact],
	)
	ebuild.push()
