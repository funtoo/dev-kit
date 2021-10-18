# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/!burnt!sushi/toml v0.3.1"
	"github.com/!burnt!sushi/toml v0.3.1/go.mod"
	"github.com/google/renameio v0.1.0/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kisielk/gotool v1.0.0/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/rogpeppe/go-internal v1.3.0/go.mod"
	"github.com/yuin/goldmark v1.1.27/go.mod"
	"github.com/yuin/goldmark v1.2.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/mod v0.2.0/go.mod"
	"golang.org/x/mod v0.3.0"
	"golang.org/x/mod v0.3.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef/go.mod"
	"golang.org/x/tools v0.0.0-20201124202034-299f270db459"
	"golang.org/x/tools v0.0.0-20201124202034-299f270db459/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/errgo.v2 v2.1.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.1/go.mod"
	"honnef.co/go/tools v0.0.1-2020.1.6"
	"honnef.co/go/tools v0.0.1-2020.1.6/go.mod"
	"howett.net/plist v0.0.0-20181124034731-591f970eefbb"
	"howett.net/plist v0.0.0-20181124034731-591f970eefbb/go.mod"
	"software.sslmate.com/src/go-pkcs12 v0.0.0-20180114231543-2291e8f0f237"
	"software.sslmate.com/src/go-pkcs12 v0.0.0-20180114231543-2291e8f0f237/go.mod"
)

go-module_set_globals

DESCRIPTION="A zero-config tool to make locally trusted development certificates"
HOMEPAGE="https://github.com/FiloSottile/mkcert"
SRC_URI="https://api.github.com/repos/FiloSottile/mkcert/tarball/v1.4.3 -> mkcert-1.4.3.tar.gz
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