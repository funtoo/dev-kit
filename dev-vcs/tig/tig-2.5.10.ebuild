# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

HOMEPAGE="https://jonas.github.io/tig/"
SRC_URI="https://github.com/jonas/tig/releases/download/tig-2.5.10/tig-2.5.10.tar.gz -> tig-2.5.10.tar.gz"
KEYWORDS="*"

DESCRIPTION="text mode interface for git"

LICENSE="GPL-2"
SLOT="0"
IUSE="test unicode"
REQUIRED_USE="test? ( unicode )"

DEPEND="
	sys-libs/ncurses:0=
	sys-libs/readline:0="
RDEPEND="${DEPEND}
	dev-vcs/git"

# encoding/env issues
RESTRICT="test"

src_prepare() {
	default
}

src_configure() {
	econf $(use_with unicode ncursesw)
}

src_compile() {
	emake V=1
}

src_test() {
	# workaround parallel test failures
	emake -j1 test
}

src_install() {
	emake DESTDIR="${D}" install install-doc-man
	dodoc doc/manual.html README.html NEWS.html
	newbashcomp contrib/tig-completion.bash ${PN}

	docinto examples
	dodoc contrib/*.tigrc
}