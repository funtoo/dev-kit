# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson ninja-utils multilib-minimal

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
SRC_URI="https://github.com/fribidi/fribidi/releases/download/v1.0.16/fribidi-1.0.16.tar.xz -> fribidi-1.0.16.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"

IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv fribidi-fribidi-* "${S}" || die
	fi
}

multilib_src_configure() {
	local emesonargs=(
		-Ddeprecated=true
		$(meson_use doc docs)
		-Dbin=true
		$(meson_use test tests)
	)
	meson_src_configure
}

multilib_src_compile() {
	eninja
}

multilib_src_install() {
	DESTDIR="${D}" eninja install

	if use doc; then
		# Compress the man pages
		for man in "${D}"/usr/share/man/man3/*; do
			bzip2 "${man}" || die
		done
	fi
}