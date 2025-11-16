#!/bin/bash


RESISTER_NAME="192.168.1.8"
RESISTRY_NAME="library"
BUILD_NAME="$(basename "$PWD")"
FULL_NAME="${RESISTER_NAME}/${RESISTRY_NAME}/${BUILD_NAME}"
TAG=$(TZ="Asia/Tokyo" date "+%Y%m%d.%H%M%S")

RESISTRY="resistry" # RESISTRY : resistry or microk8s

# build image.
# cd /home/hatchi/dockers/build-awx-ee-with-cisco.ios
cd $(dirname $0)

podman build -t ${FULL_NAME}:latest -t ${FULL_NAME}:$TAG .


if [ "${RESISTRY}" == "resistry" ]; then
    podman push ${FULL_NAME}:$TAG
    podman push ${FULL_NAME}:latest
fi

if [ "${RESISTRY}" == "resistry" ]; then
    # import image from podman to microk8s.
    podman save -o awx-ee-with-cisco.tar ${FULL_NAME}:latest
    sudo microk8s ctr image import awx-ee-with-cisco.tar
    # sudo microk8s ctr images tag \
    #     192.168.1.8/library/awx-ee-cisco-ios:latest \
    #     myregistry.local/myproject/awx-ee-cisco-ios:v1.0

    sudo microk8s ctr images ls | grep cisco
    rm awx-ee-with-cisco.tar
fi
exit

