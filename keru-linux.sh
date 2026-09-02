#!/usr/bin/env bash
name="keru-linux"
version="6.12.8"
url="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.8.tar.xz"
deps=()
runtime_deps=("glibc")

build() {
    make defconfig

    scripts/config --disable CONFIG_PREEMPT_DYNAMIC
    scripts/config --enable CONFIG_PREEMPT_NONE
    scripts/config --enable CONFIG_HZ_1000
    scripts/config --enable CONFIG_HZ_1000_HZ

    scripts/config --enable CONFIG_DRM_I915
    scripts/config --enable CONFIG_DRM_AMDGPU
    scripts/config --enable CONFIG_DRM_NOUVEAU
    scripts/config --enable CONFIG_USB_XHCI_HCD
    scripts/config --enable CONFIG_USB_EHCI_HCD
    scripts/config --enable CONFIG_NVME_CORE
    scripts/config --enable CONFIG_BLK_DEV_NVME
    scripts/config --enable CONFIG_SATA_AHCI
    scripts/config --enable CONFIG_ATA
    scripts/config --enable CONFIG_EXT4_FS
    scripts/config --enable CONFIG_BTRFS_FS
    scripts/config --enable CONFIG_XFS_FS
    scripts/config --enable CONFIG_F2FS_FS
    scripts/config --enable CONFIG_BCACHEFS_FS
    scripts/config --enable CONFIG_NTFS3_FS

    scripts/config --enable CONFIG_NETFILTER
    scripts/config --enable CONFIG_NF_CONNTRACK
    scripts/config --enable CONFIG_INET
    scripts/config --enable CONFIG_IPV6

    scripts/config --enable CONFIG_SECURITY_APPARMOR
    scripts/config --enable CONFIG_STACKPROTECTOR_STRONG
    scripts/config --enable CONFIG_RANDOMIZE_BASE
    scripts/config --enable CONFIG_FORTIFY_SOURCE
    scripts/config --enable CONFIG_INIT_STACK_ALL_ZERO

    scripts/config --disable CONFIG_DEBUG_INFO
    scripts/config --enable CONFIG_KERNEL_GZIP
    scripts/config --enable CONFIG_MODULE_COMPRESS
    scripts/config --enable CONFIG_MODULE_SIG_FORCE
    scripts/config --disable CONFIG_IKCONFIG_PROC

    scripts/config --disable CONFIG_DRM_VBOXVIDEO
    scripts/config --disable CONFIG_DRM_VMWGFX
    scripts/config --disable CONFIG_FB_VESA
    scripts/config --disable CONFIG_MFD_TWL4030
    scripts/config --disable CONFIG_SND_SB16

    make olddefconfig
    make -j"${JOBS}"
}

install() {
    make INSTALL_PATH="${pkgdir}/boot" INSTALL_MOD_PATH="${pkgdir}" install modules_install
    for k in "${pkgdir}"/boot/vmlinuz*; do
        [[ -f "$k" ]] || continue
        cp "$k" "${pkgdir}/boot/vmlinuz"
        break
    done
}

build_musl() {
    make defconfig CC="musl-gcc"

    scripts/config --enable CONFIG_HZ_1000
    scripts/config --enable CONFIG_HZ_1000_HZ
    scripts/config --disable CONFIG_DEBUG_INFO
    scripts/config --enable CONFIG_KERNEL_GZIP
    scripts/config --enable CONFIG_MODULE_COMPRESS

    make olddefconfig CC="musl-gcc"
    make CC="musl-gcc" -j"${JOBS}"
}