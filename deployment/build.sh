#!/bin/bash

SOURCE_CODE_OUTPUT_BUCKET=metadata-images-source
VERSION=$1

rm -rf ./deployment/dist
./build-s3-dist.sh $SOURCE_CODE_OUTPUT_BUCKET $VERSION
