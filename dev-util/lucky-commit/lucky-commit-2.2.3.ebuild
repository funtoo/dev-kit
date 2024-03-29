# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
autocfg-1.2.0
bitflags-1.3.2
block-buffer-0.10.4
cc-1.0.90
cfg-if-1.0.0
cl-sys-0.4.3
cpufeatures-0.2.12
crossbeam-0.8.4
crossbeam-channel-0.5.12
crossbeam-deque-0.8.5
crossbeam-epoch-0.9.18
crossbeam-queue-0.3.11
crossbeam-utils-0.8.19
crypto-common-0.1.6
digest-0.10.7
enum_primitive-0.1.1
futures-0.1.31
generic-array-0.14.7
hermit-abi-0.3.9
libc-0.2.153
nodrop-0.1.14
num-complex-0.4.5
num-traits-0.1.43
num-traits-0.2.18
num_cpus-1.16.0
ocl-0.19.6
ocl-core-0.11.5
ocl-core-vector-0.1.1
proc-macro2-1.0.79
quote-1.0.35
qutex-0.2.6
rustc_version-0.4.0
semver-1.0.22
sha-1-0.10.1
sha1-asm-0.5.2
sha2-0.10.8
sha2-asm-0.6.3
syn-2.0.55
thiserror-1.0.58
thiserror-impl-1.0.58
typenum-1.17.0
unicode-ident-1.0.12
version_check-0.9.4
"

inherit cargo

DESCRIPTION="Make your git commits lucky!"
HOMEPAGE="https://github.com/not-an-aardvark/lucky-commit"
SRC_URI="https://api.github.com/repos/not-an-aardvark/lucky-commit/tarball/refs/tags/v2.2.3 -> lucky-commit-2.2.3.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/not-an-aardvark-lucky-commit-* ${S} || die
}

src_compile() {
	cargo_src_compile --no-default-features
}

src_install() {
	cargo_src_install --no-default-features
}