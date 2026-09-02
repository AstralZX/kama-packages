#!/usr/bin/env bash
name="busybox-init"
version="1.36.1"
url="https://busybox.net/downloads/busybox-1.36.1.tar.bz2"
deps=()
runtime_deps=("glibc")

build() {
    make defconfig
    sed -i 's/# CONFIG_INIT_IS_NONE is not set/CONFIG_INIT_IS_NONE=y/' .config
    make olddefconfig
    make -j"${JOBS}"
}

install() {
    make install CONFIG_PREFIX="${pkgdir}/pkg"
    mkdir -p "${pkgdir}/pkg/sbin"
    ln -sf ../bin/busybox "${pkgdir}/pkg/sbin/init"
    mkdir -p "${pkgdir}/svc"
    mkdir -p "${pkgdir}/cfg/init.d"
    cat > "${pkgdir}/cfg/init.d/rcS" <<'EOF'
#!/bin/sh
# /cfg/init.d/rcS — busybox-init startup
for script in /cfg/init.d/S??*; do
    [ -x "$script" ] && "$script" start
done
EOF
    chmod +x "${pkgdir}/cfg/init.d/rcS"
}

build_musl() {
    make CC="musl-gcc" defconfig
    sed -i 's/# CONFIG_INIT_IS_NONE is not set/CONFIG_INIT_IS_NONE=y/' .config
    make olddefconfig CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}