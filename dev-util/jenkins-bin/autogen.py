#!/usr/bin/env python3

import json


async def generate(hub, **pkginfo):

	github_user = "jenkinsci"
	github_repo = "jenkins"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	for release in json_list:
		version = release["tag_name"].split("-", 1)[1]
		if version == "":
			continue
		url = f"http://mirrors.jenkins-ci.org/war/{version}/jenkins.war"
		final_name = f"jenkins-bin-{version}.war"
		src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
		# Attempt to download latest release. But this could fail since jenkins-ci.org is sometimes behind
		# github. So we keep trying next-most-recent, etc.
		try:
			await src_artifact.fetch()
			break
		except hub.pkgtools.fetch.FetchError:
			continue

	ebuild = hub.pkgtools.ebuild.BreezyBuild(**pkginfo, version=version, artifacts=[src_artifact])
	ebuild.push()


# vim: ts=4 sw=4 noet
