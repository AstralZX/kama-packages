#!/usr/bin/env bash
name="shepherd"
version="0.10.5"
url="https://ftp.gnu.org/gnu/shepherd/shepherd-0.10.5.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg --sysconfdir=/cfg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_shepherd() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg/shepherd" "${pkgdir}/svc"
    cat > "${pkgdir}/cfg/shepherd/init.scm" <<'EOF'
;; /cfg/shepherd/init.scm — Keru OS shepherd config
(use-modules (gnu)
             (gnu services)
             (gnu services shepherd))
(operating-system
  (services %base-services))
EOF
}

build_musl() {
    ./configure --prefix=/pkg --sysconfdir=/cfg CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}