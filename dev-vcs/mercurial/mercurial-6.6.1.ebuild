# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE="threads(+)"

inherit bash-completion-r1 elisp-common eutils distutils-r1 flag-o-matic

DESCRIPTION=""
HOMEPAGE="https://www.mercurial-scm.org/"
SRC_URI="https://files.pythonhosted.org/packages/b7/26/c20779313ed9fd8aaf9030fa0df62bf7b5fcc9d44020fa12ea29d44fedfc/mercurial-6.6.1.tar.gz -> mercurial-6.6.1.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="+chg emacs gpg test tk zsh-completion"

RDEPEND="
	app-misc/ca-certificates
	dev-python/zstandard[${PYTHON_USEDEP}]
	gpg? ( app-crypt/gnupg )
	tk? ( dev-lang/tk )
	zsh-completion? ( app-shells/zsh )"

DEPEND="emacs? ( >=app-editors/emacs-23.1:* )
	test? ( app-arch/unzip
		dev-python/pygments[${PYTHON_USEDEP}] )"

SITEFILE="70${PN}-gentoo.el"

# Too many tests fail #608720
RESTRICT="test"

python_prepare_all() {
	# Use absolute import for zstd
	sed -i -e 's/from \.* import zstd/import zstd/' \
		mercurial/utils/compression.py \
		mercurial/wireprotoframing.py
	distutils-r1_python_prepare_all
}

python_compile() {
	filter-flags -ftracer -ftree-vectorize
	append-cflags -D_GNU_SOURCE
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile build_ext --no-zstd
}

python_compile_all() {
	rm -r contrib/win32 || die
	if use chg; then
		emake -C contrib/chg
	fi
	if use emacs; then
		cd contrib || die
		elisp-compile mercurial.el || die "elisp-compile failed!"
	fi
}

python_install() {
	distutils-r1_python_install build_ext --no-zstd
}

python_install_all() {
	distutils-r1_python_install_all

	newbashcomp contrib/bash_completion hg

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh_completion _hg
	fi

	dobin hgeditor
	if use tk; then
		dobin contrib/hgk
	fi
	python_foreach_impl python_doscript contrib/hg-ssh

	if use emacs; then
		elisp-install ${PN} contrib/mercurial.el* || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi

	local RM_CONTRIB=( hgk hg-ssh bash_completion zsh_completion plan9 *.el )

	if use chg; then
		dobin contrib/chg/chg
		doman contrib/chg/chg.1
		RM_CONTRIB+=( chg )
	fi

	for f in ${RM_CONTRIB[@]}; do
		rm -rf contrib/${f} || die
	done

	dodoc -r contrib
	docompress -x /usr/share/doc/${PF}/contrib
	doman doc/*.?
	dodoc CONTRIBUTORS hgweb.cgi

	insinto /etc/mercurial/hgrc.d
	doins "${FILESDIR}/cacerts.rc"
}

src_test() {
	pushd tests &>/dev/null || die
	rm -rf *svn*			# Subversion tests fail with 1.5
	rm -f test-archive*		# Fails due to verbose tar output changes
	rm -f test-convert-baz*		# GNU Arch baz
	rm -f test-convert-cvs*		# CVS
	rm -f test-convert-darcs*	# Darcs
	rm -f test-convert-git*		# git
	rm -f test-convert-mtn*		# monotone
	rm -f test-convert-tla*		# GNU Arch tla
	rm -f test-largefiles*		# tends to time out
	if [[ ${EUID} -eq 0 ]]; then
		einfo "Removing tests which require user privileges to succeed"
		rm -f test-convert*
		rm -f test-lock-badness*
		rm -f test-permissions*
		rm -f test-pull-permission*
		rm -f test-journal-exists*
		rm -f test-repair-strip*
	fi

	popd &>/dev/null || die
	distutils-r1_src_test
}

python_test() {
	local TEST_DIR

	rm -rf "${TMPDIR}"/test
	distutils_install_for_testing
	cd tests || die
	"${PYTHON}" run-tests.py --verbose \
		--tmpdir="${TMPDIR}"/test \
		--with-hg="${TEST_DIR}"/scripts/hg \
		|| die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	use emacs && elisp-site-regen

	elog "If you want to convert repositories from other tools using convert"
	elog "extension please install correct tool:"
	elog "  dev-vcs/cvs"
	elog "  dev-vcs/darcs"
	elog "  dev-vcs/git"
	elog "  dev-vcs/monotone"
	elog "  dev-vcs/subversion"
}

pkg_postrm() {
	use emacs && elisp-site-regen
}