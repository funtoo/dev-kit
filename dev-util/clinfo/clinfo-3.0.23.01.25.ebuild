# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://github.com/Oblomov/clinfo/archive/748c3930a9b9cb826e631d77439e2cb8f84f5bcf.zip -> clinfo-3.0.23.01.25-748c393.zip"
KEYWORDS="*"
DESCRIPTION="A tool to display info about the system's OpenCL capabilities"
HOMEPAGE="https://github.com/Oblomov/clinfo"
LICENSE="CC0-1.0"
SLOT="0"

DEPEND="
	dev-util/opencl-headers
	dev-util/opencl-icd-loader
"
RDEPEND="${DEPEND}"

post_src_unpack() {
	if [ ! -d "${WORKDIR}/${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}

src_install() {
	emake MANDIR="${ED}"/usr/share/man PREFIX="${ED}"/usr install
}