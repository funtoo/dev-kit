# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3+ )

inherit autotools python-any-r1

DESCRIPTION="The Chinese PinYin and Bopomofo conversion library"
HOMEPAGE="https://github.com/pyzy/pyzy"
SRC_URI="https://github.com/openSUSE/pyzy/archive/refs/tags/1.1.tar.gz -> 1.1.tar.gz
	https://github.com/openSUSE/pyzy-database/archive/refs/tags/1.0.0.tar.gz -> 1.0.0.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="boost doc opencc"

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	sys-apps/util-linux
	boost? ( dev-libs/boost )
	opencc? ( app-i18n/opencc:= )"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	sys-devel/autoconf-archive
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/pyzy-database-* "${WORKDIR}"/pyzy-database
}

src_prepare() {
	./autogen.sh

	sed -i '/wget/d' "${S}"/data/db/open-phrase/Makefile.am
	sed -i '/tar/d' "${S}"/data/db/open-phrase/Makefile.am

	mv "${WORKDIR}"/pyzy-database/db data/db/open-phrase || die
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable boost) \
		$(use_enable opencc) \
		--enable-db-open-phrase \
		DOXYGEN=$(usex doc doxygen true)
}

src_install() {
	if use doc; then
		HTML_DOCS=( docs/html/. )
	fi

	default
	find "${ED}" -name '*.la' -delete || die
}
