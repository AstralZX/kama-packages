#!/usr/bin/env bash
name="sudo"
version="1.9.15p5"
url="https://www.sudo.ws/dist/sudo-1.9.15p5.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg --sysconfdir=/cfg --libexecdir=/pkg/libexec \
        --with-all-editors --disable-nls
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg"
    cat > "${pkgdir}/cfg/sudoers" <<'EOF'
# /cfg/sudoers — Keru OS
# root ALL=(ALL) ALL
# %wheel ALL=(ALL) NOPASSWD:ALL
EOF
    chmod 0440 "${pkgdir}/cfg/sudoers"
}

build_musl() {
    ./configure --prefix=/pkg --sysconfdir=/cfg --libexecdir=/pkg/libexec \
        --with-all-editors --disable-nls CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}