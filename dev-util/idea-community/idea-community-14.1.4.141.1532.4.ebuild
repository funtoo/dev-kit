# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="0"
RDEPEND=">=virtual/jdk-1.7"

MY_PN="idea"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE (Community Edition)"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="http://download-cf.jetbrains.com/${MY_PN}/${MY_PN}IC-14.1.4.tar.gz"
LICENSE="Apache-2.0"
IUSE=""
KEYWORDS="amd64 x86"
S="${WORKDIR}/${MY_PN}-IC-141.1532.4"

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN}.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"

	newicon "bin/idea.png" "${PN}.png"
	make_wrapper ${PN} ${dir}/bin/${MY_PN}.sh
	make_desktop_entry ${PN} "IntelliJ IDEA(Community Edition)" ${PN} "Development;IDE"
}
