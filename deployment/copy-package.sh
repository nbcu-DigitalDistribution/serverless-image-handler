#!/bin/bash

docker cp $(docker inspect --format="{{.Id}}" thumbor):/thumbor/deployment/dist ./deployment
