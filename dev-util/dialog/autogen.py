#!/usr/bin/env python3

from bs4 import BeautifulSoup
from packaging.version import Version
import re

regex = r'(\d+(?:[\.-]\d+)+)'

async def generate(hub, **pkginfo):
    name = pkginfo['name']
    download_url=f"https://invisible-mirror.net/archives/{name}/"
    html = await hub.pkgtools.fetch.get_page(download_url)
    soup = BeautifulSoup(html, 'html.parser').find_all('a', href=True)
    compression = ".tgz"


    releases = [a for a in soup if name in a.contents[0] and a.contents[0].endswith(compression)]
    latest = max([(
            Version(re.findall(regex, a.contents[0])[0]),
            a.get('href'))
        for a in releases if re.findall(regex, a.contents[0])
    ])
    print(latest)

    pkginfo['soname'] = latest[0].major

    artifact = hub.pkgtools.ebuild.Artifact(url=download_url + latest[1])

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version=str(latest[0]).replace('post', ''),
        artifacts=[artifact]
    )
    ebuild.push()


#vim: ts=4 sw=4 noet
