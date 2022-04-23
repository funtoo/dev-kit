# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

EGO_SUM=(
	"github.com/!burnt!sushi/toml v0.3.0"
	"github.com/!burnt!sushi/toml v0.3.0/go.mod"
	"github.com/atotto/clipboard v0.0.0-20171229224153-bc5958e1c833"
	"github.com/atotto/clipboard v0.0.0-20171229224153-bc5958e1c833/go.mod"
	"github.com/bmizerany/assert v0.0.0-20160611221934-b7ed37b82869"
	"github.com/bmizerany/assert v0.0.0-20160611221934-b7ed37b82869/go.mod"
	"github.com/kballard/go-shellquote v0.0.0-20170619183022-cd60e84ee657"
	"github.com/kballard/go-shellquote v0.0.0-20170619183022-cd60e84ee657/go.mod"
	"github.com/kr/pretty v0.0.0-20160823170715-cfb55aafdaf3"
	"github.com/kr/pretty v0.0.0-20160823170715-cfb55aafdaf3/go.mod"
	"github.com/kr/text v0.0.0-20160504234017-7cafcd837844"
	"github.com/kr/text v0.0.0-20160504234017-7cafcd837844/go.mod"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.3"
	"github.com/mattn/go-isatty v0.0.3/go.mod"
	"github.com/mitchellh/go-homedir v0.0.0-20161203194507-b8bc1bf76747"
	"github.com/mitchellh/go-homedir v0.0.0-20161203194507-b8bc1bf76747/go.mod"
	"github.com/russross/blackfriday v0.0.0-20180526075726-670777b536d3"
	"github.com/russross/blackfriday v0.0.0-20180526075726-670777b536d3/go.mod"
	"github.com/shurcoo!l/sanitized_anchor_name v0.0.0-20170918181015-86672fcb3f95"
	"github.com/shurcoo!l/sanitized_anchor_name v0.0.0-20170918181015-86672fcb3f95/go.mod"
	"golang.org/x/crypto v0.0.0-20180127211104-1875d0a70c90"
	"golang.org/x/crypto v0.0.0-20180127211104-1875d0a70c90/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20191002035440-2ec189313ef0"
	"golang.org/x/net v0.0.0-20191002035440-2ec189313ef0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190531175056-4c3a928424d2"
	"golang.org/x/sys v0.0.0-20190531175056-4c3a928424d2/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.0.0-20190319135612-7b8349ac747c"
	"gopkg.in/yaml.v2 v2.0.0-20190319135612-7b8349ac747c/go.mod"
)

go-module_set_globals

DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
HOMEPAGE="https://github.com/github/hub"
SRC_URI="https://api.github.com/repos/github/hub/tarball/v2.14.2 -> hub-2.14.2.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="sys-apps/groff"
RDEPEND=">=dev-vcs/git-1.7.3"

post_src_unpack() {
	mv "${WORKDIR}"/github-hub-* "${S}" || die
}

src_compile() {
	go build -mod=mod . || die "compile failed"
	emake bin/hub man-pages
}

src_test() {
	emake test
}

src_install() {
	dobin ${PN}
	dodoc README.md
	doman share/man/man1/*.1

	newbashcomp etc/${PN}.bash_completion.sh ${PN}

	insinto /usr/share/vim/vimfiles
	doins -r share/vim/vimfiles/*
	insinto /usr/share/zsh/site-functions
	newins etc/hub.zsh_completion _${PN}
}