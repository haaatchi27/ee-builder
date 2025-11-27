#!/bin/bash


RESISTER_NAME="harbor.local"
RESISTRY_NAME="library"
BUILD_NAME="$(basename "$PWD")"
FULL_NAME="${RESISTER_NAME}/${RESISTRY_NAME}/${BUILD_NAME}"
TAG=$(TZ="Asia/Tokyo" date "+%Y%m%d.%H%M%S")

RESISTRY="resistry" # RESISTRY : resistry or microk8s

# build image.
cd $(dirname $0)

podman build -t ${FULL_NAME}:latest -t ${FULL_NAME}:$TAG . || exit


if [ "${RESISTRY}" == "resistry" ]; then
    podman login ${RESISTER_NAME}
    podman push ${FULL_NAME}:$TAG || exit
    podman push ${FULL_NAME}:latest || exit
fi

if [ "${RESISTRY}" == "microk8s" ]; then
    # import image from podman to microk8s.
    podman save -o awx-ee-with-cisco.tar ${FULL_NAME}:latest || exit
    sudo microk8s ctr image import awx-ee-with-cisco.tar || exit
    # sudo microk8s ctr images tag \
    #     192.168.1.8/library/awx-ee-cisco-ios:latest \
    #     myregistry.local/myproject/awx-ee-cisco-ios:v1.0

    sudo microk8s ctr images ls | grep cisco || exit
    rm awx-ee-with-cisco.tar || exit
fi
exit

