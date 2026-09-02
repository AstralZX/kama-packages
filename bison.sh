#!/usr/bin/env bash
name="bison"
version="3.8.2"
url="https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    rm -f "${pkgdir}/pkg/bin/yacc"
}
