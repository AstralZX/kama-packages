#!/usr/bin/env bash
name="openssh"
version="9.8p1"
url="https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.8p1.tar.gz"
deps=()
runtime_deps=("glibc" "zlib")

configure_args=(
    --prefix=/pkg
    --sysconfdir=/cfg/ssh
    --with-privsep-path=/var/empty
    --with-privsep-user=sshd
    --with-md5-passwords
    --with-sandbox=disabled
)

build() {
    ./configure "${configure_args[@]}"
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
}

build_musl() {
    ./configure "${configure_args[@]}" --without-openssl-header-check
    make -j"${JOBS}"
}

install_runit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/run" <<'EOF'
#!/bin/sh
exec 2>&1
exec /pkg/bin/sshd -D -e
EOF
    chmod +x "${pkgdir}/svc/${name}/run"
}

install_systemd() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}.service" <<'EOF'
[Unit]
Description=OpenSSH Daemon
After=network.target

[Service]
ExecStart=/pkg/bin/sshd -D -e
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
}

install_openrc() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}" <<'EOF'
#!/sbin/openrc-run
command=/pkg/bin/sshd
command_args="-D -e"
command_background=true
pidfile=/run/sshd.pid
EOF
    chmod +x "${pkgdir}/svc/${name}/${name}"
}

install_s6() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/run" <<'EOF'
#!/bin/sh
exec 2>&1
exec /pkg/bin/sshd -D -e
EOF
    chmod +x "${pkgdir}/svc/${name}/run"
}

install_dinit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/var/empty"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}.dinit" <<'EOF'
description = "OpenSSH Daemon"

command = /pkg/bin/sshd
command_args = ["-D", "-e"]

depends = network
EOF
}