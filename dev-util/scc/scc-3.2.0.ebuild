# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/coreos/go-systemd/v22 v22.5.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dbaggerman/cuba v0.3.2"
	"github.com/dbaggerman/cuba v0.3.2/go.mod"
	"github.com/godbus/dbus/v5 v5.0.4/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.1/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/json-iterator/go v1.1.12"
	"github.com/json-iterator/go v1.1.12/go.mod"
	"github.com/karrick/godirwalk v1.10.12/go.mod"
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
	"github.com/pkg/profile v1.3.0/go.mod"
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

SRC_URI="https://github.com/boyter/scc/tarball/19b9bc387d062ca6d4146a3841dee137921ddda1 -> scc-3.2.0-19b9bc3.tar.gz
https://direct.funtoo.org/9e/75/fe/9e75fe3621624ab6b3e72612e361d61a2b0b89eea0a3b3db7a9e2ef816f4bf893abbc5725e419cc3c924a6f49f14398d88b42ff31f12376c6fa8943de775f94e -> scc-3.2.0-funtoo-go-bundle-0a4409377167cfa3d7d6046a69b469d99aec77cecd6879bc59930e920424221ae46d02f38ed4b6f8cbdf5c548798a2cea80c612c2dcdaea4ecec94011ae0adba.tar.gz"

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