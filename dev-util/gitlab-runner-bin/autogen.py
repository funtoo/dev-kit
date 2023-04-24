async def generate(hub, **pkginfo):
	gitlab_user = "gitlab-org"
	gitlab_repo = "gitlab-runner"
	json_list = await hub.pkgtools.fetch.get_page(
		f"https://gitlab.com/api/v4/projects/{gitlab_user}%2F{gitlab_repo}/releases", is_json=True
	)
	latest = json_list[0]
	version = latest["name"][1:]
	url = f"https://gitlab.com/gitlab-org/gitlab-runner/-/releases/v{version}/downloads/binaries/gitlab-runner-linux-amd64"
	final_name = f'{pkginfo["name"]}-{version}.bin'
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
	)
	ebuild.push()

