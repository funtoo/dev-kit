# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="$(get_major_version)"
if [ $(get_version_component_range 3) -eq 0 ]; then
	MY_PV="$(get_version_component_range 1-2)"
else
	MY_PV="$(get_version_component_range 1-3)"
fi

MY_BV="$(get_version_component_range 4-6)"
MY_PN="PhpStorm"

DESCRIPTION="Lightning-smart PHP IDE"
HOMEPAGE="http://www.jetbrains.com/phpstorm"
SRC_URI="http://download.jetbrains.com/webide/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="PhpStorm PhpStorm_Academic PhpStorm_Classroom PhpStorm_OpenSource PhpStorm_personal"
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
			fperms 755 -R ${dir}/jre/bin
		fi
	fi

	fperms 755 ${dir}/bin/{${PN}.sh,fsnotifier{,64}}

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	#make_desktop_entry "${PN}" "WebStorm" "${dir}/bin/webstorm.svg"
}
