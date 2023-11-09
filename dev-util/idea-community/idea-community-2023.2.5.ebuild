# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils gnome3-utils readme.gentoo-r1 xdg

DESCRIPTION="a Java IDE by JetBrains (Community Edition)"
HOMEPAGE="https://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/ideaIC-2023.2.5.tar.gz -> idea-community-2023.2.5.tar.gz"

LICENSE="JetBrains"
SLOT="0"
KEYWORDS="*"
IUSE="+system-java +sysctl"

DEPEND="dev-util/patchelf"
RDEPEND="
	system-java? ( virtual/jre )
	dev-libs/libdbusmenu
	dev-python/pip"

RESTRICT="strip"

QA_PREBUILT="opt/${PN}/bin/fsnotifier
	opt/${PN}/bin/fsnotifier64
	opt/${PN}/bin/fsnotifier-arm
	opt/${PN}/bin/libyjpagent-linux.so
	opt/${PN}/bin/libyjpagent-linux64.so"


S="${WORKDIR}/idea-IC-${PV}"

post_src_unpack() {
	if [ ! -d "$S" ]; then
		einfo "Renaming source directory to predictable name..."
		mv $(ls "${WORKDIR}") "idea-IC-${PV}" || die
	fi
}

src_install() {
	patchelf --set-rpath '$ORIGIN' jbr/lib/jcef_helper jbr/lib/libjcef.so

	local dir="/opt/${PN}"
	local dst="${D}${dir}"

	insinto "${dir}"
	mv "${S}"/* "${dst}"

	local bundled_script_name="${PN%-*}.sh" # bundled script is always lowercase, and doesn't have -ultimate, -professional suffix.

	make_wrapper "${PN}" "${dir}/bin/$bundled_script_name" || die

	local svgfile="$(find ${dst}/bin -maxdepth 1 -iname '*.svg')"
	newicon $svgfile "${PN}.svg" || die

	local pngfile="$(find ${dst}/bin -maxdepth 1 -iname '*.png')"
	newicon $pngfile "${PN}.png" || die

	make_desktop_entry ${PN} "IntelliJ IDEA Community Edition" ${PN} "Development;IDE;" || die

	if use system-java; then
		rm -rf "$dst{jbr,jre{64}}" || die "Failed to remove bundled Java"
	fi

	if use sysctl; then
		dodir /etc/sysctl.d
		echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-${PN}-idea-inotify-watches.conf" || die
	fi

}

pkg_postinst() {
	xdg_pkg_postinst
	if use sysctl; then
		( /etc/init.d/sysctl restart >/dev/null 2>&1 )
		einfo "An /etc/sysctl.d file was installed to optimally configure the IDE, with this"
		einfo "setting:"
	else
		einfo "JetBrains recommends adding the following to /etc/sysctl.conf:"
	fi
	einfo
	einfo "fs.inotify.max_user_watches = 524288"
	einfo
	einfo "See https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit for"
	einfo "more information."
	if use sysctl; then
		einfo "If this change is undesired, set -sysctl in /etc/portage/package.use."
	fi

}