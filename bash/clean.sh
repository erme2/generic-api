#!/usr/bin/env bash

. bash/vars.sh

docker stop $(docker ps -a -q)
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -q)
