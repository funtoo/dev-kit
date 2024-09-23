# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper

RESTRICT="strip"

QA_PREBUILT="
	opt/${PN}/bin/*
	opt/${PN}/jre/bin/*
	opt/${PN}/jre/lib/*
	opt/${PN}/jre/lib/jli/*
	opt/${PN}/jre/lib/server/*
	opt/${PN}/lib/pty4j-native/linux/*/*
	opt/${PN}/plugins/android/resources/installer/*/*
	opt/${PN}/plugins/android/resources/layoutlib/data/linux/lib64/*
	opt/${PN}/plugins/android/resources/native/*
	opt/${PN}/plugins/android/resources/perfetto/*/*
	opt/${PN}/plugins/android/resources/simpleperf/*/*
	opt/${PN}/plugins/android/resources/trace_processor_daemon/*
	opt/${PN}/plugins/android/resources/transport/*/*
	opt/${PN}/plugins/android/resources/transport/native/agent/*/*
	opt/${PN}/plugins/android-ndk/resources/lldb/android/*/*
	opt/${PN}/plugins/android-ndk/resources/lldb/bin/*
	opt/${PN}/plugins/android-ndk/resources/lldb/lib/python3.9/lib-dynload/*
	opt/${PN}/plugins/android-ndk/resources/lldb/lib64/*
	opt/${PN}/plugins/c-clangd/bin/clang/linux/*
	opt/${PN}/plugins/webp/lib/libwebp/linux/*
"

DESCRIPTION="Android development environment based on IntelliJ IDEA"
HOMEPAGE="https://developer.android.com/studio"
SRC_URI="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.2.13/android-studio-2024.1.2.13-linux.tar.gz -> android-studio-2024.1.2.13-linux.tar.gz"

LICENSE="Apache-2.0 android-sdk"
SLOT="0"
IUSE="selinux"
KEYWORDS="*"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-android )
	app-arch/bzip2
	dev-libs/expat
	dev-libs/libffi
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	media-libs/mesa[X(+)]
	|| ( gnome-extra/zenity kde-apps/kdialog x11-apps/xmessage x11-libs/libnotify )
	sys-libs/ncurses-compat:5[tinfo]
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxshmfence
	dev-libs/libffi-compat:6
	sys-libs/libxcrypt
"

S=${WORKDIR}/${PN}

src_compile() {
	:;
}

src_install() {
	local dir="/opt/${PN}"
	insinto "${dir}"
	doins -r *

	fperms 755 "${dir}"/bin/{fsnotifier,format.sh,game-tools.sh,inspect.sh,ltedit.sh,profiler.sh,studio.sh,restarter}
	fperms -R 755 "${dir}"/bin/helpers
	fperms -R 755 "${dir}"/bin/lldb
	fperms -R 755 "${dir}"/jbr/bin
	fperms 755 "${dir}"/jbr/lib/{jexec,jspawnhelper}
	fperms -R 755 "${dir}"/plugins/Kotlin/kotlinc/bin
	fperms -R 755 "${dir}"/plugins/android/resources/installer
	fperms -R 755 "${dir}"/plugins/android/resources/perfetto
	fperms -R 755 "${dir}"/plugins/android/resources/simpleperf
	fperms -R 755 "${dir}"/plugins/android/resources/trace_processor_daemon
	fperms -R 755 "${dir}"/plugins/android/resources/transport/{arm64-v8a,armeabi-v7a,x86,x86_64}
	fperms -R 755 "${dir}"/plugins/android-ndk/resources/lldb/{android,bin,lib,shared}
	local fn
	local fn_path
	# These have been moving around on us:
	for fn in clang-tidy clangd; do
		fn_path=$(cd "${D}"; find ."${dir}/plugins/c-clangd-plugin/bin/clang/linux" -name $fn)
		if [[ "${fn_path#.}" != "" ]]; then
			fperms 755 ${fn_path#.}
		fi
	done
	fperms -R 755 "${dir}"/plugins/terminal/shell-integrations/{,fish}

	newicon "bin/studio.png" "${PN}.png"
	make_wrapper ${PN} ${dir}/bin/studio.sh
	make_desktop_entry ${PN} "Android Studio" ${PN} "Development;IDE" "StartupWMClass=jetbrains-studio"
}
