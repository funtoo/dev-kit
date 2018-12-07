# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils gnome2-utils fdo-mime

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE="+c++11"

ARD_PN="${PN/-bin}"
ARD_P="${ARD_PN}-${PV}"
ARD_PF="${ARD_PN}-${PVR}"

DESCRIPTION="The open-source Arduino Software (IDE)"
HOMEPAGE="http://arduino.cc/en/Main/Software"
SRC_URI="${SRC_URI}
	amd64? ( http://arduino.cc//download.php?f=/arduino-${PV}-linux64.tar.xz -> ${PN}_amd64-${PV}.tar.xz )
	x86?   ( http://arduino.cc//download.php?f=/arduino-${PV}-linux32.tar.xz -> ${PN}_i386-${PV}.tar.xz )
	"
RESTRICT="strip mirror test"

QA_PREBUILT="
	opt/arduino/*
"

DEPEND="app-arch/xz-utils"
RDEPEND="${DEPEND}
		dev-libs/glib
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		media-video/ffmpeg
		sys-libs/ncurses:5/5[tinfo]
		virtual/libusb:0
		virtual/libusb:1
		virtual/udev
		x11-libs/gtk+
		x11-libs/libX11
		x11-libs/pango[X]
		"

S="${WORKDIR}/${ARD_P}"

src_unpack() {
	unpack ${A}
	if use "c++11"; then
		cd "${S}"
		sed -i 's/\(compiler.cpp.extra_flags=\)/\1"-std=gnu++11"/' hardware/arduino/avr/platform.txt
	fi
}

src_install() {
	declare ARDUINO_HOME=/opt/${ARD_PN}

	# install desktop file, manpage and icons
	domenu "${FILESDIR}"/${ARD_PN}.desktop
	doman  "${FILESDIR}"/${ARD_PN}.1

	#doicon "${FILESDIR}"/${ARD_PN}.png
	pushd "${S}"/lib/icons &>/dev/null || die
	for size in * ; do
		if [ -f "${size}/apps/${ARD_PN}.png" ] ; then
			insinto "/usr/share/icons/hicolor/${size}/apps"
			doins "${size}/apps/${ARD_PN}.png"
		fi
	done
	dodir /usr/share/pixmaps
	doicon "32x32/apps/${ARD_PN}.png" || die
	popd &>/dev/null || die

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
	gnome2_icon_cache_update
	# Users need to be in uucp group for Arduino access to devices.
	elog "You must be in the uucp group to use Arduino."
	elog ""
}

pkg_postrm() {
	gnome2_icon_cache_update
}
