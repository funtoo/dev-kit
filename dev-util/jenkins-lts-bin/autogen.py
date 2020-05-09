#!/usr/bin/env python3

import json

GITHUB_USER = 'jenkinsci'
GITHUB_REPO = 'jenkins'

async def get_lts_branch(hub):
	json_data = await hub.pkgtools.fetch.get_page(f'https://api.github.com/repos/{GITHUB_USER}/{GITHUB_REPO}/branches')
	json_list = json.loads(json_data)

	branch_major, branch_minor = 0, 0

	for tag in json_list:
		if not tag['name'].startswith('stable-'):
			continue

		vsplit= tag['name'].lstrip('stable-').split('.')

		if len(vsplit) != 2:
			continue

		major, minor = int(vsplit[0]), int(vsplit[1])

		if major > branch_major:
			branch_major, branch_minor = major, minor
		elif major == branch_major and minor > branch_minor:
			branch_minor = minor

	return [branch_major, branch_minor]

async def get_lts_version(hub, branch_major, branch_minor):

	json_data = await hub.pkgtools.fetch.get_page(f'https://api.github.com/repos/{GITHUB_USER}/{GITHUB_REPO}/tags')
	json_list = json.loads(json_data)

	latest_patch = 0

	for tag in json_list:
		if not tag['name'].startswith('jenkins-'):
			continue

		vsplit= tag['name'].lstrip('jenkings-').split('.')

		if len(vsplit) < 2:
			continue

		patch = 0
		major, minor = int(vsplit[0]), int(vsplit[1])
		if len(vsplit) == 3:
			patch = int(vsplit[2])

		if branch_major == major and branch_minor == minor and patch > latest_patch:
			latest_patch = patch

	v = [str(branch_major), str(branch_minor)]
	if latest_patch > 0:
		v.append(str(latest_patch))

	return '.'.join(v)

async def generate(hub, **pkginfo):

	# LTS is determined by latest 'stable-*' branch
	[branch_major, branch_minor] = await get_lts_branch(hub)

	if branch_major == 0:
		raise hub.pkgtools.ebuild.BreezyError('Failed to find latest stable branch of jenkins :(')

	version = await get_lts_version(hub, branch_major, branch_minor)

	final_name = f"jenkins-lts-bin-{version}.war"
	url = f"http://mirrors.jenkins-ci.org/war-stable/{version}/jenkins.war"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
