# kmx.io Gentoo Overlay

Gentoo overlay for KC3 and related kmx.io projects.

## Installation

### Using eselect repository

```bash
# Add the overlay
eselect repository add kmx-io git https://git.kmx.io/kmx.io/gentoo-overlay-kmx-io.git

# Sync the overlay
emerge --sync kmx.io
```

### Manual installation

```bash
# Clone the overlay
mkdir -p /var/db/repos
git clone https://git.kmx.io/kmx.io/gentoo-overlay-kmx-io.git \
  /var/db/repos/kmx.io

# Create repos.conf entry
cat > /etc/portage/repos.conf/kmx.io.conf <<EOF
[kmx.io]
location = /var/db/repos/kmx.io
sync-type = git
sync-uri = https://git.kmx.io/kmx.io/gentoo-overlay-kmx-io.git
auto-sync = yes
EOF
```

## Available Packages

### dev-lang/kc3

KC3 - The first graph-native programming language

```bash
emerge dev-lang/kc3
```

#### USE flags

- `asan` - Build with AddressSanitizer for memory debugging
- `cov` - Build with code coverage instrumentation
- `debug` - Build debug version without optimizations
- `gtk` - Enable GTK4 window support
- `test` - Run test suite

## Links

- [KC3 Website](https://kc3-lang.org/)
- [kmx.io](https://kmx.io/)
- [Source Repository](https://git.kmx.io/kc3-lang/kc3)
- [Bug Reports](https://github.com/kc3-lang/kc3/issues)

## License

Copyright from 2022 to 2025 kmx.io <contact@kmx.io>

Permission is hereby granted to use this software granted
the above copyright notice and this permission paragraph
are included in all copies and substantial portions of this
software.

THIS SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY GUARANTEE OF
PURPOSE AND PERFORMANCE. IN NO EVENT WHATSOEVER SHALL THE
AUTHOR BE CONSIDERED LIABLE FOR THE USE AND PERFORMANCE OF
THIS SOFTWARE.
