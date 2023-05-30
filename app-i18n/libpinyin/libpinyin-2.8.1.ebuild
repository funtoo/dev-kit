# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/libpinyin/libpinyin"
fi

LIBPINYIN_MODEL_VERSION="19"

DESCRIPTION="Libraries for handling of Hanyu Pinyin and Zhuyin Fuhao"
HOMEPAGE="https://github.com/libpinyin/libpinyin https://sourceforge.net/projects/libpinyin/"
if [[ "${PV}" == "9999" ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/libpinyin/libpinyin/releases/download/2.8.1/libpinyin-2.8.1.tar.gz -> libpinyin-2.8.1.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0/13"
KEYWORDS="*"
IUSE=""

BDEPEND="virtual/pkgconfig"
DEPEND="dev-libs/glib:2
	sys-libs/db:="
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ "${PV}" == "9999" ]]; then
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi
}

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		--enable-libzhuyin \
		--disable-static
}

src_install() {
	default
	find "${D}" -name "*.la" -delete || die
}