#!/usr/bin/env python3

from bs4 import BeautifulSoup
from packaging.version import Version
import re

async def generate(hub, **pkginfo):
    homepage = "https://www.arduino.cc/en/software"
    regex = r'(\d+(?:\.\d+)+)'
    arches = {
        '32': 'x86',
        '64': 'amd64',
        'arm': 'arm',
        'aarch64': 'arm64',
    }


    html = await hub.pkgtools.fetch.get_page(homepage)
    soup = BeautifulSoup(html, features="html.parser").find_all("a", class_="download-link")

    downloads = [a.get('href') for a in soup if 'linux' in a.get('href')]
    tarballs = [(Version(re.findall(regex, a)[0]), a) for a in downloads if re.findall(regex, a)]
    latest_version = max(tarballs)[0]

    name = pkginfo["name"]

    artifacts=dict([
        (arches[t[1].split('linux')[1].split('.tar')[0]], hub.pkgtools.ebuild.Artifact(url=t[1])) for t in tarballs
    ])

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        version=latest_version,
        artifacts=artifacts,
    )
    ebuild.push()
