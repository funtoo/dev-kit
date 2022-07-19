# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils gnome2-utils fdo-mime desktop

KEYWORDS="-* ~x86 ~amd64 ~arm ~arm64"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE=""

ARD_PN="${PN/-bin}"
ARD_P="${ARD_PN}-${PV}"
ARD_PF="${ARD_PN}-${PVR}"

DESCRIPTION="AVR development board IDE and built-in libraries"
HOMEPAGE="http://arduino.cc/en/Main/Software"
SRC_URI="
	x86? ( https://downloads.arduino.cc/arduino-1.8.19-linux32.tar.xz -> arduino-1.8.19-linux32.tar.xz )
	amd64? ( https://downloads.arduino.cc/arduino-1.8.19-linux64.tar.xz -> arduino-1.8.19-linux64.tar.xz )
	arm? ( https://downloads.arduino.cc/arduino-1.8.19-linuxarm.tar.xz -> arduino-1.8.19-linuxarm.tar.xz )
	arm64? ( https://downloads.arduino.cc/arduino-1.8.19-linuxaarch64.tar.xz -> arduino-1.8.19-linuxaarch64.tar.xz )
"

RESTRICT="strip test"

QA_PREBUILT="opt/arduino/*"

DEPEND="app-arch/xz-utils"
RDEPEND="${DEPEND}
	sys-libs/ncurses[tinfo]
	virtual/libusb:0
	virtual/libusb:1
	virtual/udev
	media-video/ffmpeg
	dev-libs/glib"

S="${WORKDIR}/${ARD_P}"

src_compile() {
	# do nothing
	true
}

src_install() {
	declare ARDUINO_HOME=/opt/${ARD_PN}

	# install desktop file, manpage and icons
	domenu "${FILESDIR}"/${ARD_PN}.desktop
	doman  "${FILESDIR}"/${ARD_PN}.1

	cd "${S}"/lib/icons &>/dev/null || die
	for size in * ; do
        if [ -f "${size}/apps/${ARD_PN}.png" ] ; then
            insinto "/usr/share/icons/hicolor/${size}/apps"
            doins "${size}/apps/${ARD_PN}.png"
        fi
    done

	dodir /usr/share/pixmaps
	doicon "32x32/apps/${ARD_PN}.png" || die
	cd - &>/dev/null || die

	# copy directory to /opt
	dodir ${ARDUINO_HOME%/*}
	mv "${S}" "${D}"${ARDUINO_HOME} || die

	# make binary symlink
	dosym ${ARDUINO_HOME}/arduino /usr/bin/arduino

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/10${PN} || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}