#!/usr/bin/env bash
name="doas"
version="6.8.2"
url="https://github.com/Duncaen/OpenDoas/releases/download/v6.8.2/opendoas-6.8.2.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/cfg"
    touch "${pkgdir}/cfg/doas.conf"
    cat > "${pkgdir}/cfg/doas.conf" <<'EOF'
# /cfg/doas.conf — doas config for Keru OS
# uncomment and edit as needed:
# permit nopass keepenv root
EOF
}