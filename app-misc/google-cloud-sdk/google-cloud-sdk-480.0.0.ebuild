# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit bash-completion-r1 python-any-r1

DESCRIPTION="A set of command-line tools for the Google Cloud Platform."
HOMEPAGE="https://cloud.google.com/sdk/"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-480.0.0-linux-x86_64.tar.gz -> google-cloud-sdk-480.0.0-linux-x86_64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="zsh-completion"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/google-cloud-sdk"

src_install() {
	BASE_DIR=/opt/google-cloud-sdk

	insinto ${BASE_DIR}
	doins -r .

	for bin_file in bin/*
	do
		bin_filename=${bin_file#bin/}

		fperms +x ${BASE_DIR}/${bin_file}
		dosym ${BASE_DIR}/${bin_file} /usr/bin/${bin_filename}
	done

	newbashcomp completion.bash.inc gcloud

	bashcomp_alias gcloud bq
	bashcomp_alias gcloud gsutil

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins completion.zsh.inc _gcloud
	fi
}