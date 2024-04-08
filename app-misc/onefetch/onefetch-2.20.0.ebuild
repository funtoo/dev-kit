# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Command-line Git information tool"
HOMEPAGE="https://github.com/o2sh/onefetch"
SRC_URI="https://github.com/o2sh/onefetch/tarball/24878137250919d4acbebb810dcb5f164d948e17 -> onefetch-2.20.0-2487813.tar.gz
https://direct.funtoo.org/f9/e7/d1/f9e7d161a374503713e7ce0347944efb7a5df6ec11e5f1478feafa42e6bce3dc4c7326d1574c23964f77d8316da0f758b1dca75b1aaf4174a915b30b4124448c -> onefetch-2.20.0-funtoo-crates-bundle-1d5e0337dff0c10798323d0661b24fc01634f72f79f46476de2bac96b6297b7b83675a00d695c6fc12682c788292d28ce63583f62a1f948a8580376402e49978.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="/usr/bin/onefetch"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/o2sh-onefetch-* ${S} || die
}