# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/alexbrainman/sspi v0.0.0-20210105120005-909beea2cc74"
	"github.com/alexbrainman/sspi v0.0.0-20210105120005-909beea2cc74/go.mod"
	"github.com/avast/retry-go v2.4.2+incompatible"
	"github.com/avast/retry-go v2.4.2+incompatible/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dpotapov/go-spnego v0.0.0-20210315154721-298b63a54430"
	"github.com/dpotapov/go-spnego v0.0.0-20210315154721-298b63a54430/go.mod"
	"github.com/git-lfs/gitobj/v2 v2.1.1"
	"github.com/git-lfs/gitobj/v2 v2.1.1/go.mod"
	"github.com/git-lfs/go-netrc v0.0.0-20210914205454-f0c862dd687a"
	"github.com/git-lfs/go-netrc v0.0.0-20210914205454-f0c862dd687a/go.mod"
	"github.com/git-lfs/pktline v0.0.0-20210330133718-06e9096e2825"
	"github.com/git-lfs/pktline v0.0.0-20210330133718-06e9096e2825/go.mod"
	"github.com/git-lfs/wildmatch/v2 v2.0.1"
	"github.com/git-lfs/wildmatch/v2 v2.0.1/go.mod"
	"github.com/gorilla/securecookie v1.1.1"
	"github.com/gorilla/securecookie v1.1.1/go.mod"
	"github.com/gorilla/sessions v1.2.1"
	"github.com/gorilla/sessions v1.2.1/go.mod"
	"github.com/hashicorp/go-uuid v1.0.2"
	"github.com/hashicorp/go-uuid v1.0.2/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jcmturner/aescts/v2 v2.0.0"
	"github.com/jcmturner/aescts/v2 v2.0.0/go.mod"
	"github.com/jcmturner/dnsutils/v2 v2.0.0"
	"github.com/jcmturner/dnsutils/v2 v2.0.0/go.mod"
	"github.com/jcmturner/gofork v1.0.0"
	"github.com/jcmturner/gofork v1.0.0/go.mod"
	"github.com/jcmturner/goidentity/v6 v6.0.1"
	"github.com/jcmturner/goidentity/v6 v6.0.1/go.mod"
	"github.com/jcmturner/gokrb5/v8 v8.4.2"
	"github.com/jcmturner/gokrb5/v8 v8.4.2/go.mod"
	"github.com/jcmturner/rpc/v2 v2.0.3"
	"github.com/jcmturner/rpc/v2 v2.0.3/go.mod"
	"github.com/jmhodges/clock v1.2.0"
	"github.com/jmhodges/clock v1.2.0/go.mod"
	"github.com/leonelquinteros/gotext v1.5.0"
	"github.com/leonelquinteros/gotext v1.5.0/go.mod"
	"github.com/mattn/go-isatty v0.0.4"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/olekukonko/ts v0.0.0-20171002115256-78ecb04241c0"
	"github.com/olekukonko/ts v0.0.0-20171002115256-78ecb04241c0/go.mod"
	"github.com/pkg/errors v0.0.0-20170505043639-c605e284fe17"
	"github.com/pkg/errors v0.0.0-20170505043639-c605e284fe17/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rubyist/tracerx v0.0.0-20170927163412-787959303086"
	"github.com/rubyist/tracerx v0.0.0-20170927163412-787959303086/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.7.0"
	"github.com/spf13/cobra v1.7.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/ssgelm/cookiejarparser v1.0.1"
	"github.com/ssgelm/cookiejarparser v1.0.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/xeipuuv/gojsonpointer v0.0.0-20180127040702-4e3ac2762d5f"
	"github.com/xeipuuv/gojsonpointer v0.0.0-20180127040702-4e3ac2762d5f/go.mod"
	"github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415"
	"github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415/go.mod"
	"github.com/xeipuuv/gojsonschema v0.0.0-20170210233622-6b67b3fab74d"
	"github.com/xeipuuv/gojsonschema v0.0.0-20170210233622-6b67b3fab74d/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20201112155050-0c6587e931a9/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.14.0/go.mod"
	"golang.org/x/crypto v0.17.0"
	"golang.org/x/crypto v0.17.0/go.mod"
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.8.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20191027093000-83d349e8ac1a/go.mod"
	"golang.org/x/net v0.0.0-20200114155413-6afb5195e5aa/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.6.0/go.mod"
	"golang.org/x/net v0.10.0/go.mod"
	"golang.org/x/net v0.17.0"
	"golang.org/x/net v0.17.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.8.0/go.mod"
	"golang.org/x/sys v0.13.0/go.mod"
	"golang.org/x/sys v0.15.0"
	"golang.org/x/sys v0.15.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.5.0/go.mod"
	"golang.org/x/term v0.8.0/go.mod"
	"golang.org/x/term v0.13.0/go.mod"
	"golang.org/x/term v0.15.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.7.0/go.mod"
	"golang.org/x/text v0.9.0/go.mod"
	"golang.org/x/text v0.13.0/go.mod"
	"golang.org/x/text v0.14.0"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20200221224223-e1da425f72fd/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.6.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

EGO_PN=github.com/git-lfs/git-lfs
DESCRIPTION="Git extension for versioning large files"
HOMEPAGE="https://git-lfs.github.com/"

SRC_URI="https://github.com/git-lfs/git-lfs/tarball/a04e6bd8b85de24de7585c5e203f021d79336766 -> git-lfs-3.5.1-a04e6bd.tar.gz
https://direct.funtoo.org/9a/6f/8b/9a6f8b83cf4ed6073aae51f993f104e46926130cf034396e51cce36390811a348e3751065337d3db44eed98e559b21e2d4714560ab950efd1d290a065313732b -> git-lfs-3.5.1-funtoo-go-bundle-398518790d3889083ff8deb7e057fcec4feace373be142a6e4ba804ddb7fc413bee160c8ee97ecd0498de2577b3dfdbe968c445282939b6e23b0dec2347daf74.tar.gz"
KEYWORDS="*"

LICENSE="Apache-2.0 BSD BSD-2 BSD-4 ISC MIT"
SLOT="0"
IUSE="doc test"

BDEPEND="
	doc? ( app-text/asciidoctor )
	>=dev-lang/go-1.18"
RDEPEND="dev-vcs/git"

RESTRICT+=" !test? ( test )"

DOCS=(
	CHANGELOG.md
	CODE-OF-CONDUCT.md
	CONTRIBUTING.md
	README.md
	SECURITY.md
)

post_src_unpack() {
	mv ${WORKDIR}/git-lfs-git-lfs-* ${S} || die
}

src_compile() {
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -s -w"
		-v -work -x
	)
	go build "${mygobuildargs[@]}" -o git-lfs git-lfs.go || die

	if use doc; then
		emake man
	fi
}

src_install() {
	dobin git-lfs
	einstalldocs
	if use doc; then
		doman man/man1/*.1
		doman man/man5/*.5
		doman man/man7/*.7
	fi
}

src_test() {
	local mygotestargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT}"
	)
	go test "${mygotestargs[@]}" ./... || die
}

pkg_postinst () {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog ""
		elog "Run \'git lfs install\' once for each user account manually."
		elog "For more details see https://bugs.gentoo.org/show_bug.cgi?id=733372."
	fi
}