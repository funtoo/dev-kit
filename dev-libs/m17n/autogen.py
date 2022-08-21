#!/usr/bin/env python3
from datetime import datetime, timedelta
# HTML parser
from bs4 import BeautifulSoup

archive = ".tar.gz"
pkg_category = 0
pkg_name = 1
url_g = "https://download.savannah.nongnu.org/releases/m17n/"

async def get_latest_release(package, hub, **pkginfo):
    # Here we get the site, sorted by latest date on the top
    html = await hub.pkgtools.fetch.get_page(f"{url_g}?C=M&O=D")
    # Iterate all links in the page
    for a in BeautifulSoup(html, features="html.parser").find_all("a", href=True):
        href = a['href']
        # Check if the link begins with m17n-contrib, ends with .tar.gz and doesn't contain RC(Release Candidate) in the name
        if href.endswith(archive) and href.startswith(package[pkg_name]) and href.find("RC") == -1:
            return href

async def submit(package, hub, **pkginfo):
    result = await get_latest_release(package, hub, **pkginfo)
    
    # At the end there is a +1 because we need to remove the - before the version number
    version = result[:len(result) - len(archive)][len(package[pkg_name]) + 1:]
    url = f"{url_g}{result}"

    pkginfo["cat"] = package[pkg_category]
    pkginfo["name"] = package[pkg_name]
    tmpl_name = package[pkg_name] + ".tmpl"

    ebuild = hub.pkgtools.ebuild.BreezyBuild(
        **pkginfo,
        template=tmpl_name,
        version=version,
        artifacts=[hub.pkgtools.ebuild.Artifact(url=url)],
    )
    ebuild.push()

async def generate(hub, **pkginfo):
    packages = [[ "dev-db", "m17n-db" ], [ "dev-db", "m17n-contrib"], [ "dev-libs", "m17n-lib" ]]
    for package in packages:
        await submit(package, hub, **pkginfo)
