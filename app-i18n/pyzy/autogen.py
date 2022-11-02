#!/usr/bin.env python3
from packaging import version

async def get_release(releases_data):
    releases = list(
        filter(lambda x: x["prerelease"] is False and x["draft"] is False, releases_data)
    )
    return (
        None
        if not releases
        else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()
    )

async def generate_release(user, repo, hub):
    releases_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True)
    latest_release = await get_release(releases_data)

    if latest_release is None:
        raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {name}")
    version = latest_release["tag_name"]
    return version

async def generate(hub, **pkginfo):
    user = "openSUSE"
    repo = "pyzy"

    pyzy_version = await generate_release(user, repo, hub)
    db_version = await generate_release(user, f"{repo}-database", hub)

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version = pyzy_version,
        artifacts = [hub.pkgtools.ebuild.Artifact(url=f"https://github.com/{user}/{repo}/archive/refs/tags/{pyzy_version}.tar.gz"), hub.pkgtools.ebuild.Artifact(url=f"https://github.com/{user}/{repo}-database/archive/refs/tags/{db_version}.tar.gz")]
    )
    ebuild.push()
