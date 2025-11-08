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

DESCRIPTION="Run UNIX commands in parallel with line-buffered I/O"
HOMEPAGE="https://git.kmx.io/kmx.io/runj"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.kmx.io/kmx.io/runj.git"
	KEYWORDS="~amd64 ~arm64 ~x86"
else
	SRC_URI="https://git.kmx.io/kmx.io/runj/release/_blob/master/v${PV}/runj-${PV}.tar.gz"
	S="${WORKDIR}/runj-${PV}"
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="BSD"
SLOT="0"

src_configure() {
	local myconf=(
		--prefix
		"${EPREFIX}/usr"
	)
	./configure "${myconf[@]}" || die "configure failed"
}

src_compile() {
	emake build
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
	dodoc README.md CHANGELOG.md
}
