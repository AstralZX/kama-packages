#!/usr/bin/env bash
name="limine"
version="7.12.1"
url="https://github.com/limine-bootloader/limine/releases/download/v7.12.1/limine-7.12.1.tar.gz"
deps=()
runtime_deps=()

build() {
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}