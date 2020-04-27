# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop gnome3-utils xdg

SLOT=0

SRC_URI="https://download.jetbrains.com/go/goland-2020.1.1.tar.gz -> goland-2020.1.tar.gz"
DESCRIPTION="Golang IDE by JetBrains"
HOMEPAGE="https://www.jetbrains.com/go"

KEYWORDS="*"

LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual )
	Apache-2.0
	BSD
	CC0-1.0
	CDDL
	CDDL-1.1
	EPL-1.0
	GPL-2
	GPL-2-with-classpath-exception
	ISC
	LGPL-2.1
	LGPL-3
	MIT
	MPL-1.1
	OFL
	ZLIB
"

RESTRICT="bindist mirror"

QA_PREBUILT="opt/${P}/*"

S="${WORKDIR}/GoLand-${PV}"

RDEPEND="
	virtual/jdk
	dev-lang/go
"

src_install() {
	local dir="/opt/${P}"
	local dst="${D}${dir}"

	insinto "${dir}"
	mv "${S}"/* "${dst}"

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "${dst}/bin/${PN}.png" "${PN}.png"
	make_desktop_entry "${PN}" "goland" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/" || die
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome3_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome3_icon_cache_update
}