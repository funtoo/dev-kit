#!/usr/bin/env python3


async def generate(hub, **pkginfo):
	github_user = "rust-lang"
	github_repo = pkginfo["name"]
	crate_name = pkginfo["name"]
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	for release in json_list:
		if release["prerelease"] or release["draft"]:
			continue
		# Rust-analyzer GitHub Releases use a date formatted git tag
		# In its default format, the version string is incompatible as a Portage package version
		# We transform it to remove all dash delimiters so it is usable
		# Example upstream release: https://github.com/rust-lang/rust-analyzer/releases/tag/2022-12-26
		version = f'{"".join(release["tag_name"].split("-"))}'
		# We want the rust-analyzer exact date version as extra metadata for the ebuild template,
		# which is used to populate the binary version during a src_compile cargo install
		release_version = release["tag_name"]
		url = release["tarball_url"]
		break
	final_name = f'{pkginfo["name"]}-{version}.tar.gz'
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	artifacts = await hub.pkgtools.rust.generate_crates_from_artifact(src_artifact)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		release_version=release_version,
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
