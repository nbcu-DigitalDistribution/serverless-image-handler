#!/bin/bash

SOURCE_CODE_OUTPUT_BUCKET=metadata-images-source-us-east-1
VERSION=$1

docker cp $(docker inspect --format="{{.Id}}" thumbor):/thumbor/deployment/dist ./deployment

aws s3 cp ./deployment/dist/ s3://$SOURCE_CODE_OUTPUT_BUCKET/serverless-image-handler/$VERSION/ --acl bucket-owner-full-control --recursive --exclude "*" --include "*.zip"
aws s3 cp ./deployment/dist/serverless-image-handler.template s3://$SOURCE_CODE_OUTPUT_BUCKET/serverless-image-handler/$VERSION/ --acl bucket-owner-full-control
