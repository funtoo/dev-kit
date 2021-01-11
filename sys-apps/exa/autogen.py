#!/usr/bin/env python3

import json
import toml


async def get_crates_artifacts(hub, github_user, github_repo, crate_name, version):
	crates_raw = await hub.pkgtools.fetch.get_page(
		f"https://github.com/{github_user}/{github_repo}/raw/v{version}/Cargo.lock"
	)
	crates_dict = toml.loads(crates_raw)
	crates = ""
	crates_artifacts = []
	for package in crates_dict["package"]:
		if package["name"] == crate_name:
			continue
		crates = crates + package["name"] + "-" + package["version"] + "\n"
		crates_url = "https://crates.io/api/v1/crates/" + package["name"] + "/" + package["version"] + "/download"
		crates_file = package["name"] + "-" + package["version"] + ".crate"
		crates_artifacts.append(hub.pkgtools.ebuild.Artifact(url=crates_url, final_name=crates_file))
	return dict(crates=crates, crates_artifacts=crates_artifacts)


async def generate(hub, **pkginfo):
	github_user = "ogham"
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
	artifacts = await get_crates_artifacts(hub, github_user, github_repo, crate_name, version)
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		crates=artifacts["crates"],
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[
			hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name),
			*artifacts["crates_artifacts"],
		],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
