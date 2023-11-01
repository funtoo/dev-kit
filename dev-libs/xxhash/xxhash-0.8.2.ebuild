# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Extremely fast non-cryptographic hash algorithm"
HOMEPAGE="https://xxhash.com/"
SRC_URI="https://github.com/Cyan4973/xxHash/tarball/bbb27a5efb85b92a0486cf361a8635715a53f6ba -> xxHash-0.8.2-bbb27a5.tar.gz"
S="${WORKDIR}/Cyan4973-xxHash-bbb27a5"

LICENSE="BSD-2 GPL-2+"
SLOT="0"
KEYWORDS="*"

src_install() {	
	local emakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}"/usr
		LIBDIR="${EPREFIX}"/usr/$(get_libdir)
	)

	emake "${emakeargs[@]}" install
	einstalldocs

	rm "${ED}"/usr/$(get_libdir)/libxxhash.a || die
}