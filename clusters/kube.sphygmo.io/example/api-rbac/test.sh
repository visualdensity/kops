#!/bin/bash

KUBE_TOKEN=
KUBE_ENDPOINT=https://api.kube.sphygmo.io
API_CALL=$KUBE_ENDPOINT/api

if [ "$1" != " " ]; then
  API_CALL=${KUBE_ENDPOINT}${1}
fi

curl "$API_CALL" --header "Authorization: Bearer $KUBE_TOKEN"
