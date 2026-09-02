#!/usr/bin/env bash
name="grub"
version="2.12"
url="https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg --disable-werror
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}