#!/usr/bin/env bash

. bash/vars.sh

# vars
while getopts ":b:" opt
   do
     case $opt in
        c ) COMPOSER_UPDATE=$OPTARG;;
     esac
done

docker image build --build-arg BRANCH=$GIT_BRANCH --no-cache -t $REPO_NAME:latest .
docker run -d -p 80:8000 --name $CONTAINER_NAME $REPO_NAME

if [ ${RUN_BASH} = "yes" ]
then
    docker exec -it $CONTAINER_NAME bash
fi

