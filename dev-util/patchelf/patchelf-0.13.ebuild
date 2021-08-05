# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Small utility to modify the dynamic linker and RPATH of ELF executables"
HOMEPAGE="https://nixos.org/patchelf.html"
SRC_URI="https://github.com/NixOS/patchelf/archive/0.13.tar.gz -> patchelf-0.13.tar.gz"
SLOT="0"
KEYWORDS="*"
LICENSE="GPL-3"

src_prepare() {
	default
	rm src/elf.h || die

	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die

	eautoreconf
}

src_test() {
	emake check \
		  CFLAGS+=" -no-pie" \
		  CXXFLAGS+=" -no-pie"
}