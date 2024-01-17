# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Small utility to modify the dynamic linker and RPATH of ELF executables"
HOMEPAGE="https://nixos.org/patchelf.html"
SRC_URI="https://github.com/NixOS/patchelf/tarball/99c24238981b7b1084313aca8f5c493bb46f302c -> patchelf-0.18.0-99c2423.tar.gz"
SLOT="0"
KEYWORDS="*"
LICENSE="GPL-3"

S="${WORKDIR}/NixOS-patchelf-99c2423"

src_prepare() {
	default
	rm src/elf.h || die

	sed -i \
	-e '/\(Elf_Off.*getPageSize())\)/s@getPageSize())@alignStartPage)@' \
	src/patchelf.cc || die

	sed -i \
	-e '/\(auto segEnd.*getPageSize())\)/s@getPageSize())@alignStartPage)@' \
	src/patchelf.cc || die

	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die

	# FL-9115: add missing import for optional
	sed -i \
		-e '1s/^/#include <optional>\n/' \
		src/patchelf.cc

	eautoreconf
}

src_test() {
	emake check \
		  CFLAGS+=" -no-pie" \
		  CXXFLAGS+=" -no-pie"
}