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
SRC_URI="https://api.github.com/repos/FiloSottile/mkcert/tarball/v1.4.4 -> mkcert-1.4.4.tar.gz
		${EGO_SUM_SRC_URI}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	dev-libs/nss[utils]
"

src_unpack() {
	go-module_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/FiloSottile-mkcert-* ${S} || die
}

src_compile() {
	go build -tags release -ldflags "-X main.Version=${PV}"  -o ${PN} || die
}

src_install() {
	dobin mkcert
	dodoc README.md
}