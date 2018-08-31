#!/bin/bash

docker run --rm -it --privileged \
    --name buildozer \
    -v $PWD:/src \
    -v /dev/bus/usb:/dev/bus/usb \
    -v buildozer:/home/kivy \
    -v ~/.android:/home/kivy/.android \
    wallneradam/kivy-buildozer \
    buildozer "$@"
