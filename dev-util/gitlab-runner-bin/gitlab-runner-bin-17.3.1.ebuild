# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit readme.gentoo-r1 systemd tmpfiles user

DESCRIPTION="GitLab Runner"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"

# The following list of binaries is provided at the following URL
# https://gitlab-runner-downloads.s3.amazonaws.com/v13.6.0/index.html
SRC_URI="https://gitlab.com/gitlab-org/gitlab-runner/-/releases/v17.3.1/downloads/binaries/gitlab-runner-linux-amd64 -> gitlab-runner-bin-17.3.1.bin"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="systemd"

RDEPEND=""
DEPEND="
	${RDEPEND}
	systemd? ( sys-apps/systemd )
"

RESTRICT="strip"

DOC_CONTENTS="Register the runner as root using\\n
\\t# gitlab-runner register\\n
This will save the config in /etc/gitlab-runner/config.toml"

src_unpack() {
	mkdir ${S}
}

src_prepare() {
	default
	cp ${DISTDIR}/${A} ${S}/gitlab-runner || die
}

pkg_setup() {
	enewuser gitlab-runner
	enewgroup gitlab
}

src_install() {
	einstalldocs

	exeinto /usr/sbin/

	doexe gitlab-runner

	newconfd "${FILESDIR}"/gitlab-runner.confd gitlab-runner
	newinitd "${FILESDIR}"/gitlab-runner.initd gitlab-runner

	if use systemd; then
		systemd_dounit "${FILESDIR}"/gitlab-runner.service
		newtmpfiles "${FILESDIR}"/gitlab-runner.tmpfile gitlab-runner.conf
	fi

	readme.gentoo_create_doc

	insopts -o gitlab-runner -g gitlab -m0600
	diropts -o gitlab-runner -g gitlab -m0750
	insinto /etc/gitlab-runner
	keepdir /etc/gitlab-runner /var/lib/gitlab-runner
}

pkg_postinst() {
	tmpfiles_process gitlab-runner.conf
	readme.gentoo_print_elog
}