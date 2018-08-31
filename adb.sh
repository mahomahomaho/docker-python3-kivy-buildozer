#!/bin/bash

# Find adb binary in android SDK
sdk_dir=$(find /home/kivy/.buildozer/android/platform/ -name android-sdk-* -type d)
[ "$sdk_dir" == "" ] && echo "SDK is not yet installed!" >&2 && exit 1

# Start adb binary
"$sdk_dir/platform-tools/adb" "$@"
