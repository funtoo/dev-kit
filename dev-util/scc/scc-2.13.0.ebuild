# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dbaggerman/cuba v0.3.2"
	"github.com/dbaggerman/cuba v0.3.2/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/json-iterator/go v1.1.9"
	"github.com/json-iterator/go v1.1.9/go.mod"
	"github.com/karrick/godirwalk v1.10.12/go.mod"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
	"github.com/monochromegane/go-gitignore v0.0.0-20160105113617-38717d0a108c"
	"github.com/monochromegane/go-gitignore v0.0.0-20160105113617-38717d0a108c/go.mod"
	"github.com/pkg/profile v1.3.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/boyter/scc/archive/v2.13.0.tar.gz
	${EGO_SUM_SRC_URI}"

DESCRIPTION="A tool similar to cloc, sloccount and tokei"
HOMEPAGE="https://github.com/boyter/scc"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

src_unpack() {
	go-module_src_unpack
}

src_compile() {
	go build -mod=mod . || die "compile failed"
}

src_install() {
	dobin ${PN}
	dodoc README.md
}