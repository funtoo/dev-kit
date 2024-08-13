# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

go-module_set_globals

SRC_URI="https://github.com/kubernetes-sigs/cri-tools/tarball/ea669ca726b21585ee9c94276391eea5b486da46 -> cri-tools-1.31.1-ea669ca.tar.gz
https://direct.funtoo.org/25/b5/37/25b5373c52c94a4a23634bfe14b7cfadbf7b9812cac6dacc63bce885c2b685264080f4cfa8873dec88e1b029265c47b283bd71a367f67f541422f16715bde5c7 -> cri-tools-1.31.1-funtoo-go-bundle-142e2eabfa4a58ee3cda08136ada1ae200b8789d9fe7bb6a42792eba066c3c1e6dbce92ed728e3740d8f07b97e57fa0726b15f346b948ec35a9c7d5d7a87a36f.tar.gz"

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