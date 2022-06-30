async def generate(hub, **pkginfo):

	supported_arches_map = {
		"x86": "i386",
		"amd64": "amd64",
		"ppc": "powerpc",
		"arm": "armeb",
		"arm64": "arm64",
		"mips": "mipsel",
	}

	github_user = "upx"
	github_repo = "upx"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)

	for rel in json_list:
		version = rel["tag_name"]

		# skip release if {version} contains prerelease string
		skip = len(list(filter(lambda n: n > -1, map(lambda s: version.find(s), ["alpha", "beta", "rc"])))) > 0
		if skip:
			continue

		if rel["draft"] == False and rel["prerelease"] == False:
			break

	pv=version[1:]
	artifacts = []
	for k, v in supported_arches_map.items():
		url=f"https://github.com/{github_repo}/{github_user}/releases/download/{version}/{github_user}-{pv}-{v}_linux.tar.xz"
		artifacts.append((
			k,
			hub.pkgtools.ebuild.Artifact(url=url),
		))

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=pv,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=dict(artifacts),
	)
	ebuild.push()
