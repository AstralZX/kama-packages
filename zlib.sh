#!/usr/bin/env bash
name="zlib"
version="1.3.1"
url="https://zlib.net/fossils/zlib-1.3.1.tar.gz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}