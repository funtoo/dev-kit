# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="$(get_major_version)"
MY_PV="$(get_version_component_range 1-3)"
MY_BV="$(get_version_component_range 4-6)"
MY_PN="WebStorm"

DESCRIPTION="JavaScript IDE for complex client-side development and server-side development with Node.js"
HOMEPAGE="http://www.jetbrains.com/webstorm"
SRC_URI="http://download.jetbrains.com/${PN}/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="WebStorm WebStorm_Academic WebStorm_Classroom WebStorm_OpenSource WebStorm_personal"
IUSE="-custom-jdk"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="!amd64? ( !custom-jdk )"

RDEPEND="!custom-jdk? ( >=virtual/jdk-1.7 )"
S="${WORKDIR}/${MY_PN}-${MY_BV}"

src_prepare() {
	if ! use custom-jdk; then
		if [[ -d jre64 ]]; then
			rm -r jre64 || die
		fi
	fi
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r .

	if use custom-jdk; then
		if [[ -d jre64 ]]; then
			fperms 755 -R ${dir}/jre64/bin
		fi
	fi

	fperms 755 ${dir}/bin/{${PN}.sh,fsnotifier{,64}}

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	#make_desktop_entry "${PN}" "WebStorm" "${dir}/bin/webstorm.svg"
}
