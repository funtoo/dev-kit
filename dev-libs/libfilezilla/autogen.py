#!/usr/bin/env python3
from bs4 import BeautifulSoup
import re

async def get_latest_release(hub, **pkginfo):
    html = await hub.pkgtools.fetch.get_page("https://lib.filezilla-project.org/download.php")

    for a in BeautifulSoup(html, features="html.parser").find_all("a", href=True):
        v = re.search("(?<=libfilezilla-)\d+\.\d+\.\d+(?=\.tar\.xz)", a["href"])
        if v is not None:
            return [v.group(0), a["href"]]

    raise KeyError(f"Unable to find a tarball for {pkginfo['name']}")


async def generate(hub, **pkginfo):
    version_url = await get_latest_release(hub, **pkginfo)
    version = version_url[0]
    url = version_url[1]
    final_name=f'libfilezilla-{version}_src.tar.xz'
    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version=version,
        artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
    )
    ebuild.push()
