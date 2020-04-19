#!/usr/bin/env bash

. bash/vars.sh

docker image build --build-arg BRANCH=$GIT_BRANCH --no-cache -t $REPO_NAME:latest .
docker run -d --name $CONTAINER_NAME $REPO_NAME
docker exec -it $CONTAINER_NAME bash
