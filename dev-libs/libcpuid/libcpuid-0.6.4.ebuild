# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A small C library for x86 (and x86_64) CPU detection and feature extraction"
HOMEPAGE="http://libcpuid.sourceforge.net/"
SRC_URI="https://github.com/anrieff/libcpuid/tarball/f9b833d122efeea11a7c68c6e098db8717221543 -> libcpuid-0.6.4-f9b833d.tar.gz"
LICENSE="BSD-2"
SLOT="0/16"
KEYWORDS="*"
IUSE="static-libs"
S="${WORKDIR}/anrieff-libcpuid-f9b833d"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "$(use_enable static-libs static)"
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}