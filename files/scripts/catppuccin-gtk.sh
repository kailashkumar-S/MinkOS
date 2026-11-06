#!/usr/bin/env bash

# Installs the Catppuccin Mocha (Mauve) GTK theme system-wide.
# GTK3 apps pick it up via the gtk-theme gsettings key. GTK4/libadwaita apps ignore that key
# and only read ~/.config/gtk-4.0, so we also link the theme into /etc/skel for new users.
set -oue pipefail

VERSION="v1.0.3"
THEME="catppuccin-mocha-mauve-standard+default"
URL="https://github.com/catppuccin/gtk/releases/download/${VERSION}/catppuccin-mocha-mauve-standard%2Bdefault.zip"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP/theme.zip"
unzip -q "$TMP/theme.zip" -d /usr/share/themes

# Fail the build if the expected directory wasn't created.
test -d "/usr/share/themes/${THEME}/gtk-4.0"

SKEL_GTK4="/etc/skel/.config/gtk-4.0"
mkdir -p "$SKEL_GTK4"
for f in gtk.css gtk-dark.css assets; do
    if [ -e "/usr/share/themes/${THEME}/gtk-4.0/${f}" ]; then
        ln -sfn "/usr/share/themes/${THEME}/gtk-4.0/${f}" "${SKEL_GTK4}/${f}"
    fi
done
