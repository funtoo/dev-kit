#!/usr/bin/env python3


async def generate(hub, **pkginfo):
	user = "hashicorp"
	repo = "packer"

	release_data = await hub.pkgtools.github.release_gen(hub, user, repo)
	(source_artifact,) = release_data["artifacts"]

	golang_artifacts = await hub.pkgtools.golang.generate_gosum_from_artifact(source_artifact)

	release_data["artifacts"].extend(golang_artifacts["gosum_artifacts"])
	pkginfo.update(release_data)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		github_user=user,
		github_repo=repo,
		gosum=golang_artifacts["gosum"],
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
