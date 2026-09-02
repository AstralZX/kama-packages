#!/usr/bin/env bash
name="byacc"
version="20240210"
url="https://invisible-island.net/datafiles/release/byacc.tar.gz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}
