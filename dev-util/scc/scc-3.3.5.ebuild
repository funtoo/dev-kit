# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/boyter/gocodewalker v1.3.2"
	"github.com/boyter/gocodewalker v1.3.2/go.mod"
	"github.com/boyter/gocodewalker v1.3.3"
	"github.com/boyter/gocodewalker v1.3.3/go.mod"
	"github.com/coreos/go-systemd/v22 v22.5.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964"
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/godbus/dbus/v5 v5.0.4/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.1/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/json-iterator/go v1.1.12"
	"github.com/json-iterator/go v1.1.12/go.mod"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.19"
	"github.com/mattn/go-isatty v0.0.19/go.mod"
	"github.com/mattn/go-runewidth v0.0.14"
	"github.com/mattn/go-runewidth v0.0.14/go.mod"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v1.0.2"
	"github.com/modern-go/reflect2 v1.0.2/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.4"
	"github.com/rivo/uniseg v0.4.4/go.mod"
	"github.com/rs/xid v1.5.0/go.mod"
	"github.com/rs/zerolog v1.30.0"
	"github.com/rs/zerolog v1.30.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.6.1"
	"github.com/spf13/cobra v1.6.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"golang.org/x/sync v0.7.0"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.10.0"
	"golang.org/x/sys v0.10.0/go.mod"
	"golang.org/x/text v0.8.0"
	"golang.org/x/text v0.8.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/boyter/scc/tarball/c51ed679eb3b0c99cdaa7e15ed1186fb74dcf6ed -> scc-3.3.5-c51ed67.tar.gz
https://direct.funtoo.org/2d/18/fa/2d18fadbf6c133415bc11d2b7cb3877c0edb5dca03ec1dfbf58522aec86d2230009de561626cf5e850bfb1dfc9a7840bc119c368f0b1adb00e5d922001456a07 -> scc-3.3.5-funtoo-go-bundle-b76450565d73e2ec5cfc516c21af30aec7a9b4fbc2782e190b8b98ef710d7569cd07dd6c3f75dd9a9ce23ec9be9a8d558d4166576e2c03bce1d8295a9e62946f.tar.gz"

DESCRIPTION="A tool similar to cloc, sloccount and tokei"
HOMEPAGE="https://github.com/boyter/scc"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

post_src_unpack() {
	mv ${WORKDIR}/boyter-* ${S} || die
}

src_compile() {
	go build -mod=mod . || die "compile failed"
}

src_install() {
	dobin ${PN}
	dodoc README.md
}