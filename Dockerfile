FROM python:3.6-stretch

ENV PATH /usr/local/bin:$PATH

RUN dpkg --add-architecture i386 \
 && apt-get update && apt-get install -y -q \
        build-essential \
        sudo \
        bsdtar \
        git \
        ffmpeg \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-mixer-dev \
        libsdl2-ttf-dev \
        libportmidi-dev \
        libswscale-dev \
        libavformat-dev \
        libavcodec-dev \
        zlib1g-dev \
        libgstreamer1.0 \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        libgstreamer1.0-dev \
        openjdk-8-jdk \
        ccache \
        unzip \
        libncurses5:i386 \
        libstdc++6:i386 \
        libgtk2.0-0:i386 \
        libpangox-1.0-0:i386 \
        libpangoxft-1.0-0:i386 \
        libidn11:i386 \
        zlib1g:i386 \
        wget \
        ccache \
        cmake \
 && apt-get clean

ADD . /src
WORKDIR /src
 
# root and plugdev groups are needed for adb be able to access usb
RUN set -ex \
 && useradd kivy -mN -G plugdev \
 && echo "kivy:kivy" | chpasswd \
 && chown kivy:users /opt \
 && chown kivy:users /src \
 && adduser kivy root && adduser kivy plugdev


RUN set -ex \
 && pip install --trusted-host pypi.python.org -r requirements-INSTALL-FIRST.txt \
 && pip install --trusted-host pypi.python.org -r requirements.txt

RUN set -ex \
 && sudo -u kivy -i \
 && cd /opt \
#  && git clone --branch 0.34 https://github.com/kivy/buildozer - Latest version has no copy apk bug
 && git clone https://github.com/kivy/buildozer \
 && cd buildozer \
 && python setup.py build \
 && pip install . \
 && cd .. && rm -rf buildozer \
 && mv /usr/local/bin/buildozer /usr/bin/buildozer

# The entry.sh is the buldozer script and run it to prefetch crystax
RUN set -ex \
 && mv /src/entry.sh /usr/local/bin/buildozer \
 && mv /src/adb.sh /usr/local/bin/adb \
 && sudo -u kivy /usr/local/bin/buildozer version

USER kivy

CMD "/usr/local/bin/buildozer"
