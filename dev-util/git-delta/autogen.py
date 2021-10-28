#!/usr/bin/env python3

from packaging import version


async def generate(hub, **pkginfo):
	github_user = "dandavison"
	github_repo = "delta"

	release_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases",
		is_json=True,
	)

	try:
		latest_release = max(
			(
				release
				for release in release_data
				if not release["prerelease"] and not release["draft"]
			),
			key=lambda release: version.parse(release["tag_name"]),
		)
	except ValueError:
		raise hub.pkgtools.ebuild.BreezyError(
			f"Can't find suitable release of {github_repo}"
		)

	tag_name = latest_release["tag_name"]
	latest_version = tag_name.lstrip("v")

	source_url = latest_release["tarball_url"]
	source_name = f"{github_repo}-{latest_version}.tar.gz"

	source_artifact = hub.pkgtools.ebuild.Artifact(
		url=source_url, final_name=source_name
	)

	cargo_artifacts = await hub.pkgtools.rust.generate_crates_from_artifact(
		source_artifact
	)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=latest_version,
		github_user=github_user,
		github_repo=github_repo,
		crates=cargo_artifacts["crates"],
		artifacts=[source_artifact, *cargo_artifacts["crates_artifacts"]],
	)
	ebuild.push()

