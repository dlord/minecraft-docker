#!/bin/bash

REPO_NAME=`basename $1`

docker pull dlord/minecraft

echo "Building $REPO_NAME"

for i in $1/*/; do
    TAG=`basename $i`
    echo "Building dlord/$REPO_NAME:$TAG"
    docker build --pull -t dlord/$REPO_NAME:$TAG $i
done
