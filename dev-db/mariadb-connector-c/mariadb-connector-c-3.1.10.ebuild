# Distributed under the terms of the GNU General Public License v2

EAPI=6

VCS_INHERIT=""
MY_PN=${PN#mariadb-}
MY_PV=${PV/_b/-b}
SRC_URI="https://downloads.mariadb.org/f/${MY_PN}-${PV%_beta}/${PN}-${MY_PV}-src.tar.gz?serve -> ${P}-src.tar.gz"
S="${WORKDIR%/}/${PN}-${MY_PV}-src"
KEYWORDS="*"

inherit cmake-utils multilib-minimal toolchain-funcs ${VCS_INHERIT}

MULTILIB_CHOST_TOOLS=( /usr/bin/mariadb_config )

MULTILIB_WRAPPED_HEADERS+=(
	/usr/include/mariadb/mariadb_version.h
)

DESCRIPTION="C client library for MariaDB/MySQL"
HOMEPAGE="https://mariadb.org/"
LICENSE="LGPL-2.1"

SLOT="0/3"
IUSE="+curl gnutls kerberos libressl +ssl static-libs test"

DEPEND="sys-libs/zlib:=[${MULTILIB_USEDEP}]
	virtual/libiconv:=[${MULTILIB_USEDEP}]
	curl? ( net-misc/curl:0=[${MULTILIB_USEDEP}] )
	ssl? (
		gnutls? ( >=net-libs/gnutls-3.3.24:0=[${MULTILIB_USEDEP}] )
		!gnutls? (
			libressl? ( dev-libs/libressl:0=[${MULTILIB_USEDEP}] )
			!libressl? ( dev-libs/openssl:0=[${MULTILIB_USEDEP}] )
		)
	)
	"
RDEPEND="${DEPEND}"
PATCHES=(
	"${FILESDIR}"/gentoo-layout-3.0.patch
	"${FILESDIR}"/${PN}-3.1.3-fix-pkconfig-file.patch
)

src_configure() {
	# bug 508724 mariadb cannot use ld.gold
	tc-ld-disable-gold
	multilib-minimal_src_configure
}

multilib_src_configure() {
	local mycmakeargs=(
		-DWITH_EXTERNAL_ZLIB=ON
		-DWITH_SSL:STRING=$(usex ssl $(usex gnutls GNUTLS OPENSSL) OFF)
		-DWITH_CURL=$(usex curl ON OFF)
		-DMARIADB_UNIX_ADDR="${EPREFIX%/}/var/run/mysqld/mysqld.sock"
		-DINSTALL_LIBDIR="$(get_libdir)"
		-DINSTALL_PCDIR="$(get_libdir)/pkgconfig"
		-DINSTALL_PLUGINDIR="$(get_libdir)/mariadb/plugin"
		-DINSTALL_BINDIR=bin
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
	)
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	cmake-utils_src_install
}

multilib_src_install_all() {
	if ! use static-libs ; then
		find "${D}" -name "*.a" -delete || die
	fi
}
