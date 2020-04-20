#!/usr/bin/env bash

. bash/vars.sh

docker run -d -p 80:8000  $REPO_NAME
