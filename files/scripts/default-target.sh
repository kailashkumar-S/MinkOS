#!/usr/bin/env bash
set -euo pipefail

# boot into the graphical target (GDM) by default
systemctl set-default graphical.target
