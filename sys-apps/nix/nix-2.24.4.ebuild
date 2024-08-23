# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic linux-info readme.gentoo-r1 tmpfiles user

DESCRIPTION="A purely functional package manager"
HOMEPAGE="https://nixos.org/nix"

SRC_URI="https://github.com/NixOS/nix/tarball/cb0439f0c2d28f971369365d0937dbfaa76b0cce -> nix-2.24.4-cb0439f.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="+etc-profile +gc doc +sodium"

RDEPEND="
	app-arch/brotli
	app-arch/bzip2
	app-arch/xz-utils
	app-misc/jq[oniguruma]
	app-text/lowdown
	dev-db/sqlite
	dev-libs/editline:0=
	dev-libs/boost:0=[context]
	net-misc/curl
	sys-libs/libseccomp
	sys-libs/zlib
	amd64? ( dev-libs/libcpuid:0= )
	gc? ( dev-libs/boehm-gc[cxx] )
	doc? ( dev-libs/libxml2
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	sodium? ( dev-libs/libsodium:0= )
	dev-libs/openssl:0=
"
DEPEND="${RDEPEND}
	app-text/mdbook
	app-text/mdbook-linkcheck
	dev-cpp/nlohmann_json
	sys-devel/bison
	sys-devel/flex
	sys-devel/autoconf-archive
	virtual/pkgconfig
"

S="${WORKDIR}/NixOS-nix-cb0439f"

PATCHES=(
	"${FILESDIR}"/${PN}-libpaths.patch
	"${FILESDIR}"/${PN}-DESTDIR.patch
)

DISABLE_AUTOFORMATTING=yes
DOC_CONTENTS=" Quick start user guide on Gentoo:

[as root] enable nix-daemon service:
	[systemd] # systemctl enable nix-daemon && systemctl start nix-daemon
	[openrc]  # rc-update add nix-daemon && /etc/init.d/nix-daemon start
[as a user] relogin to get environment and profile update
[as a user] fetch nixpkgs update:
	\$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	\$ nix-channel --update
[as a user] install nix packages:
	\$ nix-env -i mc
[as a user] configure environment:
	Somewhere in .bash_profile you might want to set
	LOCALE_ARCHIVE=\$HOME/.nix-profile/lib/locale/locale-archive
	but please read https://github.com/NixOS/nixpkgs/issues/21820

Next steps:
	nix package manager user manual: http://nixos.org/nix/manual/
"

pkg_pretend() {
	# USER_NS is used to run builders in a default setting in linux:
	#     https://nixos.wiki/wiki/Nix#Sandboxing
	local CONFIG_CHECK="~USER_NS"
	check_extra_config
}

pkg_setup() {
	enewgroup nixbld
	for i in {1..10}; do
		# we list 'nixbld' twice to
		# both assign a primary group for user
		# and add a user to /etc/group
		enewuser nixbld${i} -1 -1 /var/empty nixbld,nixbld
	done
}

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	CONFIG_SHELL="${BROOT}/bin/bash" econf \
		--localstatedir="${EPREFIX}"/nix/var \
		--disable-tests \
		$(use_enable gc)

	emake Makefile.config # gets generated late
	cat >> Makefile.config <<-EOF
	V = 1
	CC = $(tc-getCC)
	CXX = $(tc-getCXX)
	EOF
}

src_compile() {
	# Upstream does not support building without installation.
	# Rely on src_install's DESTDIR=.
	:
}

src_install() {
	default

	readme.gentoo_create_doc

	# Follow the steps of 'scripts/install-multi-user.sh:create_directories()'
	local dir dirs=(
		/nix
		/nix/var
		/nix/var/log
		/nix/var/log/nix
		/nix/var/log/nix/drvs
		/nix/var/nix{,/db,/gcroots,/profiles,/temproots,/userpool,/daemon-socket}
		/nix/var/nix/{gcroots,profiles}/per-user
	)
	for dir in "${dirs[@]}"; do
		keepdir "${dir}"
		fperms 0755 "${dir}"
	done

	keepdir             /nix/store
	fowners root:nixbld /nix/store
	fperms 1775         /nix/store

	newinitd "${FILESDIR}"/nix-daemon.initd nix-daemon

	if ! use etc-profile; then
		rm "${ED}"/etc/profile.d/nix.sh || die
	fi
	# nix-daemon.sh should not be used for users' profile.
	# Only for daemon itself.
	rm "${ED}"/etc/profile.d/nix-daemon.sh || die
}

pkg_postinst() {
	if ! use etc-profile; then
		ewarn "${EROOT}etc/profile.d/nix.sh was removed (due to USE=-etc_profile)."
	fi

	readme.gentoo_print_elog
	tmpfiles_process nix-daemon.conf
}