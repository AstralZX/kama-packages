#!/usr/bin/env bash
name="glibc"
version="2.39"
url="https://ftp.gnu.org/gnu/glibc/glibc-2.39.tar.xz"
deps=()
runtime_deps=()

build() {
    mkdir -p build
    cd build
    ../configure --prefix=/pkg --disable-werror
    make -j"${JOBS}"
}

install() {
    cd build
    make install DESTDIR="${pkgdir}"
}