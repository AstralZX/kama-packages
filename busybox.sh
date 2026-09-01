#!/usr/bin/env sh
# busybox — easy-tier recipe example
# Kama auto-fetches + auto-extracts; we just build and stage-install.

name=busybox
version=1.36.1
url=https://busybox.net/downloads/busybox-1.36.1.tar.bz2
deps=()        # no build-time deps for a static busybox

build() {
    make defconfig
    make -j"$JOBS"
}

install() {
    make install CONFIG_PREFIX="$pkgdir"
}
