#!/usr/bin/env python3

from bs4 import BeautifulSoup
import re
from packaging import version as pversion


async def generate(hub, **pkginfo):
	archive_baseurl= f"https://sourceware.org/ftp/debugedit/"
	url            = f"https://sourceware.org/git/?p=debugedit.git;a=tags"
	
	html_data = await hub.pkgtools.fetch.get_page(url)
	soup = BeautifulSoup(html_data, "html.parser")
	#import pdb;pdb.set_trace()
	pattern = re.compile(r"/git\?p=debugedit.git;a=commit;h=[0-9a-f]{40}")
	links = []
	for link in soup.find_all("a",{'class','list name'}):
		href = link.get("href")
		if pattern.match(href):
			# split by version,  link object
			links.append((pversion.Version(link.text.split('-',1)[1]), link))
	links = sorted(links, key = lambda k : k[0], reverse = True)
	latest_version = links[0]
	
	patches  = []
	url_data = None
	url_sig  = None
	
	url_data = f"{archive_baseurl}/{latest_version[0]}/debugedit-{latest_version[0]}.tar.xz"
	
	if latest_version[0] == pversion.Version('5.0'): 
		patches+=['debugedit-5.0-funtoo-patch-collection.patch', ] # combined git commits into single patch
	
	patches+= ["debugedit-5.0-musl-error.h-fix.patch"]
	
	version=f"{latest_version[0]}-r1" # add r1, to indicate there are patches
	
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version =version,
		patches = patches,
		artifacts=[hub.pkgtools.ebuild.Artifact(url_data)],
	)
	ebuild.push()
# vim: ts=4 sw=4 noet
