#!/usr/bin.env python3
# OpenCC uses a format of ver.X.Y.Z for some reason so here we go with a python autogen
from packaging import version

def get_release(releases_data):
    releases = list(
        filter(lambda x: x["prerelease"] is False and x["draft"] is False, releases_data)
    )
    return (
        None
        if not releases
        else sorted(releases, key=lambda x: version.parse(x["tag_name"])).pop()
    )

async def generate(hub, **pkginfo):
    user = "BYVoid"
    repo = "OpenCC"
    releases_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True)
    latest_release = get_release(releases_data)

    if latest_release is None:
        raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {name}")
    # Unfortunately OpenCC comes in the format ver.x.y.z, so we need to strip ver. from the tag_name for the version
    # The replacement of the dash with a dot is for the cases where the developers have to do a hotfix in which case they
    # make their releases in the same format but with a dash for the number. Example version they have: ver.1.0.3-1
    version = latest_release["tag_name"][len("ver."):].replace("-", ".")

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version = version,
        artifacts = [hub.pkgtools.ebuild.Artifact(url=f"https://github.com/{user}/{repo}/archive/refs/tags/ver.{version}.tar.gz", final_name=f"opencc-{version}.tar.gz")]
    )
    ebuild.push()
