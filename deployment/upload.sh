#!/bin/bash

TEMPLATE_OUTPUT_BUCKET=metadata-images-source-us-east-1
VERSION=0.0.8

docker cp $(docker inspect --format="{{.Id}}" thumbor):/thumbor/deployment/dist ./deployment

aws s3 cp ./deployment/dist/ s3://$TEMPLATE_OUTPUT_BUCKET/serverless-image-handler/$VERSION/ --acl bucket-owner-full-control --recursive --exclude "*" --include "*.zip"
aws s3 cp ./deployment/dist/serverless-image-handler.template s3://$TEMPLATE_OUTPUT_BUCKET/serverless-image-handler/$VERSION/ --acl bucket-owner-full-control
