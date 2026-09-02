#!/usr/bin/env bash
name="texinfo"
version="7.1"
url="https://ftp.gnu.org/gnu/texinfo/texinfo-7.1.tar.xz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}
