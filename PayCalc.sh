#!/bin/sh
printf '\033c\033]0;%s\a' PayCalc
base_path="$(dirname "$(realpath "$0")")"
"$base_path/PayCalc.x86_64" "$@"
