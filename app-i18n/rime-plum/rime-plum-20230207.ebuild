# Distributed under the terms of the GNU General Public License v2
# Plum replaces brise, the old database package that many distributions currently use
EAPI="7"

inherit user

DESCRIPTION="Rime configuration manager and input schema repository"
HOMEPAGE="https://rime.im/ https://github.com/rime/plum"
SRC_URI="
	https://github.com/rime/plum/archive/6f502ff6fa87789847fa18200415318e705bffa4.tar.gz -> rime-plum-20230207.tar.gz
	https://github.com/rime/rime-bopomofo/archive/c7618f4f5728e1634417e9d02ea50d82b71956ab.tar.gz -> bopomofo.tar.gz
	https://github.com/rime/rime-cangjie/archive/8dfad9e537f18821b71ba28773315d9c670ae245.tar.gz -> cangjie.tar.gz
	https://github.com/rime/rime-essay/archive/e0519d0579722a0871efb68189272cba61a7350b.tar.gz -> essay.tar.gz
	https://github.com/rime/rime-luna-pinyin/archive/79aeae200a7370720be98232844c0715f277e1c0.tar.gz -> luna-pinyin.tar.gz
	https://github.com/rime/rime-prelude/archive/dd84abecc33f0b05469f1d744e32d2b60b3529e3.tar.gz -> prelude.tar.gz
	https://github.com/rime/rime-stroke/archive/c8bc4050d4d667be8f3f4892ab96e4d0881865a4.tar.gz -> stroke.tar.gz
	https://github.com/rime/rime-terra-pinyin/archive/9427853de91d645d9aca9ceace8fe9e9d8bc5b50.tar.gz -> terra-pinyin.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="app-i18n/librime"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Create the rime group
	enewgroup "rime"
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/plum-* "${S}"
}

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	# create directories and files that are needed
	mkdir -p ${ED}/usr/bin/
	mkdir -p ${ED}/usr/share/rime-data
	mkdir -p ${ED}/var/lib/plum
	mkdir -p ${ED}/etc

	# Install the plum source code to /var/lib, the source is required for plum to actually function.
	# There is no standard directory for installing the plum source, instead it is defined by an
	# environment variable. Logically it should be under /var/lib so that's where I put it
	cp "${S}"/* "${ED}"/var/lib/plum -r

	# Copy the script from the source to the binary directory
	cp ${ED}/var/lib/plum/rime-install ${ED}/usr/bin/rime-install

	# Install the data for rime, we cannot use the rime-install package manager since we don't have internet access so we use
	# tarballs provided from artifacts that comprise the minimal package set
	for directory in "${WORKDIR}"/*/; do
		cp -f "${directory}"*.yaml "${directory}"*.txt "${ED}"/usr/share/rime-data &> /dev/null
	done

	# install the plum_dir environment variable
	echo "plum_dir=\"/var/lib/plum\"" >> "${ED}"/etc/environment

	# Manage permissions here
	fowners -R :rime /var/lib/plum/
	fperms -R g+w+s /var/lib/plum/
}

pkg_postinst() {
	elog "To use rime please add yourself to the \"rime\" group to have access"
	elog "to the \"rime-install\" executable. This application is the new"
	elog "database + micro package manager for rime. For more information"
	elog "visit our rime page at:"
	elog "https://www.funtoo.org/Package:IBus/Chinese/rime"
	elog "For more information on how to use the package manager head to the"
	elog "\"Bundled input methods and installing additional ones\" paragraph"
}