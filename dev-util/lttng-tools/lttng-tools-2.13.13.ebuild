# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${P/_rc/-rc}"
MY_SLOT="$(ver_cut 1-2)"

DESCRIPTION="Linux Trace Toolkit - next generation"
HOMEPAGE="https://lttng.org"
SRC_URI="https://lttng.org/files/lttng-tools/lttng-tools-2.13.13.tar.bz2 -> lttng-tools-2.13.13.tar.bz2"

LICENSE="GPL-2"
SLOT="0/${MY_SLOT}"
KEYWORDS="*"
IUSE="+ust"

DEPEND="dev-libs/userspace-rcu:=
	dev-libs/popt
	dev-libs/libxml2
	ust? ( >=dev-util/lttng-ust-2.12.0:= )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(usex ust "" --without-lttng-ust) --disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}