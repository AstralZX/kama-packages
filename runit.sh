#!/usr/bin/env bash
name="runit"
version="2.1.2"
url="https://smarden.org/runit/runit-2.1.2.tar.gz"
deps=()
runtime_deps=("glibc")

pkg_fetch() {
    default_fetch
    cd "$src"
    sed -i 's|^package/.*|& DESTDIR="'"$pkgdir"'"|' src/Makefile 2>/dev/null || true
}

build() {
    cd src
    make -j"${JOBS}"
}

install() {
    cd src
    ./install.sh "${pkgdir}" 2>/dev/null || make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/runit"
    ln -sf /pkg/sbin/runit-init "${pkgdir}/pkg/sbin/init"
}