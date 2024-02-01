# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg-utils

SRC_URI="https://www.freedesktop.org/software/appstream/releases/AppStream-${PV}.tar.xz"
S="${WORKDIR}/AppStream-${PV}"
KEYWORDS="*"

DESCRIPTION="Cross-distro effort for providing metadata for software in the Linux ecosystem"
HOMEPAGE="https://www.freedesktop.org/wiki/Distributions/AppStream/"

LICENSE="LGPL-2.1+ GPL-2+"
SLOT="0/4"
IUSE="doc qt5 test"

RDEPEND="
	dev-db/lmdb
	>=dev-libs/glib-2.58
	dev-libs/libxml2
	dev-libs/libxmlb
	dev-libs/libyaml
	dev-libs/snowball-stemmer
	>=net-misc/curl-7.62
	dev-libs/gobject-introspection
	qt5? ( dev-qt/qtcore:5 )
"
DEPEND="${RDEPEND}
	test? ( qt5? ( dev-qt/qttest:5 ) )
"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/libxslt
	dev-util/itstool
	>=sys-devel/gettext-0.19.8
	doc? ( app-text/docbook-xml-dtd:4.5 )
	test? ( dev-qt/linguist-tools:5 )
"

src_prepare() {
	default
	sed -e "/^as_doc_target_dir/s/appstream/${PF}/" -i docs/meson.build || die
	if ! use test; then
		sed -e "/^subdir.*tests/s/^/#DONT /" -i {,qt/}meson.build || die # bug 675944
	fi
}

src_configure() {
	xdg_environment_reset

	local emesonargs=(
		-Dsystemd=false
		-Dapidocs=false
		-Ddocs=false
		-Dcompose=false
		-Dmaintainer=false
		-Dstemming=true
		-Dvapi=false
		-Dgir=true
		-Dinstall-docs=$(usex doc true false)
		-Dqt=$(usex qt5 true false)
	)

	meson_src_configure
}
