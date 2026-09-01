# kama-packages

The central package (recipe) repository for [Keru OS](https://github.com/AstralZX/KeruOS),
built by [Kama](https://github.com/AstralZX/kama).

Every package is a plain POSIX shell script that describes how to compile and
install one piece of software. Nothing more — no manifests, no metadata files,
no build databases. The recipe *is* the package.

## Layout

```
TEMPLATE.sh      starting point for new recipes
busybox.sh       easy-tier example (autotools-ish, static build)
runit.sh         advanced-tier example (custom fetch/patch, pkg_post)
```

## Recipe syntax (quick)

```sh
name=busybox
version=1.36.1
url=https://busybox.net/downloads/busybox-1.36.1.tar.bz2
deps=()                  # build-time deps (AUR-style: built then purged)

build()   { make defconfig; make -j"$JOBS"; }   # configure + compile
install() { make install CONFIG_PREFIX="$pkgdir"; }  # stage into $pkgdir
```

Kama handles download, extraction, staging, and temp-dep cleanup. For advanced
needs (custom fetch, patches, post-install hooks, splitting), override
`pkg_fetch`, `pkg_post`, or `pkg_split`. See the
[full format spec](https://github.com/AstralZX/KeruOS/blob/main/docs/recipe-format.md).

<p align="center"><i>Every package a kiln-load — fire it from source.</i></p>
