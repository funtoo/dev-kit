# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator eapi7-ver

MAIN_VERSION="$(get_version_component_range 1-2)"
RNAME="${MAIN_VERSION/./-}"
if [ $(get_version_component_range 3) -eq 0 ]; then
	SR="R"
else
	SR="$(get_version_component_range 3)"
fi

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-java-${RNAME}-${SR}-linux-gtk-x86_64.tar.gz -> eclipse-java-${RNAME}-${SR}-linux-gtk-x86_64-${PV}.tar.gz"

LICENSE="EPL-1.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	>=virtual/jdk-1.8
	x11-libs/gtk+:2"

S=${WORKDIR}/eclipse

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	dohtml -r readme/*

	cp "${FILESDIR}"/eclipserc-bin "${T}" || die
	cp "${FILESDIR}"/eclipse-bin "${T}" || die
	sed "s@%SLOT%@${SLOT}@" -i "${T}"/eclipse{,rc}-bin || die

	insinto /etc
	newins "${T}"/eclipserc-bin eclipserc-bin-${SLOT}

	newbin "${T}"/eclipse-bin eclipse-bin-${SLOT}
	make_desktop_entry "eclipse-bin-${SLOT}" "Eclipse ${PV} (bin)" "${dest}/icon.xpm"
}
