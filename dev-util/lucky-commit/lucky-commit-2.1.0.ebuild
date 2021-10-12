# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.16.0
adler-1.0.2
autocfg-1.0.1
backtrace-0.3.61
bitflags-1.2.1
block-buffer-0.9.0
cc-1.0.69
cfg-if-0.1.10
cfg-if-1.0.0
cl-sys-0.4.2
cpufeatures-0.2.1
crossbeam-0.7.3
crossbeam-channel-0.4.4
crossbeam-deque-0.7.4
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
digest-0.9.0
enum_primitive-0.1.1
failure-0.1.8
failure_derive-0.1.8
fuchsia-cprng-0.1.1
futures-0.1.31
generic-array-0.14.4
gimli-0.25.0
hermit-abi-0.1.19
lazy_static-1.4.0
libc-0.2.101
maybe-uninit-2.0.0
memchr-2.4.0
memoffset-0.5.6
miniz_oxide-0.4.4
nodrop-0.1.14
num-0.1.42
num-bigint-0.1.44
num-complex-0.1.43
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.1.42
num-traits-0.1.43
num-traits-0.2.14
num_cpus-1.13.0
object-0.26.0
ocl-0.19.3
ocl-core-0.11.2
ocl-core-vector-0.1.0
opaque-debug-0.3.0
proc-macro2-1.0.28
quote-1.0.9
qutex-0.2.3
rand-0.4.6
rand_core-0.3.1
rand_core-0.4.2
rdrand-0.4.0
rustc-demangle-0.1.20
rustc-serialize-0.3.24
rustc_version-0.1.7
scopeguard-1.1.0
semver-0.1.20
sha-1-0.9.8
sha1-asm-0.5.1
sha2-0.9.8
sha2-asm-0.6.2
syn-1.0.74
synstructure-0.12.5
typenum-1.14.0
unicode-xid-0.2.2
version_check-0.9.3
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Make your git commits lucky!"
HOMEPAGE="https://github.com/not-an-aardvark/lucky-commit"
SRC_URI="https://api.github.com/repos/not-an-aardvark/lucky-commit/tarball/refs/tags/v2.1.0 -> lucky-commit-2.1.0.tar.gz
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