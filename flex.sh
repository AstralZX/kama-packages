#!/usr/bin/env bash
name="flex"
version="2.6.4"
url="https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}
