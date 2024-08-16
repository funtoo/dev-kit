# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop xdg

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox-app"
SRC_URI="https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.2.32922.tar.gz -> jetbrains-toolbox-2.4.2.tar.gz"

LICENSE="JetBrains"
SLOT="0"
KEYWORDS="-* amd64"

DEPEND="sys-fs/fuse:0"

QA_PREBUILT="opt/jetbrains-toolbox/jetbrains-toolbox"

post_src_unpack() {
	mv "${WORKDIR}"/"${PN}"-2.4.2.32922 "${S}" || die
}

src_compile() {
	./"${PN}" --appimage-extract
}

src_install() {
	keepdir /opt/jetbrains-toolbox
	insinto /opt/jetbrains-toolbox
	doins jetbrains-toolbox
	fperms +x /opt/jetbrains-toolbox/jetbrains-toolbox

	newicon squashfs-root/toolbox-tray-color.png "${PN}.png"

	make_wrapper "${PN}" /opt/jetbrains-toolbox/jetbrains-toolbox

	mkdir -p "${ED}"/usr/share/applications
	insinto /usr/share/applications
	doins "${REPODIR}/dev-util/jetbrains/files/${PN}.desktop"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
