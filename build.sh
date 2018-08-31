#!/bin/bash

NAME="wallneradam/kivy-buildozer"
VERSION=0.1.2

docker rmi -f ${NAME}:${VERSION} 2>/dev/null
docker rmi -f ${NAME}:latest 2>/dev/null
docker build -t ${NAME}:${VERSION} -t ${NAME}:latest . \
   && docker push ${NAME}:latest \
   && docker push ${NAME}:${VERSION}
