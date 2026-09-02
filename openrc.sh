#!/usr/bin/env bash
name="openrc"
version="0.54"
url="https://github.com/OpenRC/openrc/archive/refs/tags/0.54.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg --sysconfdir=/cfg --libexecdir=/pkg/lib/openrc
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_runit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_openrc() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg/openrc" "${pkgdir}/svc"
    cat > "${pkgdir}/cfg/openrc/rc.conf" <<'EOF'
# /cfg/openrc/rc.conf — Keru OS
rc_shell=/bin/sh
rc_parallel=YES
rc_force_depend=YES
EOF
}

build_musl() {
    make CC="musl-gcc" clean 2>/dev/null || true
    ./configure --prefix=/pkg --sysconfdir=/cfg --libexecdir=/pkg/lib/openrc \
        CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}