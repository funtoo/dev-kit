#!/usr/bin/env python3

from packaging import version


async def generate(hub, **pkginfo):
	github_user = "lxc"
	github_repo = pkginfo.get("name")

	release_data = await hub.pkgtools.github.release_gen(hub, github_user, github_repo)
	(source_artifact,) = release_data["artifacts"]

	golang_artifacts = await hub.pkgtools.golang.generate_gosum_from_artifact(
		source_artifact
	)

	release_data["artifacts"].extend(golang_artifacts["gosum_artifacts"])
	pkginfo.update(release_data)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		github_user=github_user,
		github_repo=github_repo,
		gosum=golang_artifacts["gosum"],
	)
	ebuild.push()
