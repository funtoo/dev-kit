# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

SCONS_MIN_VERSION="3.3.1"
CHECKREQS_DISK_BUILD="2400M"
CHECKREQS_DISK_USR="512M"
CHECKREQS_MEMORY="1024M"

inherit check-reqs flag-o-matic multiprocessing pax-utils python-any-r1 scons-utils toolchain-funcs user

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="https://www.mongodb.com"
SRC_URI="https://api.github.com/repos/mongodb/mongo/tarball/refs/tags/r4.4.5 -> mongodb-4.4.5.tar.gz"

LICENSE="Apache-2.0 SSPL-1"
SLOT="0"
KEYWORDS="*"
IUSE="debug kerberos libressl lto ssl test +tools"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-arch/snappy-1.1.3
	>=dev-cpp/yaml-cpp-0.6.2:=
	>=dev-libs/boost-1.70:=[threads(+),nls]
	>=dev-libs/libpcre-8.42[cxx]
	app-arch/zstd
	dev-libs/snowball-stemmer
	net-libs/libpcap
	>=sys-libs/zlib-1.2.11:=
	kerberos? ( dev-libs/cyrus-sasl[kerberos] )
	ssl? (
		!libressl? ( >=dev-libs/openssl-1.0.1g:0= )
		libressl? ( dev-libs/libressl:0= )
	)"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		test? ( dev-python/pymongo[${PYTHON_USEDEP}] dev-python/requests[${PYTHON_USEDEP}] )
		>=dev-util/scons-3.1.1[${PYTHON_USEDEP}]
		dev-python/cheetah3[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	')
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	debug? ( dev-util/valgrind )"
PDEPEND="tools? ( >=app-admin/mongo-tools-100 )"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.1-fix-scons.patch"
	"${FILESDIR}/${PN}-4.4.5-no-compass.patch"
	"${FILESDIR}/${PN}-4.4.1-boost.patch"
)

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/mongodb-mongo-* "${S}" || die
}

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb

	python-any-r1_pkg_setup
}

python_check_deps() {
	if use test; then
		has_version "dev-python/pymongo[${PYTHON_USEDEP}]" || return 1
		has_version "dev-python/requests[${PYTHON_USEDEP}]" || return 1
	fi

	has_version ">=dev-util/scons-2.5.0[${PYTHON_USEDEP}]" &&
	has_version "dev-python/cheetah3[${PYTHON_USEDEP}]" &&
	has_version "dev-python/psutil[${PYTHON_USEDEP}]" &&
	has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

pkg_pretend() {
	if [[ -n ${REPLACING_VERSIONS} ]]; then
		if ver_test "$REPLACING_VERSIONS" -lt 4.2; then
			ewarn "To upgrade from a version earlier than the 4.2-series, you must"
			ewarn "successively upgrade major releases until you have upgraded"
			ewarn "to 4.2-series. Then upgrade to 4.4 series."
		else
			ewarn "Be sure to set featureCompatibilityVersion to 4.2 before upgrading."
		fi
	fi
}

src_prepare() {
	default

	# remove bundled libs
	rm -r src/third_party/{boost-*,pcre-*,scons-*,snappy-*,yaml-cpp-*,zlib-*} || die

	# remove compass
	rm -r src/mongo/installer/compass || die
}

src_configure() {
	# https://github.com/mongodb/mongo/wiki/Build-Mongodb-From-Source
	# --use-system-icu fails tests
	# --use-system-tcmalloc is strongly NOT recommended:
	scons_opts=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		MONGO_VERSION="${PV}"

		--disable-warnings-as-errors
		--use-system-boost
		--use-system-pcre
		--use-system-snappy
		--use-system-stemmer
		--use-system-yaml
		--use-system-zlib
		--use-system-zstd
	)

	use arm64 && scons_opts+=( --use-hardware-crc32=off ) # Bug 701300
	use debug && scons_opts+=( --dbg=on )
	use kerberos && scons_opts+=( --use-sasl-client )
	use lto && scons_opts+=( --lto=on )
	use ssl && scons_opts+=( --ssl )

	# respect mongoDB upstream's basic recommendations
	# see bug #536688 and #526114
	if ! use debug; then
		filter-flags '-m*'
		filter-flags '-O?'
	fi

	default
}

src_compile() {
	PREFIX="${ED}"/usr escons "${scons_opts[@]}" --nostrip install-core
}

# FEATURES="test -usersandbox" emerge dev-db/mongodb
src_test() {
	ewarn "Tests may hang with FEATURES=usersandbox"
	"${EPYTHON}" ./buildscripts/resmoke.py run --dbpathPrefix=test --suites core --jobs=$(makeopts_jobs) || die "Tests failed with ${EPYTHON}"
}

src_install() {
	dobin build/install/bin/{mongo,mongod,mongos}

	doman debian/mongo*.1
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd-r3" ${PN}
	newconfd "${FILESDIR}/${PN}.confd-r3" ${PN}
	newinitd "${FILESDIR}/mongos.initd-r3" mongos
	newconfd "${FILESDIR}/mongos.confd-r3" mongos

	insinto /etc
	newins "${FILESDIR}/${PN}.conf-r3" ${PN}.conf
	newins "${FILESDIR}/mongos.conf-r2" mongos.conf

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	# see bug #526114
	pax-mark emr "${ED}"/usr/bin/{mongo,mongod,mongos}

	local x
	for x in /var/{lib,log}/${PN}; do
		diropts -m0750 -o mongodb -g mongodb
		keepdir "${x}"
	done
}

pkg_postinst() {
	ewarn "Make sure to read the release notes and follow the upgrade process:"
	ewarn "  https://docs.mongodb.com/manual/release-notes/$(ver_cut 1-2)/"
	ewarn "  https://docs.mongodb.com/manual/release-notes/$(ver_cut 1-2)/#upgrade-procedures"
}