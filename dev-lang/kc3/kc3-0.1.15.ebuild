## Copyright from 2022 to 2025 kmx.io <contact@kmx.io>
##
## Permission is hereby granted to use this software granted
## the above copyright notice and this permission paragraph
## are included in all copies and substantial portions of this
## software.
##
## THIS SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY GUARANTEE OF
## PURPOSE AND PERFORMANCE. IN NO EVENT WHATSOEVER SHALL THE
## AUTHOR BE CONSIDERED LIABLE FOR THE USE AND PERFORMANCE OF
## THIS SOFTWARE.

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Graph-native programming language with meta-programming"
HOMEPAGE="https://kc3-lang.org/ https://git.kmx.io/kc3-lang/kc3"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.kmx.io/kc3-lang/kc3.git"
	KEYWORDS="~amd64 ~arm64 ~x86"
else
	SRC_URI="https://git.kmx.io/kc3-lang/kc3/release/_blob/master/v${PV}/kc3-${PV}.tar.gz"
	S="${WORKDIR}/kc3-${PV}"
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="kmx-io-use-only"
SLOT="0"
IUSE="asan cov debug gtk test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-crypt/libmd
	dev-libs/libbsd
	dev-libs/libffi
	gtk? ( gui-libs/gtk:4 )
	virtual/libiconv
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local myconf=(
		--prefix
		"${EPREFIX}/usr"
	)
	./configure "${myconf[@]}" || die "configure failed"
}

src_compile() {
	local target="build"
	! use asan || target="${target} asan"
	! use cov || target="${target} cov"
	! use debug || target="${target} debug"
	emake ${target}
}

src_test() {
	local target="check"
	emake ${target}
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use debug; then
		find "${D}" -name '*_debug.so*' -delete || die
	fi
	if ! use asan; then
		find "${D}" -name '*_asan.so*' -delete || die
	fi
	if ! use cov; then
		find "${D}" -name '*_cov.so*' -delete || die
	fi

	einstalldocs
	dodoc README.md
}
