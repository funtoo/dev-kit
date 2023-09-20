# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dbaggerman/cuba v0.3.2"
	"github.com/dbaggerman/cuba v0.3.2/go.mod"
	"github.com/google/gofuzz v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/json-iterator/go v1.1.9"
	"github.com/json-iterator/go v1.1.9/go.mod"
	"github.com/karrick/godirwalk v1.10.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1"
	"github.com/minio/blake2b-simd v0.0.0-20160723061019-3f5f724cb5b1/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180228061459-e0a39a4cb421/go.mod"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd"
	"github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd/go.mod"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742"
	"github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742/go.mod"
	"github.com/pkg/profile v1.3.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/boyter/scc/tarball/1cfa0eb9ea3decbb6d0fd459779477261d64f866 -> scc-3.1.0-1cfa0eb.tar.gz
https://direct.funtoo.org/66/5a/ac/665aac3b1762cff69f92d6b1a0ca80c67b5a3c57c4cfa33ed9188443a3898a14db4693dfaec06b7ad0097b487b6a1e00d8825a3f094779cb7c9dcc2c1c7e9fce -> scc-3.1.0-funtoo-go-bundle-307790817f633b649604ea48b7921b990ac8daa475b28adc0784be80edd5c756b65cf6105dbded3cfe101aecbc6adad70f60d4e3b18140370a7a9fb52a10067f.tar.gz"

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