#!/usr/bin/env bash
name="s6"
version="2.11.3.2"
url="https://skarnet.org/software/s6/s6-2.11.3.2.tar.gz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc"
}

install_s6() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/s6-svscan"
    cat > "${pkgdir}/svc/s6-svscan/run" <<'EOF'
#!/command/execlineb -P
s6-svscan -d3 /run/service
EOF
    chmod +x "${pkgdir}/svc/s6-svscan/run"
}

build_musl() {
    ./configure --prefix=/pkg CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}