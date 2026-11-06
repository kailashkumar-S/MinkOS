#!/usr/bin/env bash
# base-main boots to multi-user.target; boot into the graphical login (greetd) instead.
set -oue pipefail

systemctl set-default graphical.target
