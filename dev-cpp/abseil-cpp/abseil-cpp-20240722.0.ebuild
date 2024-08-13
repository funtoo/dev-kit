# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit cmake flag-o-matic python-any-r1 toolchain-funcs

DESCRIPTION="Abseil Common Libraries (C++), LTS Branch"
HOMEPAGE="https://abseil.io"
SRC_URI="
	https://api.github.com/repos/abseil/abseil-cpp/tarball/20240722.0 -> abseil-cpp-20240722.0.tar.gz
	test? ( https://api.github.com/repos/google/googletest/tarball/v1.15.2 -> googletest-1.15.2.tar.gz )
"
LICENSE="
	Apache-2.0
	test? ( BSD )
"
SLOT="0/${PV%%.*}"
KEYWORDS="*"
IUSE="test"

BDEPEND="
	${PYTHON_DEPS}
	test? ( sys-libs/timezone-data )
"

RESTRICT="!test? ( test )"

fix_src_dirs() {
	# We need this because the top dir in the tarballs use the first part of the
	# corresponding commit which changes every release
	
	pushd "${WORKDIR}"
	mv abseil-abseil-cpp-* ${P}
	mv google-googletest-* googletest-1.15.2
	popd
}

src_unpack() {
	default
	fix_src_dirs
}

src_prepare() {

	cmake_src_prepare

	# un-hardcode abseil compiler flags
	sed -i \
		-e '/"-maes",/d' \
		-e '/"-msse4.1",/d' \
		-e '/"-mfpu=neon"/d' \
		-e '/"-march=armv8-a+crypto"/d' \
		absl/copts/copts.py || die

	# now generate cmake files
	python_fix_shebang absl/copts/generate_copts.py
	absl/copts/generate_copts.py || die

	if use test; then
		sed -i 's/-Werror//g' \
			"${WORKDIR}"/googletest-1.15.2/googletest/cmake/internal_utils.cmake || die
	fi
}

src_configure() {
	if use arm || use arm64; then
		# Gentoo bug #778926
		if [[ $($(tc-getCXX) ${CXXFLAGS} -E -P - <<<$'#if defined(__ARM_FEATURE_CRYPTO)\nHAVE_ARM_FEATURE_CRYPTO\n#endif') != *HAVE_ARM_FEATURE_CRYPTO* ]]; then
			append-cxxflags -DABSL_ARCH_ARM_NO_CRYPTO
		fi
	fi

	local mycmakeargs=(
		-DABSL_ENABLE_INSTALL=TRUE
		-DABSL_LOCAL_GOOGLETEST_DIR="${WORKDIR}/googletest-1.15.2"
		-DCMAKE_CXX_STANDARD=17
		$(usex test -DBUILD_TESTING=ON '') #intentional usex
	)
	cmake_src_configure
}