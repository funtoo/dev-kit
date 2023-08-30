# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A small C library for x86 (and x86_64) CPU detection and feature extraction"
HOMEPAGE="http://libcpuid.sourceforge.net/"
SRC_URI="https://github.com/anrieff/libcpuid/releases/download/v0.6.3/libcpuid-0.6.3.tar.gz -> libcpuid-0.6.3.tar.gz"
LICENSE="BSD-2"
SLOT="0/16"
KEYWORDS="*"
IUSE="static-libs"
S="${WORKDIR}/libcpuid-0.6.3"

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