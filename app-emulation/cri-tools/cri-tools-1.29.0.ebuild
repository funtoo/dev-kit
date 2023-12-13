# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

go-module_set_globals

SRC_URI="https://github.com/kubernetes-sigs/cri-tools/tarball/3b3a9479260a5d9926c596ae068e9c51110cf546 -> cri-tools-1.29.0-3b3a947.tar.gz
https://direct.funtoo.org/ee/bf/27/eebf27ab768e4903d0ae32de97556427f1b228a264215ba2021317327fdcaae695e151bb110d6be965d01d9a605e98e5cc13c968d7974df1f5dfd0ba32ab5ff5 -> cri-tools-1.29.0-funtoo-go-bundle-4d9e39158fff0e3e4224cfd55d6c4d332e7ed34bffaaeccb538e9a1f253a29d71b8c7abc3849423de6889d184617fd6eae6ec1166566f5b175c5e97306ecf244.tar.gz"

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