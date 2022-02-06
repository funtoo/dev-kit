# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://github.com/dylanaraps/neofetch/archive/7.1.0/neofetch-7.1.0.tar.gz"
KEYWORDS="*"

DESCRIPTION="Simple information system script"
HOMEPAGE="https://github.com/dylanaraps/neofetch"
LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="X"

RDEPEND="sys-apps/pciutils
	X? (
		media-gfx/imagemagick
		media-libs/imlib2
		www-client/w3m[imlib]
		x11-apps/xprop
		x11-apps/xrandr
		x11-apps/xwininfo
	)"