#!/bin/bash

TEMPLATE_OUTPUT_BUCKET=metadata-images-source
DIST_OUTPUT_BUCKET=metadata-images-source
VERSION=0.0.8

./build-s3-dist.sh $DIST_OUTPUT_BUCKET $VERSION
