#!/usr/bin/env bash
name="musl"
version="1.2.5"
url="https://musl.libc.org/releases/musl-1.2.5.tar.gz"
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    ln -sf libc.so "${pkgdir}/pkg/lib/ld-musl-x86_64.so.1" 2>/dev/null || true
}