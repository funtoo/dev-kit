#!/usr/bin/env python3

import json
import re
from datetime import timedelta

RELEASE = re.compile(r'>([0-9.]+)/<')

async def generate(hub, **pkginfo):
	text_data = await hub.pkgtools.fetch.get_page("http://mirrors.jenkins-ci.org/war-stable/")
	text_list = text_data.split("\n")
	text_list.reverse()
	version = None

	for text in text_list:
		found = RELEASE.search(text)
		if found:
			version = found.groups()[0]
			break

	if version:
		final_name = f"jenkins-lts-bin-{version}.war"
		url = f"http://mirrors.jenkins-ci.org/war-stable/{version}/jenkins.war"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
