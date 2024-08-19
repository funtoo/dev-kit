# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 eutils toolchain-funcs

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"
SRC_URI=" 
	test? ( https://github.com/radareorg/radare2-testbins/tarball/b2251d5667e3fc82822ee139b9e682d7a22e4f40 -> radare2-testbins-20240819-b2251d5.tar.gz )
	https://github.com/radareorg/radare2/tarball/b77e3f8ed651b6866175062213158e2b33d2c1e7 -> radare2-5.9.4-b77e3f8.tar.gz
	https://github.com/radareorg/vector35-arch-arm64/tarball/c9e7242972837ac11fc94db05fabcb801a8269c9 -> radare2-vector35-arch-arm64-20220609-c9e7242.tar.gz
	https://github.com/radareorg/vector35-arch-armv7/tarball/f270a6cc99644cb8e76055b6fa632b25abd26024 -> radare2-vector35-arch-armv7-20230120-f270a6c.tar.gz"

LICENSE="GPL-2"

KEYWORDS="*"
SLOT="0"
IUSE="ssl libressl test"

RDEPEND="
	dev-libs/libzip
	dev-libs/xxhash
	sys-apps/file
	sys-libs/zlib
	dev-libs/capstone:0=
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"


post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv radareorg-radare2* "${S}" || die
	fi

	mv radareorg-vector35-arch-arm64-* "${S}/libr/arch/p/arm/v35/arch-arm64" || die
	mv radareorg-vector35-arch-armv7-* "${S}/libr/arch/p/arm/v35/arch-armv7" || die

	if use test; then
		cp -r radare2-testbins-* "${S}/test/bins" || die
		cp -r radare2-testbins-* "${S}" || die
	fi

}

src_prepare() {
	# Fix hardcoded docdir for fortunes
	sed -i -e "/^#define R2_FORTUNES/s/radare2/$PF/" \
		libr/include/r_userconf.h.acr

	default
}

src_configure() {
	# Ideally these should be set by ./configure
	tc-export CC AR LD OBJCOPY RANLIB
	export HOST_CC=${CC}

	econf \
		--without-libuv \
		--with-syscapstone \
		--with-sysmagic \
		--with-sysxxhash \
		--with-syszip \
		$(use_with ssl openssl)
}

src_install() {
	default

	insinto /usr/share/zsh/site-functions
	doins doc/zsh/_*

	newbashcomp doc/bash_autocompletion.sh "${PN}"
	bashcomp_alias "${PN}" rafind2 r2 rabin2 rasm2 radiff2

	# a workaround for unstable $(INSTALL) call, bug #574866
	local d
	for d in doc/*; do
		if [[ -d $d ]]; then
			rm -rfv "$d" || die "failed to delete '$d'"
		fi
	done

	# These are not really docs. radare assumes
	# uncompressed files: bug #761250
	docompress -x /usr/share/doc/${PF}/fortunes.{creepy,fun,nsfw,tips}
}