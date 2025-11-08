# Copyright 2022-2025 kmx.io
# Distributed under the terms of the ISC License

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Graph-native programming language with meta-programming"
HOMEPAGE="https://kc3-lang.org/ https://git.kmx.io/kc3-lang/kc3"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.kmx.io/kc3-lang/kc3.git"
else
	SRC_URI="https://git.kmx.io/kc3-lang/kc3/-/archive/v${PV/_pre/-git}/kc3-v${PV/_pre/-git}.tar.gz"
	S="${WORKDIR}/kc3"
	KEYWORDS="~amd64 ~arm64 ~x86 ~sparc"
fi

LICENSE="ISC"
SLOT="0"
IUSE="asan cov debug gtk test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/libiconv
	virtual/libffi
	dev-libs/libbsd
	dev-libs/libmd
	gtk? ( gui-libs/gtk:4 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}/usr"
	)

	./configure "${myconf[@]}" || die "configure failed"
}

src_compile() {
	local target="all"

	if use debug; then
		target="debug"
	elif use asan; then
		target="asan"
	elif use cov; then
		target="cov"
	fi

	emake ${target}
}

src_test() {
	local target="test"

	if use debug; then
		target="test_debug"
	elif use asan; then
		target="test_asan"
	elif use cov; then
		target="test_cov"
	fi

	emake ${target}
}

src_install() {
	emake DESTDIR="${D}" install

	einstalldocs
	dodoc README.md
}
