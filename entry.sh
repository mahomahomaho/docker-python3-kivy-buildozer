#!/bin/bash

CRYSTAX_VER="10.3.2"

# Install crystax ndk if not yet installed
if [ ! -d /home/kivy/crystax-ndk-$CRYSTAX_VER ]; then
    echo "Downloading and unpacking Crystax NDK (if you use /home/kivy volume, it is a 1 time process)..."
    set -ex && \
    pushd /home/kivy && \
    wget -q https://www.crystax.net/download/crystax-ndk-$CRYSTAX_VER-linux-x86_64.tar.xz && \
    bsdtar xf crystax-ndk-$CRYSTAX_VER-linux-x86_64.tar.xz && \
    rm crystax-ndk-$CRYSTAX_VER-linux-x86_64.tar.xz && \
    ln -s /home/kivy/crystax-ndk-$CRYSTAX_VER /opt/crystax-ndk-$CRYSTAX_VER && \
    popd
fi

# fixes source and target JDK version, refs https://github.com/kivy/buildozer/issues/625
if [ -f /home/kivy/.buildozer/android/platform/android-sdk-20/tools/ant/build.xml ];then
    sed s/'name="java.source" value="1.5"'/'name="java.source" value="7"'/ -i /home/kivy/.buildozer/android/platform/android-sdk-20/tools/ant/build.xml
    sed s/'name="java.target" value="1.5"'/'name="java.target" value="7"'/ -i /home/kivy/.buildozer/android/platform/android-sdk-20/tools/ant/build.xml
fi

/usr/bin/buildozer "$@"
