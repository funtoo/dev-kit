#!/usr/bin/env python3

import base64
from packaging import version


def get_release(releases_data):
	releases = list(filter(lambda x: x['prerelease'] is False and x['draft'] is False, releases_data))
	return None if not releases else sorted(releases, key=lambda x: version.parse(x['tag_name'])).pop()


# We need to get the SONAME out of the Makefile as it tends to change between releases and doesn't
# even go in order all the time. Thankfully github api provides an easy way to do that.
async def get_soname(hub, github_user, github_repo, tag_name):
	enc_makefile = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/contents/Makefile?ref={tag_name}", 
		is_json=True
	)
	if not enc_makefile:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't get the required soname from {github_repo}")
		
	# Content is base64 encoded
	makefile = base64.b64decode(enc_makefile['content']).decode()
	for line in makefile.splitlines():
		if line.startswith("SONAME="):
			return line.strip("SONAME=")
	raise hub.pkgtools.ebuild.BreezyError(f"Can't get the required soname from {github_repo}")


async def generate(hub, **pkginfo):
	github_user = "google"
	github_repo = "re2"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	latest_release = get_release(json_list)
	if latest_release is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {github_repo}")

	version = latest_release['tag_name'].replace("-", ".")
	url = latest_release['tarball_url']
	final_name = f"{pkginfo['name']}-{version}.tar.gz"
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	
	soname = await get_soname(hub, github_user, github_repo, latest_release['tag_name'])
	
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		soname=soname,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[src_artifact]
	)
	ebuild.push()
