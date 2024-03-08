# Distributed under the terms of the GNU General Public License v2

EAPI=7

AT_M4DIR="config"
PYTHON_COMPAT=( python3+ )
DISTUTILS_OPTIONAL=1
inherit autotools distutils-r1

DESCRIPTION="libdnet provides a simplified, portable interface to several low-level networking routines."
HOMEPAGE="https://github.com/ofalk/libdnet"
SRC_URI="https://github.com/ofalk/libdnet/tarball/3dfbe889b1f65077efe579da34fc1d6819fcb7f3 -> libdnet-1.18.0-3dfbe88.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

DEPEND="
dev-libs/check
dev-libs/libbsd
python? ( ${PYTHON_DEPS} )"
RDEPEND="${DEPEND}"
BDEPEND="
	python? (
		dev-python/cython[${PYTHON_USEDEP}]
	)
"

DOCS=( README.md THANKS )

PATCHES=()

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv ofalk-libdnet* "${S}" || die
	fi
}

src_prepare() {
	default

	sed -i \
		-e 's/libcheck.a/libcheck.so/g' \
		-e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' \
		configure.ac || die
	sed -i \
		-e 's|-L$libdir ||g' \
		dnet-config.in || die
	sed -i \
		-e '/^SUBDIRS/s|python||g' \
		Makefile.am || die

	eautoreconf

	if use python; then
		cd python || die
		distutils-r1_src_prepare
	fi
}

src_configure() {
	econf \
		--disable-static \
		$(use_with python)
}

src_compile() {
	default
	if use python; then
		cd python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	if use python; then
		cd python || die
		unset DOCS
		distutils-r1_src_install
	fi

	find "${ED}" -name '*.la' -delete || die
}