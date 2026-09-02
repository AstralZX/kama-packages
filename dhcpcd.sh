#!/usr/bin/env bash
name="dhcpcd"
version="10.5.2"
url="https://github.com/NetworkConfiguration/dhcpcd/releases/download/v10.5.2/dhcpcd-10.5.2.tar.xz"
deps=()
runtime_deps=("glibc")

build() {
    ./configure --prefix=/pkg --sysconfdir=/cfg/dhcpcd \
        --without-udev --libexecdir=/pkg/lib/dhcpcd
    make -j"${JOBS}"
}

install() {
    make install DESTDIR="${pkgdir}"
}

install_runit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/run" <<'EOF'
#!/bin/sh
exec 2>&1
exec /pkg/sbin/dhcpcd -B
EOF
    chmod +x "${pkgdir}/svc/${name}/run"
}

install_systemd() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}.service" <<'EOF'
[Unit]
Description=DHCP Client
After=network.target

[Service]
ExecStart=/pkg/sbin/dhcpcd -B
Restart=always

[Install]
WantedBy=multi-user.target
EOF
}

install_openrc() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}" <<'EOF'
#!/sbin/openrc-run
command=/pkg/sbin/dhcpcd
command_args="-B"
command_background=true
EOF
    chmod +x "${pkgdir}/svc/${name}/${name}"
}

install_s6() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/run" <<'EOF'
#!/bin/sh
exec 2>&1
exec /pkg/sbin/dhcpcd -B
EOF
    chmod +x "${pkgdir}/svc/${name}/run"
}

install_dinit() {
    make install DESTDIR="${pkgdir}"
    mkdir -p "${pkgdir}/svc/${name}"
    cat > "${pkgdir}/svc/${name}/${name}.dinit" <<'EOF'
description = "DHCP Client"

command = /pkg/sbin/dhcpcd
command_args = ["-B"]

depends = network
EOF
}