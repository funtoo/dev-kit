# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator eutils

MY_PN="Visual_Paradigm_CE" #"for_UML_CE"
MY_P="${MY_PN}_$(get_version_component_range 1-2)"

if [[ $(get_version_component_count) == 3 ]]; then
	MY_PV="$(replace_all_version_separators _)"
	SRC_URI_FORMAT="https://%s.visual-paradigm.com/visual-paradigm/vpce$(get_version_component_range 1-2)/$(get_version_component_range 3)
		https://%s.visual-paradigm.com/archives/vpce$(get_version_component_range 1-2)/$(get_version_component_range 3)"
else
	MY_PV="$(replace_all_version_separators _ $(get_version_component_range 1-2))"
	MY_PV="${MY_PV}_sp$(get_version_component_range 3)"
	MY_PV="${MY_PV}_$(get_version_component_range 4)"
	SRC_URI_FORMAT="https://%s.visual-paradigm.com/visual-paradigm/${PN}$(get_version_component_range 1-2)/sp$(get_version_component_range 3)_$(get_version_component_range 4)
		https://%s.visual-paradigm.com/archives/${PN}$(get_version_component_range 1-2)/sp$(get_version_component_range 3)_$(get_version_component_range 4)"
fi

URIS=`printf "${SRC_URI_FORMAT} " eu{1..6} usa{1..6} uk{1..6}`

DESCRIPTION="Visual Paradigm for UML Comunity Version"
HOMEPAGE="http://www.visual-paradigm.com"

SRC_URI="amd64? ( `for URI in $URIS; do printf "${URI}/%s " "${MY_PN}_${MY_PV}_Linux64_InstallFree.tar.gz"; done` )"
#	x86? ( `for URI in $URIS; do printf "${URI}/%s " "${MY_PN}_${MY_PV}_Linux32_InstallFree.tar.gz"; done` )"

S="${WORKDIR}/${MY_P}"

LICENSE="as-is" # actually, proprietary
SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=">=virtual/jre-1.5
	x11-misc/xdg-utils
	sys-auth/polkit"

INSTDIR="/opt/Visual-Paradigm/${MY_PN}"

src_compile() {
	rm bin/VP-UML_Update || die

	sed -i -e '2i INSTALL4J_JAVA_HOME_OVERRIDE=$JAVA_HOME' \
		bin/Visual_Paradigm_* bin/VP-UML* || die
}

src_install() {
	insinto "${INSTDIR}"
	doins -r bin bundled integration lib ormlib \
		resources scripts sde shapes updatesynchronizer \
		UserLanguage .install4j

	rm "${D}${INSTDIR}"/.install4j/firstrun

	chmod +x "${D}${INSTDIR}"/bin/*
	#dodoc -r Samples

	make_desktop_entry "${INSTDIR}"/bin/${MY_P} "Visual Paradigm for UML" "${INSTDIR}"/resources/vpuml.png
	make_desktop_entry "pkexec ${INSTDIR}/bin/VP-UML_Product_Edition_Manager" "VP UML Product Edition Manager" "${INSTDIR}"/resources/vpuml.png

	dodir /etc/env.d
	cat - > "${D}"/etc/env.d/99visualparadigm <<EOF
CONFIG_PROTECT="${INSTDIR}/resources/product_edition.properties"
EOF
}
