#!/usr/bin/env python3

from packaging import version

def find_suitable_release(hub, pkginfo, release_data):
	# FL-9021: updated this strategy to make sure our desired asset exists in the release we choose:
	for release in release_data:
		if release["prerelease"] or release["draft"]:
			continue
		tag_name = release["tag_name"]
		version = tag_name.lstrip("v")
		source_name = f"{pkginfo.get('name')}_{version}_amd64.deb"
		try:
			source_asset = next(
				asset for asset in release["assets"] if asset["name"] == source_name
			)
			return version, release, hub.pkgtools.ebuild.Artifact(url=source_asset["browser_download_url"], final_name=source_name)
		except StopIteration:
			# not found, release not usable by us, so skip it:
			continue

async def generate(hub, **pkginfo):
	github_user = "mongodb-js"
	github_repo = "compass"

	release_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases",
		is_json=True,
	)

	version, release, artifact = find_suitable_release(hub, pkginfo, release_data)

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[artifact],
		github_user=github_user,
		github_repo=github_repo,
	)
	ebuild.push()

# vim: ts=4 sw=4 noet tw=120
