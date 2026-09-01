#!/usr/bin/env sh
# runit — advanced-tier recipe example
# Shows overriding pkg_fetch (patch before build) and using pkg_post.

name=runit
version=2.1.2
url=https://smarden.org/runit/runit-2.1.2.tar.gz
deps=(gcc)
runtime_deps=()
license=(BSD-3-Clause)
provides=(init)

# patch the default package/ target so install lands in $pkgdir
pkg_fetch() {
    default_fetch
    cd "$src"
    # runit's makefile assumes an absolute package/ dir; inject DESTDIR
    sed -i 's|^package/.*|& DESTDIR="'"$pkgdir"'"|' src/Makefile 2>/dev/null || true
}

build() {
    cd src
    make -j"$JOBS"
}

install() {
    cd src
    ./install.sh "$pkgdir" 2>/dev/null || make install DESTDIR="$pkgdir"
}

pkg_post() {
    # runit expects to own /service etc; staged, so just create dirs
    mkdir -p "$pkgdir/etc/sv" "$pkgdir/service"
    ln -sf /usr/sbin/runit-init "$pkgdir/sbin/init"
}
