# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Pebble SDK"
HOMEPAGE="https://developer.pebble.com/sdk/"
SRC_URI="
	amd64? ( https://s3.amazonaws.com/assets.getpebble.com/pebble-tool/${P}-linux64.tar.bz2 )
	x86? ( https://s3.amazonaws.com/assets.getpebble.com/pebble-tool/${P}-linux32.tar.bz2 )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pip
	dev-python/virtualenv
"

RESTRICT="strip binchecks"

S="${WORKDIR}/${P}"

pkg_setup() {
	if use amd64; then
		S="${S}-linux64"
	elif use x86; then
		S="${S}-linux32"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}.patch"
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	dodir "${dir}"
	doins -r *

	fperms -R 755 "${dir}/arm-cs-tools/arm-none-eabi/bin"
	fperms -R 755 "${dir}/arm-cs-tools/bin"

	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/libstdc++.la"
	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/libsupc++.la"

	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/armv6-m/libstdc++.la"
	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/armv6-m/libsupc++.la"

	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/thumb/libstdc++.la"
	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/thumb/libsupc++.la"

	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/thumb2/libstdc++.la"
	fperms 755 "${dir}/arm-cs-tools/arm-none-eabi/lib/thumb2/libsupc++.la"

	fperms -R 755 "${dir}/arm-cs-tools/libexec/gcc/arm-none-eabi/4.7.2"

	fperms 755 "${dir}/pebble-tool/pebble.py"
	fperms 755 "${dir}/pebble-tool/pebble_tool/commands/sdk/python"

	fperms 755 "${dir}/bin/pebble" "${dir}/bin/qemu-pebble"

	into "/opt/"
	#dobin "${dir}/bin/pebble"
	dosym  "${dir}/bin/pebble" /opt/bin/pebble || die
}

pkg_postinst() {
	einfo "You must set up a virtualenv before you can use the pebble tool."
	einfo "Try these commands from your home dir"
	einfo ""
	einfo "virtualenv --no-site-packages ~/.pebble/.env"
	einfo "source ~/.pebble/.env/bin/activate"
	einfo "pip install -r /opt/${PN}/requirements.txt"
	einfo "deactivate"
}
