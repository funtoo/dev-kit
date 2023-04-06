# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29"
	"golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220421235706-1d1ef9303861"
	"golang.org/x/net v0.0.0-20220421235706-1d1ef9303861/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0/go.mod"
	"howett.net/plist v1.0.0"
	"howett.net/plist v1.0.0/go.mod"
	"software.sslmate.com/src/go-pkcs12 v0.2.0"
	"software.sslmate.com/src/go-pkcs12 v0.2.0/go.mod"
)

go-module_set_globals

DESCRIPTION="A zero-config tool to make locally trusted development certificates"
HOMEPAGE="https://github.com/FiloSottile/mkcert"
SRC_URI="https://github.com/FiloSottile/mkcert/tarball/2a46726cebac0ff4e1f133d90b4e4c42f1edf44a -> mkcert-1.4.4-2a46726.tar.gz
https://direct.funtoo.org/76/93/10/769310042c6ae961ea3eb06c8e08f5454f6cd62bf8ed3999b5129a8c9299d356e188b042b2444e3e40165d62946d8f3f2a1d8f0ed9347fab3a7989c9d64fe97f -> mkcert-1.4.4-funtoo-go-bundle-1ada4f76bdb8fd3e8528df10f42ea02a4e3f3a0d97a1816c91c4b819b0dc644fd17e60bb9250865b0fef6990bad95e7bb98ab4107bc27439a0c7d2c182165bc7.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	dev-libs/nss[utils]
"

post_src_unpack() {
	mv ${WORKDIR}/FiloSottile-mkcert-* ${S} || die
}

src_compile() {
	go build -tags release -ldflags "-X main.Version=${PV}"  -o ${PN} || die
}

src_install() {
	dobin mkcert
	dodoc README.md
}