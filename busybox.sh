#!/usr/bin/env bash
name="busybox"
version="1.36.1"
url="https://busybox.net/downloads/busybox-1.36.1.tar.bz2"
deps=()
runtime_deps=("glibc")

build() {
    make defconfig
    make -j"${JOBS}"
}

install() {
    make install CONFIG_PREFIX="${pkgdir}/pkg"
}

install_busybox-init() {
    make install CONFIG_PREFIX="${pkgdir}/pkg"
    ln -sf ../bin/busybox "${pkgdir}/pkg/sbin/init"
}

build_musl() {
    make CC="musl-gcc" defconfig
    make CC="musl-gcc" -j"${JOBS}"
}