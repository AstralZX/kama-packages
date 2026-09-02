#!/usr/bin/env bash
name="dinit"
version="0.17.0"
url="https://github.com/davmac314/dinit/archive/refs/tags/v0.17.0.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg --sysconfdir=/cfg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_dinit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg/dinit.d" "${pkgdir}/svc"
    cat > "${pkgdir}/cfg/dinit.d/boot.dinit" <<'EOF'
description = "boot sequence"
type = internal
restart = false
depends = basic
EOF
    cat > "${pkgdir}/cfg/dinit.d/services.dinit" <<'EOF'
description = "system services"
type = internal
depends = boot
EOF
}

build_musl() {
    ./configure --prefix=/pkg --sysconfdir=/cfg CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}