#!/bin/bash

if [ -z "$1" ]
  then
    echo "No TRAVIS_BRANCH argument supplied"
    exit 1
else
  TRAVIS_BRANCH=$1
fi

if [ -z "$2" ]
  then
    echo "No DOCKER_TRIGGER_TOKEN argument supplied"
    exit 1
else
  DOCKER_TRIGGER_TOKEN=$2
fi

echo "Triggering build for branch: $TRAVIS_BRANCH"
curl -H "Content-Type: application/json" --data "{"source_type": "Branch", "source_name": "$TRAVIS_BRANCH" }" -X POST https://registry.hub.docker.com/u/lorcanoeire/base-spree-store/trigger/$DOCKER_TRIGGER_TOKEN/
