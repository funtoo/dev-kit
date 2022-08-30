#!/usr/bin.env python3
from packaging import version

async def generate(hub, **pkginfo):
    user = "libhangul"
    repo = "libhangul"
    tag_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{user}/{repo}/tags", is_json=True)
    latest_tag = tag_data[0]

    # Remove the name + the - before the version number in the tag name
    version = latest_tag["name"][len(repo)+ 1:]
    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version = version,
        artifacts = [hub.pkgtools.ebuild.Artifact(url=f"https://api.github.com/repos/{user}/{repo}/tarball/refs/tags/{repo}-{version}", final_name=f"{repo}-{version}.tar.gz")]
    )
    ebuild.push()
