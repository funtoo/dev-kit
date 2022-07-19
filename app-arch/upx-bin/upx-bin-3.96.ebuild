# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit pax-utils

MY_P="${PN/-bin}-${PV}"
DESCRIPTION="Ultimate Packer for eXecutables, binary version with proprietary NRV compression"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="
	x86? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-i386_linux.tar.xz -> upx-3.96-i386_linux.tar.xz )

	amd64? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz -> upx-3.96-amd64_linux.tar.xz )

	ppc? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-powerpc_linux.tar.xz -> upx-3.96-powerpc_linux.tar.xz )

	arm? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-armeb_linux.tar.xz -> upx-3.96-armeb_linux.tar.xz )

	arm64? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-arm64_linux.tar.xz -> upx-3.96-arm64_linux.tar.xz )

	mips? ( https://github.com/upx/upx/releases/download/v3.96/upx-3.96-mipsel_linux.tar.xz -> upx-3.96-mipsel_linux.tar.xz )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
RESTRICT="strip"
IUSE="doc"

RDEPEND="!app-arch/upx-ucl"

S="${WORKDIR}"

QA_PREBUILT="/opt/bin/upx"

src_install() {
	cd ${MY_P}*
	into /usr
	dobin upx
	pax-mark -m "${ED}"/opt/bin/upx
	doman upx.1
	dodoc upx.doc BUGS NEWS README* THANKS
	if use doc ; then
		local HTML_DOCS=( upx.html )
		einstalldocs
	fi
}