# Distributed under the terms of the GNU General Public License v2
# Plum replaces brise, the old database package that many distributions currently use
EAPI="7"

inherit user

DESCRIPTION="Rime configuration manager and input schema repository"
HOMEPAGE="https://rime.im/ https://github.com/rime/plum"
SRC_URI="
	https://github.com/rime/plum/archive/3d06432dda5fd1738bebda298c574b6ed2d512d8.tar.gz -> rime-plum-20220702.tar.gz
	https://github.com/rime/rime-bopomofo/archive/c7618f4f5728e1634417e9d02ea50d82b71956ab.tar.gz -> bopomofo.tar.gz
	https://github.com/rime/rime-cangjie/archive/8dfad9e537f18821b71ba28773315d9c670ae245.tar.gz -> cangjie.tar.gz
	https://github.com/rime/rime-essay/archive/8882482d07f38b5713ea3f49cb593eed94e671dd.tar.gz -> essay.tar.gz
	https://github.com/rime/rime-luna-pinyin/archive/6e677427764b542313858eaed22c2951d8ec22fe.tar.gz -> luna-pinyin.tar.gz
	https://github.com/rime/rime-prelude/archive/dd84abecc33f0b05469f1d744e32d2b60b3529e3.tar.gz -> prelude.tar.gz
	https://github.com/rime/rime-stroke/archive/ea8576d1accd6fda339e96b415caadb56e2a07d1.tar.gz -> stroke.tar.gz
	https://github.com/rime/rime-terra-pinyin/archive/aefaf372b25febbf4d5f9443bd284d3dd6876085.tar.gz -> terra-pinyin.tar.gz"

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