# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Git submodule alternative"
HOMEPAGE="https://github.com/ingydotnet/git-subrepo"
SRC_URI="https://github.com/ingydotnet/git-subrepo/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}"

src_install() {
	install -d ${D}/usr/lib/git-core
	make INSTALL_LIB="${D}/usr/lib/git-core" PREFIX="${D}/usr" install

	install -Dm644 "share/completion.bash" \
		"${D}/usr/share/bash-completion/completions/git-subrepo"
	install -Dm644 "share/zsh-completion/_git-subrepo" \
		"${D}/usr/share/zsh/site-functions/_git-subrepo"
	
	install -Dm644 License "${D}/usr/share/licenses/${P}/LICENSE"
}

pkg_postinst() {
	ln -sf /usr/lib/git-core/git-subrepo /usr/bin/git-subrepo
}
