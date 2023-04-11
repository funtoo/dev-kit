#!/usr/bin/env python3
from bs4 import BeautifulSoup
import re

async def get_latest_release(hub, **pkginfo):
    html = await hub.pkgtools.fetch.get_page("https://download.filezilla-project.org/libfilezilla/?C=M;O=D")

    for a in BeautifulSoup(html, features="html.parser").find_all("a", href=True):
        v = re.search("(?<=libfilezilla-)\d+\.\d+\.\d+(?=\.tar\.bz2)", a["href"])
        if v is not None:
            return v.group(0)

    raise KeyError(f"Unable to find a tarball for {pkginfo['name']}")


async def generate(hub, **pkginfo):
    version = await get_latest_release(hub, **pkginfo)

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version=version,
        artifacts=[hub.pkgtools.ebuild.Artifact(url=f"https://download.filezilla-project.org/libfilezilla/libfilezilla-{version}.tar.bz2")]
    )
    ebuild.push()
