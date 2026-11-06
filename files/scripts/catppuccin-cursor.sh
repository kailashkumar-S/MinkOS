#!/usr/bin/env bash

# Installs the Catppuccin Mocha (Mauve) cursor theme system-wide and makes it the default.
set -oue pipefail

VERSION="v2.0.0"
THEME="catppuccin-mocha-mauve-cursors"
URL="https://github.com/catppuccin/cursors/releases/download/${VERSION}/${THEME}.zip"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP/${THEME}.zip"
unzip -q "$TMP/${THEME}.zip" -d /usr/share/icons

# Fail the build if the expected directory wasn't created.
test -d "/usr/share/icons/${THEME}"

# Default cursor for X11/Xwayland apps and anything that doesn't read gsettings.
mkdir -p /usr/share/icons/default
cat > /usr/share/icons/default/index.theme <<EOF
[Icon Theme]
Inherits=${THEME}
EOF
