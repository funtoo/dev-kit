#!/usr/bin/env python3


async def generate(hub, **pkginfo):
	github_user = "sharkdp"
	github_repo = pkginfo["name"]
	crate_name = pkginfo["name"]
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	for release in json_list:
		if release["prerelease"] or release["draft"]:
			continue
		version = release["tag_name"][1:]
		url = release["tarball_url"]
		break
	final_name = f'{pkginfo["name"]}-{version}.tar.gz'
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	artifacts = await hub.pkgtools.rust.generate_crates_from_artifact(src_artifact)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		crates=artifacts["crates"],
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[
			src_artifact,
			*artifacts["crates_artifacts"],
		],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
