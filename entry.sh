#!/bin/sh

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

/usr/bin/buildozer "$@"
