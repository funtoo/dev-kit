# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN#mariadb-}
MY_PV=${PV/_b/-b}
SRC_URI="https://downloads.mariadb.org/f/${MY_PN}-${PV%_beta}/${PN}-${MY_PV}-src.tar.gz?serve -> ${P}-src.tar.gz"
S="${WORKDIR%/}/${PN}-${MY_PV}-src"
KEYWORDS="*"

CMAKE_ECLASS=cmake
inherit cmake toolchain-funcs

DESCRIPTION="C client library for MariaDB/MySQL"
HOMEPAGE="https://mariadb.org/"
LICENSE="LGPL-2.1"

SLOT="0/3"
IUSE="+curl gnutls kerberos libressl +ssl static-libs test"

RESTRICT="!test? ( test )"

DEPEND="sys-libs/zlib:=
	virtual/libiconv:=
	curl? ( net-misc/curl:0= )
	kerberos? ( || ( app-crypt/mit-krb5
			app-crypt/heimdal ) )
	ssl? (
		gnutls? ( >=net-libs/gnutls-3.3.24:0= )
		!gnutls? (
			libressl? ( dev-libs/libressl:0= )
			!libressl? ( dev-libs/openssl:0= )
		)
	)
	"
RDEPEND="${DEPEND}"
PATCHES=(
	"${FILESDIR}"/gentoo-layout-3.0.patch
	"${FILESDIR}"/${PN}-3.1.3-fix-pkconfig-file.patch
	"${FILESDIR}"/${PN}-3.1.11-fix-flow-control-statement.patch
)

src_configure() {
	# bug 508724 mariadb cannot use ld.gold
	tc-ld-disable-gold

	local mycmakeargs=(
		-DWITH_EXTERNAL_ZLIB=ON
		-DWITH_SSL:STRING=$(usex ssl $(usex gnutls GNUTLS OPENSSL) OFF)
		-DWITH_CURL=$(usex curl ON OFF)
		-DWITH_ICONV=ON
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT:STRING=$(usex kerberos DYNAMIC OFF)
		-DMARIADB_UNIX_ADDR="${EPREFIX}/var/run/mysqld/mysqld.sock"
		-DINSTALL_LIBDIR="$(get_libdir)"
		-DINSTALL_PCDIR="$(get_libdir)/pkgconfig"
		-DINSTALL_PLUGINDIR="$(get_libdir)/mariadb/plugin"
		-DINSTALL_BINDIR=bin
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}

src_install_all() {
	if ! use static-libs ; then
		find "${ED}" -name "*.a" -delete || die
	fi
}
