# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

go-module_set_globals

SRC_URI="https://github.com/kubernetes-sigs/cri-tools/tarball/3c91ebf539bd2035d60813386f5b1f023937423f -> cri-tools-1.28.0-3c91ebf.tar.gz
https://direct.funtoo.org/74/d8/e0/74d8e0d9ab6377ba468e5cf9ff75c866378353d4a62d1f2b42fe76b9542a693f9b35f329dd0e4a8d2b359da2107df3575c63cd38ff88cc7cc9fc0b0770301bd1 -> cri-tools-1.28.0-funtoo-go-bundle-3d626ae5066af040da989c16e69df5db7a638c5eda67148a4a31255fc12054df02988e1ac533331130a06c18d2ac60a61326cfce07047fe030118906583f052d.tar.gz"

DESCRIPTION="CLI and validation tools for Kubelet Container Runtime (CRI)"
HOMEPAGE="https://github.com/kubernetes-sigs/cri-tools"

LICENSE="Apache-2.0 BSD BSD-2 CC-BY-SA-4.0 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

RESTRICT+=" test"

src_unpack() {
	go-module_src_unpack
	if [ ! -d "${S}" ]; then
		mv kubernetes-sigs-cri-tools* "${S}" || die
	fi
}

src_compile() {
	emake VERSION="${PV}"
	./build/bin/linux/amd64/crictl completion bash > "${PN}.bash" || die
	./build/bin/linux/amd64/crictl completion zsh > "${PN}.zsh" || die
}

src_install() {
	dobin ./build/bin/linux/amd64/crictl

	newbashcomp ${PN}.bash ${PN}
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}

	dodoc -r docs {README,RELEASE,CHANGELOG,CONTRIBUTING}.md
}