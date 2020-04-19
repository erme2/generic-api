#!/usr/bin/env bash

. bash/vars.sh

docker stop $CONTAINER_NAME
docker rm -f $CONTAINER_NAME
docker rmi -f $REPO_NAME:latest

