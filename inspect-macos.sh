#!/bin/sh
# Inspect a macOS bundle without launching it or its helpers.
# Run: sh inspect-macos.sh /path/to/1401.app
# Observed on the showcase Mac: macOS 15.8.2, x86_64.
# 1401 version 2.7.2 (build 140) declares macOS 15.0 as its minimum.
# Its launcher was identified as a Mach-O 64-bit x86_64 executable.
set -eu
bundle=${1:-./1401.app}
case "$bundle" in /*) ;; *) bundle=./${bundle} ;; esac
plist="$bundle/Contents/Info.plist"
if [ ! -r "$plist" ]; then
    echo 'Usage: sh inspect-macos.sh /path/to/1401.app' >&2
    exit 1
fi
printf 'macOS: '
sw_vers -productVersion
printf 'Architecture: '
uname -m
printf '\nBundle metadata:\n'
plutil -p "$plist"
launcher=$(plutil -extract CFBundleExecutable raw -o - "$plist")
cd "$bundle/Contents/MacOS"
test -f "./$launcher" || { echo 'Bundle launcher missing' >&2; exit 1; }
printf '\nLauncher format:\n'
file "./$launcher"
