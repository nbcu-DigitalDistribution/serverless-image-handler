#!/bin/bash

rm -rf ./deployment/dist
docker stop $(docker inspect --format="{{.Id}}" thumbor) || true
docker rm $(docker inspect --format="{{.Id}}" thumbor) || true
