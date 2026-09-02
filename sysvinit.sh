#!/usr/bin/env bash
name="sysvinit"
version="3.09"
url="https://github.com/slicer69/sysvinit/archive/refs/tags/3.09.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    make -j"${JOBS}" ROOT="${pkgdir}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_sysvinit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg/sysconfig" "${pkgdir}/svc"
    cat > "${pkgdir}/cfg/sysconfig/rc" <<'EOF'
# /cfg/sysconfig/rc — sysvinit config
RC롮_SHELL=/bin/sh
RCRunlevel=3
EOF
}

build_musl() {
    make CC="musl-gcc" ROOT="${pkgdir}" -j"${JOBS}"
}