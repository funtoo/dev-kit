from packaging.specifiers import SpecifierSet

async def generate(hub, **pkginfo):
	github_user = "kkos"
	github_repo = "oniguruma"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)

	for rel in json_list:
		version = rel["name"].replace("Release ", "")
		if 'tarball_url' in rel:
			url = rel['tarball_url']

		if version != "":
			break

	url=f"https://github.com/{github_user}/{github_repo}/releases/download/v{version}/onig-{version}.tar.gz"
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		github_user=github_user,
		github_repo=github_repo,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
	)
	ebuild.push()
