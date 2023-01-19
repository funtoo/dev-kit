# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/a8m/envsubst v1.3.0"
	"github.com/a8m/envsubst v1.3.0/go.mod"
	"github.com/alecthomas/assert/v2 v2.0.3"
	"github.com/alecthomas/participle/v2 v2.0.0-beta.5"
	"github.com/alecthomas/participle/v2 v2.0.0-beta.5/go.mod"
	"github.com/alecthomas/repr v0.2.0"
	"github.com/alecthomas/repr v0.2.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/dimchansky/utfbom v1.1.1"
	"github.com/dimchansky/utfbom v1.1.1/go.mod"
	"github.com/elliotchance/orderedmap v1.5.0"
	"github.com/elliotchance/orderedmap v1.5.0/go.mod"
	"github.com/fatih/color v1.10.0/go.mod"
	"github.com/fatih/color v1.13.0"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/go-playground/assert/v2 v2.0.1/go.mod"
	"github.com/go-playground/locales v0.13.0/go.mod"
	"github.com/go-playground/universal-translator v0.17.0/go.mod"
	"github.com/go-playground/validator/v10 v10.4.1/go.mod"
	"github.com/goccy/go-json v0.10.0"
	"github.com/goccy/go-json v0.10.0/go.mod"
	"github.com/goccy/go-yaml v1.9.8"
	"github.com/goccy/go-yaml v1.9.8/go.mod"
	"github.com/hexops/gotextdiff v1.0.3"
	"github.com/inconshreveable/mousetrap v1.0.1"
	"github.com/inconshreveable/mousetrap v1.0.1/go.mod"
	"github.com/jinzhu/copier v0.3.5"
	"github.com/jinzhu/copier v0.3.5/go.mod"
	"github.com/leodido/go-urn v1.2.0/go.mod"
	"github.com/magiconair/properties v1.8.7"
	"github.com/magiconair/properties v1.8.7/go.mod"
	"github.com/mattn/go-colorable v0.1.8/go.mod"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.6.1"
	"github.com/spf13/cobra v1.6.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20220906165146-f3363e06e74c"
	"golang.org/x/net v0.0.0-20220906165146-f3363e06e74c/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20220406163625-3f8b81556e12/go.mod"
	"golang.org/x/sys v0.0.0-20220728004956-3c1f35247d10"
	"golang.org/x/sys v0.0.0-20220728004956-3c1f35247d10/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.8"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f"
	"golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/op/go-logging.v1 v1.0.0-20160211212156-b2cb9fa56473"
	"gopkg.in/op/go-logging.v1 v1.0.0-20160211212156-b2cb9fa56473/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

DESCRIPTION="yq is a portable command-line YAML, JSON and XML processor"
HOMEPAGE="https://github.com/mikefarah/yq"
SRC_URI="https://api.github.com/repos/mikefarah/yq/tarball/v4.30.8 -> yq-go-v4.30.8.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=">=dev-vcs/git-1.7.3"
BDEPEND=">=dev-lang/go-1.16.14"

src_unpack() {
	go-module_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/mikefarah-yq-* ${S} || die
}

src_compile() {
	# The default yq go binary will conflict with python-modules-kit's app-misc/yq, which also has a yq executable installed to /usr/bin/yq
	# For now until a decision is made regarding app-misc/yq, yq-go will be used as the binary name to avoid any collisions
	go build -o bin/yq-go || die "compile failed"
}

src_install() {
	dobin bin/yq-go
	dodoc README.md
}