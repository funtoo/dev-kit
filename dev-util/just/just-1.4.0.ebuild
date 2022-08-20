# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.18
ansi_term-0.12.1
atty-0.2.14
bitflags-1.3.2
block-buffer-0.10.2
bstr-0.2.17
camino-1.0.9
cfg-if-1.0.0
clap-2.34.0
cpufeatures-0.2.2
cradle-0.2.2
crypto-common-0.1.6
ctor-0.1.23
ctrlc-3.2.2
derivative-2.2.0
diff-0.1.13
digest-0.10.3
doc-comment-0.3.3
dotenv-0.15.0
edit-distance-2.1.0
either-1.7.0
env_logger-0.9.0
executable-path-1.0.0
fastrand-1.8.0
generic-array-0.14.6
getopts-0.2.21
getrandom-0.2.7
heck-0.3.3
heck-0.4.0
hermit-abi-0.1.19
humantime-2.1.0
instant-0.1.12
itoa-1.0.3
lazy_static-1.4.0
lexiclean-0.0.1
libc-0.2.127
linked-hash-map-0.5.6
log-0.4.17
memchr-2.5.0
nix-0.24.2
output_vt100-0.1.3
pretty_assertions-1.2.1
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.43
pulldown-cmark-0.9.2
pulldown-cmark-to-cmark-10.0.2
quote-1.0.21
redox_syscall-0.2.16
regex-1.6.0
regex-automata-0.1.10
regex-syntax-0.6.27
remove_dir_all-0.5.3
rustversion-1.0.9
ryu-1.0.11
serde-1.0.143
serde_derive-1.0.143
serde_json-1.0.83
sha2-0.10.2
similar-2.2.0
snafu-0.7.1
snafu-derive-0.7.1
strsim-0.8.0
structopt-0.3.26
structopt-derive-0.4.18
strum-0.24.1
strum_macros-0.24.3
syn-1.0.99
target-2.0.0
tempfile-3.3.0
temptree-0.2.0
term_size-0.3.2
termcolor-1.1.3
textwrap-0.11.0
typed-arena-2.0.1
typenum-1.15.0
unicase-2.6.0
unicode-ident-1.0.3
unicode-segmentation-1.9.0
unicode-width-0.1.9
uuid-1.1.2
vec_map-0.8.2
version_check-0.9.4
wasi-0.11.0+wasi-snapshot-preview1
which-4.2.5
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.5
"

inherit cargo

DESCRIPTION="Just a command runner"
HOMEPAGE="https://github.com/casey/just"
SRC_URI="https://api.github.com/repos/casey/just/tarball/1.4.0 -> just-1.4.0.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND=">=virtual/rust-1.57.0"

QA_FLAGS_IGNORED="/usr/bin/just"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/casey-just-* ${S} || die
	# FL-10339 workaround
	# upstream man directory for some reason errors with the doman eclass function:
	# install-xattr: failed to stat /var/tmp/portage/dev-util/just-1.4.0/image/usr/share/man/man0/man: No such file or directory
	rm -r ${S}/man
}

src_install() {
	cargo_src_install
	dodoc README.md
	einstalldocs
}