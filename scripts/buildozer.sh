#!/bin/bash

docker run --rm -it --privileged \
    --name buildozer \
    -v $PWD:/src \
    -v /dev/bus/usb:/dev/bus/usb \
    -v buildozer:/home/kivy \
    wallneradam/kivy-buildozer \
    buildozer
