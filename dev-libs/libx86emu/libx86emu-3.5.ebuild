# Distributed under the terms of the GNU General Public License v2
EAPI=7

inherit toolchain-funcs

DESCRIPTION="A library for emulating x86"
HOMEPAGE="https://github.com/wfeldt/libx86emu"
SRC_URI="https://github.com/wfeldt/libx86emu/tarball/41aaa2f246d362f6d7dea262052a43141743ead2 -> libx86emu-3.5-41aaa2f.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="*"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/*-"${PN}"-* "${S}"

	# Create a version file
	echo "${PV}" > "${S}"/VERSION

	# Remove changelog references in all
	sed -i 's/all: changelog shared/all: shared/g' "${S}"/Makefile
}

src_configure() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" install
	dodoc README.md LICENSE_INFO
}