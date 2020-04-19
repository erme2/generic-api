#!/usr/bin/env bash

RUN_BASH='NO'
REPO_NAME='generic-api'
GIT_BRANCH='master'
CONTAINER_NAME=$REPO_NAME-$GIT_BRANCH

# getting versions
while getopts ":b:" opt
   do
     case $opt in
        b ) RUN_BASH='yes';;
     esac
done
