#!/bin/bash -e

THISDIR=$(dirname $0)
. ${THISDIR}/conf.sh

docker rm -f ${IMAGE_NAME}
