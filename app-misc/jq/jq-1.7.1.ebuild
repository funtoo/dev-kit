# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.io/jq/"
SRC_URI="https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-1.7.1.tar.gz -> jq-1.7.1.tar.gz"
S="${WORKDIR}/jq-1.7.1"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="+oniguruma static-libs"

DEPEND="
	sys-devel/bison
	sys-devel/flex
	oniguruma? ( dev-libs/oniguruma:=[static-libs?] )
"
RDEPEND="
	!static-libs? (
		oniguruma? ( dev-libs/oniguruma[static-libs?] )
	)
"

PATCHES=(
	"${FILESDIR}"/jq-never-bundle-oniguruma.patch
)

src_prepare() {
	cat "${FILESDIR}"/jq-runpath.ac >> configure.ac

	sed -i '/^dist_doc_DATA/d' Makefile.am || die
	sed -i -r "s:(m4_define\(\[jq_version\],) .+\):\1 \[${PV}\]):" \
		configure.ac || die

	# jq-never-bundle-oniguruma makes sure we build with the system oniguruma,
	# but the bundled copy of oniguruma still gets eautoreconf'd since it
	# exists; save the cycles by nuking it.
	sed -i -e '/modules\/oniguruma/d' Makefile.am || die
	rm -rf "${S}"/modules/oniguruma || die

	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		# don't try to rebuild docs
		--disable-docs
		--disable-valgrind
		--disable-maintainer-mode
		--enable-rpathhack
		$(use_enable static-libs static)
		$(use_with oniguruma oniguruma yes)
	)
	econf "${econfargs[@]}"
}

src_install() {
	local DOCS=( AUTHORS README.md )
	default

	use static-libs || { find "${D}" -name '*.la' -delete || die; }
}