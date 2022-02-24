#!/bin/bash -e

THISDIR=$(dirname $0)
. ${THISDIR}/conf.sh

cat ${HOME}/.ssh/id*.pub > authorized_keys

docker build -t ${IMAGE_NAME} ${THISDIR}
docker run -p ${SSH_PORT}:22 --mount "src=${HOME}/sources,dst=/home/${USERNAME}/sources,type=bind" -d --name ${IMAGE_NAME} ${IMAGE_NAME}

echo "${IMAGE_NAME} available via ssh port ${SSH_PORT}, to access:"
echo "# ${THISDIR}/ssh"
