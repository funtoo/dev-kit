#!/usr/bin/env python3

import re
from bs4 import BeautifulSoup
from packaging.version import Version

async def generate(hub, **pkginfo):
    regex = r'(\d+(?:\.\d+)+)'

    directory = pkginfo.get('directory') or pkginfo.get('name')
    url = f"https://lttng.org/files/{directory}"

    html = await hub.pkgtools.fetch.get_page(url)
    soup = BeautifulSoup(html, "html.parser").find_all("a")

    downloads = [a.get('href') for a in soup if a.get('href').endswith('.tar.bz2') and 'latest' not in a.get('href')]

    tarballs = [(Version(re.findall(regex, a)[0]), a) for a in downloads if re.findall(regex, a)]

    latest = max(tarballs)

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version=latest[0],
        artifacts=[hub.pkgtools.ebuild.Artifact(url=f"{url}/{latest[1]}")],
    )
    ebuild.push()
