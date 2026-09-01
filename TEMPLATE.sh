#!/usr/bin/env sh
# Kama recipe template
#
# Copy this file to packages/<name>.sh (or packages/<name>/recipe.sh) and
# fill in the easy tier. Step up to the advanced tier only if you need it.
#
# For the simple case you only need: name, version, url, build(), install().
# Kama handles downloading + extraction automatically (the default_fetch).

name=
version=
url=
deps=()        # build-time deps (AUR-style: compiled then purged)

# ---- advanced (optional) ------------------------------------------------
# runtime_deps=()
# license=()
# provides=()
# conflicts=()
# arch=()
# noextract=()
#
# pkg_fetch() { default_fetch; patch -p1 < ../something.patch; }
# pkg_post()  { :; }
# pkg_split() { :; }

build() {
    # configure + compile here
    :
}

install() {
    # install into $pkgdir (staging), NOT into $ROOT
    :
}
