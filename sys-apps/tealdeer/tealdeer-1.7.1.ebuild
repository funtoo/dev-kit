# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo bash-completion-r1

DESCRIPTION="A very fast implementation of tldr in Rust."
HOMEPAGE="https://github.com/dbrgn/tealdeer https://dbrgn.github.io/tealdeer/"
SRC_URI="https://github.com/dbrgn/tealdeer/tarball/9b2122ed28d220593e510c362c10102d6bcf5722 -> tealdeer-1.7.1-9b2122e.tar.gz
https://direct.funtoo.org/0c/78/37/0c7837d963cfc126ef838cbbb65c531e68e60265736f4d37a19a728fccc9f7e166e74961d62b42f2ad3632c51eb2f343c04421ccb989d61071b542ae5c1f222b -> tealdeer-1.7.1-funtoo-crates-bundle-43da2286fdbec9cb8cf32eb44e0eeedc464654c63f4abcb17df466afa311bda447ff2cc1805347988b150bc8460c16a86f4cc6f603d9d10dcadd4bdb0f3ed128.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="+bash-completion zsh-completion fish-completion"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="usr/bin/tldr"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/dbrgn-tealdeer-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs

	use bash-completion && newbashcomp completion/bash_tealdeer tldr

	use zsh-completion && {
		insinto /usr/share/zsh/site-functions
		newins completion/zsh_tealdeer _tldr
	}

	use fish-completion && {
		insinto /usr/share/fish/vendor_completions.d
		newins completion/fish_tealdeer tldr.fish
	}
}