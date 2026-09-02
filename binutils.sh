#!/usr/bin/env bash
name="binutils"
version="2.42"
url="https://ftp.gnu.org/gnu/binutils/binutils-2.42.tar.xz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg --disable-werror --enable-gold
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}