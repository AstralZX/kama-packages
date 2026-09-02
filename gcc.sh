#!/usr/bin/env bash
name="gcc"
version="13.2.0"
url="https://ftp.gnu.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz"
deps=()
runtime_deps=("binutils" "glibc")

build() {
    mkdir -p build
    cd build
    ../configure --prefix=/pkg \
        --enable-languages=c,c++ \
        --disable-multilib \
        --disable-bootstrap \
        --disable-werror
    make -j"${JOBS}"
}

install() {
    cd build
    make install DESTDIR="${pkgdir}"
}