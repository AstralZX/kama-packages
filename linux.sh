#!/usr/bin/env bash
name="linux"
version="6.7.4"
url="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.4.tar.xz"
deps=()
runtime_deps=("binutils" "gcc" "glibc")

build() {
    make defconfig
    make -j"${JOBS}"
}

install() {
    make INSTALL_PATH="${pkgdir}/boot" INSTALL_MOD_PATH="${pkgdir}" install modules_install
    for k in "${pkgdir}"/boot/vmlinuz*; do
        [[ -f "$k" ]] || continue
        cp "$k" "${pkgdir}/boot/vmlinuz"
        break
    done
}

build_musl() {
    make defconfig CC="musl-gcc"
    make -j"${JOBS}" CC="musl-gcc"
}