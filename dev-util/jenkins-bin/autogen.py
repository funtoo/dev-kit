#!/usr/bin/env python3

from bs4 import BeautifulSoup


async def generate_ebuild(hub, rss_url, war_url, **pkginfo):

	war_url = war_url.rstrip("/")
	rss_xml = await hub.pkgtools.fetch.get_page(rss_url)
	bs = BeautifulSoup(rss_xml, "xml")

	for item in bs.rss.channel.find_all("item"):
		tag = item.guid.get_text().strip()
		version = tag.split("-", 1)[1]
		if version == "":
			continue

		url = f"{war_url}/{version}/jenkins.war"
		final_name = f"jenkins-bin-{version}.war"
		src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
		try:
			await src_artifact.fetch()
			break
		except hub.pkgtools.fetch.FetchError:
			continue

	ebuild = hub.pkgtools.ebuild.BreezyBuild(**pkginfo, version=version, artifacts=[src_artifact])
	ebuild.push()


async def generate(hub, **pkginfo):

	await generate_ebuild(
		hub, rss_url="https://www.jenkins.io/changelog/rss.xml", war_url="https://get.jenkins.io/war/", **pkginfo
	)

	pkginfo["name"] = "jenkins-lts-bin"
	await generate_ebuild(
		hub,
		rss_url="https://www.jenkins.io/changelog-stable/rss.xml",
		war_url="https://get.jenkins.io/war-stable/",
		**pkginfo,
	)


# vim: ts=4 sw=4 noet
