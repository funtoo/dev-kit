# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user

DESCRIPTION="Extensible continuous integration server"
HOMEPAGE="https://jenkins.io/"
LICENSE="MIT"
SRC_URI="https://get.jenkins.io/war/2.477/jenkins.war -> jenkins-bin-2.477.war"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="media-fonts/dejavu
	media-libs/freetype
	!dev-util/jenkins-lts-bin
	>=virtual/jre-1.8.0"

S=${WORKDIR}

JENKINS_DIR=/var/lib/jenkins

pkg_setup() {
	enewgroup jenkins
	enewuser jenkins -1 -1 ${JENKINS_DIR} jenkins
}

src_install() {
	keepdir /var/log/jenkins ${JENKINS_DIR}/backup ${JENKINS_DIR}/home

	insinto /opt/jenkins
	newins "${DISTDIR}"/${P}.war ${PN/-bin/}.war

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}-r1.logrotate ${PN/-bin/}

	newinitd "${FILESDIR}"/${PN}.init2 jenkins
	newconfd "${FILESDIR}"/${PN}.confd jenkins

	fowners jenkins:jenkins /var/log/jenkins ${JENKINS_DIR} ${JENKINS_DIR}/home ${JENKINS_DIR}/backup
}