#!/usr/bin/env python3

import json


async def generate(hub, **pkginfo):

	github_user = "jenkinsci"
	github_repo = "jenkins"
	json_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases/latest"
	)
	json_list = json.loads(json_data)
	version = json_list["tag_name"].split("-", 1)[1]

	if version == "":
		raise hub.pkgtools.ebuild.BreezyError("Failed to find latest version of jenkins :(")

	final_name = f"jenkins-bin-{version}.war"
	url = f"http://mirrors.jenkins-ci.org/war/{version}/jenkins.war"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo, version=version, artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
