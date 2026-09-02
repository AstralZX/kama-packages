#!/usr/bin/env bash
name=""
version=""
url=""
deps=()
runtime_deps=()

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}

# uncomment and adapt these as needed:
# build_musl() { ... }
# install_runit() { ... }
# install_systemd() { ... }
# install_openrc() { ... }
# install_s6() { ... }
# install_dinit() { ... }
# install_busybox-init() { ... }
# install_shepherd() { ... }
# install_sysvinit() { ... }
# pkg_fetch() { ... }
# pkg_post() { ... }