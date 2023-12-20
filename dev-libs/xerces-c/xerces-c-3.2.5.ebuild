# Distributed under the terms of the GNU General Public License v2

EAPI=7
: ${CMAKE_MAKEFILE_GENERATOR:=ninja}

inherit cmake-utils prefix

DESCRIPTION="A validating XML parser written in a portable subset of C++"
HOMEPAGE="https://xerces.apache.org/xerces-c/"
SRC_URI="https://github.com/apache/xerces-c/tarball/53c16411466bf90c62617831fe92ed0f41e70882 -> xerces-c-3.2.5-53c1641.tar.gz"
KEYWORDS="*"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="cpu_flags_x86_sse2 curl doc elibc_Darwin elibc_FreeBSD examples iconv icu static-libs test threads"

RDEPEND="icu? ( dev-libs/icu:0= )
	curl? ( net-misc/curl )
	virtual/libiconv"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-lang/perl )"

DOCS=( CREDITS KEYS NOTICE README )
PATCHES=( )

pkg_setup() {
	export ICUROOT="${EPREFIX}/usr"

	if use iconv && use icu; then
		ewarn "This package can use iconv or icu for loading messages"
		ewarn "and transcoding, but not both. ICU takes precedence."
	fi
}

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv apache-xerces-c-* "${S}" || die
	fi
}

src_configure() {
	# 'cfurl' is only available on OSX and 'socket' isn't supposed to work.
	# But the docs aren't clear about it, so we would need some testing...
	local netaccessor
	if use curl; then
		netaccessor="curl"
	else
		netaccessor="socket"
	fi

	local msgloader
	if use icu; then
		msgloader="icu"
	elif use iconv; then
		msgloader="iconv"
	else
		msgloader="inmemory"
	fi

	local transcoder
	if use icu; then
		transcoder="icu"
	else
		transcoder="gnuiconv"
	fi

	local mycmakeargs=(
		-Dnetwork-accessor="${netaccessor}"
		-Dtranscoder="${transcoder}"
		-Dmessage-loader="${msgloader}"
		-Dthreads:BOOL="$(usex threads)"
		-Dsse2:BOOL="$(usex cpu_flags_x86_sse2)"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile doc-style createapidocs doc-xml
}

src_install () {
	cmake-utils_src_install

	# package provides .pc files
	find "${D}" -name '*.la' -delete || die

	if use examples; then
		# clean out object files, executables, Makefiles
		# and the like before installing examples
		find samples/ \( -type f -executable -o -iname 'runConfigure' -o -iname '*.o' \
			-o -iname '.libs' -o -iname 'Makefile*' \) -exec rm -rf '{}' + || die
		docinto examples
		dodoc -r samples/.
		docompress -x /usr/share/doc/${PF}/examples
	fi

	# To make sure an appropriate NLS msg file is around when using
	# the iconv msgloader ICU has the messages compiled in.
	if use iconv && ! use icu; then
		doenvd "$(prefixify_ro "${FILESDIR}/50xerces-c")"
	fi
}