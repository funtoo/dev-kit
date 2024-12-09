# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

go-module_set_globals

SRC_URI="https://github.com/kubernetes-sigs/cri-tools/tarball/b5cf674bb19f574ee488c991ac813c76c08eedaf -> cri-tools-1.32.0-b5cf674.tar.gz
https://direct.funtoo.org/5f/fa/46/5ffa46be9f7d10169fd02e4afb74744c41a70e3d2b3144ba30ef5ae7800997eb0a420ee20ea242845ce469a9acd83d6b33adb2af639b496cf1136c24a094cfb6 -> cri-tools-1.32.0-funtoo-go-bundle-9ffb872fa2e3ed538404e1aefde2233a44ae97307dea0cf7a79a999e6b85cfffd4df2e09321c58cbd037142135c9562a0b03d6e54ce089c630b4b0ad631423d9.tar.gz"

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