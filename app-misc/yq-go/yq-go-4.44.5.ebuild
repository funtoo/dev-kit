# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/a8m/envsubst v1.4.2"
	"github.com/a8m/envsubst v1.4.2/go.mod"
	"github.com/alecthomas/assert/v2 v2.3.0"
	"github.com/alecthomas/assert/v2 v2.3.0/go.mod"
	"github.com/alecthomas/participle/v2 v2.1.1"
	"github.com/alecthomas/participle/v2 v2.1.1/go.mod"
	"github.com/alecthomas/repr v0.4.0"
	"github.com/alecthomas/repr v0.4.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dimchansky/utfbom v1.1.1"
	"github.com/dimchansky/utfbom v1.1.1/go.mod"
	"github.com/elliotchance/orderedmap v1.6.0"
	"github.com/elliotchance/orderedmap v1.6.0/go.mod"
	"github.com/fatih/color v1.18.0"
	"github.com/fatih/color v1.18.0/go.mod"
	"github.com/gabriel-vasile/mimetype v1.4.3"
	"github.com/gabriel-vasile/mimetype v1.4.3/go.mod"
	"github.com/go-playground/locales v0.14.1"
	"github.com/go-playground/locales v0.14.1/go.mod"
	"github.com/go-playground/universal-translator v0.18.1"
	"github.com/go-playground/universal-translator v0.18.1/go.mod"
	"github.com/go-playground/validator/v10 v10.22.1"
	"github.com/go-playground/validator/v10 v10.22.1/go.mod"
	"github.com/goccy/go-json v0.10.3"
	"github.com/goccy/go-json v0.10.3/go.mod"
	"github.com/goccy/go-yaml v1.13.0"
	"github.com/goccy/go-yaml v1.13.0/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/hexops/gotextdiff v1.0.3"
	"github.com/hexops/gotextdiff v1.0.3/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jinzhu/copier v0.4.0"
	"github.com/jinzhu/copier v0.4.0/go.mod"
	"github.com/leodido/go-urn v1.4.0"
	"github.com/leodido/go-urn v1.4.0/go.mod"
	"github.com/magiconair/properties v1.8.7"
	"github.com/magiconair/properties v1.8.7/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/pelletier/go-toml/v2 v2.2.3"
	"github.com/pelletier/go-toml/v2 v2.2.3/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.8.1"
	"github.com/spf13/cobra v1.8.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/yuin/gopher-lua v1.1.1"
	"github.com/yuin/gopher-lua v1.1.1/go.mod"
	"golang.org/x/crypto v0.29.0"
	"golang.org/x/crypto v0.29.0/go.mod"
	"golang.org/x/net v0.31.0"
	"golang.org/x/net v0.31.0/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.27.0"
	"golang.org/x/sys v0.27.0/go.mod"
	"golang.org/x/text v0.20.0"
	"golang.org/x/text v0.20.0/go.mod"
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
SRC_URI="https://github.com/mikefarah/yq/tarball/bc5b54cb1d1f720db16c9f75c5b45384d00e5cbf -> yq-4.44.5-bc5b54c.tar.gz
https://direct.funtoo.org/9d/4e/19/9d4e1964b9b1aa9a8de6d0cb0764ab5ac16544e1bd3b4f44fa622b1f5498df042874c7c8cfd1e486421383a99bbbbe588b1e7af77968eac83915ba93fc930710 -> yq-go-4.44.5-funtoo-go-bundle-302878ab9bdbd38b18af777be37fa90ea0ce4e07130e0ccec7cc6b761ce07fd5f86ae51ccb6667b38d88223923007faa5c2684258e7511a8399ea90e428a3c4b.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/mikefarah-yq-bc5b54c"

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