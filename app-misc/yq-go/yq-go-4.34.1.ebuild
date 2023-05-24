# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/a8m/envsubst v1.4.2"
	"github.com/a8m/envsubst v1.4.2/go.mod"
	"github.com/alecthomas/assert/v2 v2.2.2"
	"github.com/alecthomas/participle/v2 v2.0.0"
	"github.com/alecthomas/participle/v2 v2.0.0/go.mod"
	"github.com/alecthomas/repr v0.2.0"
	"github.com/alecthomas/repr v0.2.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dimchansky/utfbom v1.1.1"
	"github.com/dimchansky/utfbom v1.1.1/go.mod"
	"github.com/elliotchance/orderedmap v1.5.0"
	"github.com/elliotchance/orderedmap v1.5.0/go.mod"
	"github.com/fatih/color v1.15.0"
	"github.com/fatih/color v1.15.0/go.mod"
	"github.com/goccy/go-json v0.10.2"
	"github.com/goccy/go-json v0.10.2/go.mod"
	"github.com/goccy/go-yaml v1.11.0"
	"github.com/goccy/go-yaml v1.11.0/go.mod"
	"github.com/hexops/gotextdiff v1.0.3"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jinzhu/copier v0.3.5"
	"github.com/jinzhu/copier v0.3.5/go.mod"
	"github.com/magiconair/properties v1.8.7"
	"github.com/magiconair/properties v1.8.7/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.17"
	"github.com/mattn/go-isatty v0.0.17/go.mod"
	"github.com/pelletier/go-toml/v2 v2.0.7"
	"github.com/pelletier/go-toml/v2 v2.0.7/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.7.0"
	"github.com/spf13/cobra v1.7.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.1"
	"github.com/stretchr/testify v1.8.1/go.mod"
	"golang.org/x/net v0.10.0"
	"golang.org/x/net v0.10.0/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.8.0"
	"golang.org/x/sys v0.8.0/go.mod"
	"golang.org/x/text v0.9.0"
	"golang.org/x/text v0.9.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f"
	"golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/op/go-logging.v1 v1.0.0-20160211212156-b2cb9fa56473"
	"gopkg.in/op/go-logging.v1 v1.0.0-20160211212156-b2cb9fa56473/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

DESCRIPTION="yq is a portable command-line YAML, JSON and XML processor"
HOMEPAGE="https://github.com/mikefarah/yq"
SRC_URI="https://github.com/mikefarah/yq/tarball/5ef537f3fd1a9437aa3ee44c32c6459a126efdc4 -> yq-4.34.1-5ef537f.tar.gz
https://direct.funtoo.org/ae/68/ae/ae68aea5fbbd292c6135f2c788bc4053f9a505da5744e53f62b035dd19e3dc3e40fdf33fe02c6fee5b671b1613df069b51d694d82c6f13c499803d063f328427 -> yq-go-4.34.1-funtoo-go-bundle-472b42bf1072475f58f12519bc9c1bab95c3cbcfa1b5779d89ab8619894fad86e8ec151c4fc6f2f50ce02faa1bb7f13d65c1377fb8402c8db696ac732d2ee2db.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/mikefarah-yq-5ef537f"

DEPEND=""
RDEPEND=">=dev-vcs/git-1.7.3"
BDEPEND=">=dev-lang/go-1.16.14"

src_compile() {
	# The default yq go binary will conflict with python-modules-kit's app-misc/yq, which also has a yq executable installed to /usr/bin/yq
	# For now until a decision is made regarding app-misc/yq, yq-go will be used as the binary name to avoid any collisions
	go build -o bin/yq-go || die "compile failed"
}

src_install() {
	dobin bin/yq-go
	dodoc README.md
}