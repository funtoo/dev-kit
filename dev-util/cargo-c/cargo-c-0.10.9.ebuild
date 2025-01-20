# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SRC_URI="https://github.com/lu-zero/cargo-c/tarball/578b4ed8a8baa9faa42a072ca40b7267b125fc15 -> cargo-c-0.10.9-578b4ed.tar.gz
https://direct.funtoo.org/de/e9/c1/dee9c133488fe909d09bea8ce3e3b5e26972627d7463a2725123dabbef7e0f039126d1ff7d424f6a63e53cf7763bd53a54a4cabebab6666b9c9426d05e14627e -> cargo-c-0.10.9-funtoo-crates-bundle-959041c1d7848cf6da788f8bd6e64aa25e5c3c4273e6ade81b9581904071ead05616c83e6a5516e7646e46bfb8e37bb5814af021b4d077bd6dff5627b4167d35.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="sys-libs/zlib
	dev-libs/openssl:0=
	dev-vcs/git
	net-misc/curl[ssl]
"
BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/lu-zero-cargo-c-* ${S} || die
}