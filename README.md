# AWS Serverless Image Handler Lambda wrapper for Thumbor
A solution to dynamically handle images on the fly, utilizing Thumbor (thumbor.org).
Published version, additional details and documentation are available here: https://aws.amazon.com/answers/web-applications/serverless-image-handler/

_Note:_ it is recommend to build the application binary on Amazon Linux.

## Creating the Docker Container

Everything in this repository has been dockerized to mimic the deployment environment necessary in AWS. We use AWS Lambda to host the image processing instance which the Dockerfile reflects.

Run this command to build that image locally

```bash
make build_docker_container
```

## Building Distributable

The image that gets deployed gets built within the Docker container as to decrease platform incompatibilities with dependencies necessary to build and run the application once deployed to Lambda. To do so, run the following command:

```bash
make build_package VERSION=<your_version_number>
```

## Uploading the Distributable

Right now, we deploy the stack manually by pointing to a CloudFormation template stored in S3. That template also tells Lambda to point to a package uploaded to S3 as well. The following command will upload the built distributable along with a CloudFormation template to a S3 bucket designated in the `deployment/upload.sh` script.

```bash
make upload_package VERSION=<your_version_number>
```

## Running unit tests

Run the command

```bash
make unit_test
```

## Caveats

* You may notice that the bucket names in the `deployment/build.sh` and `deployment/upload.sh` scripts are different. The `build.sh` script has the bucket name as you would expect and the `upload.sh` script has the bucket name with the region it's created in appended to it. The region name is needed because Lambda expects it, but the template generation only requires the root name of the bucket and will then append the region to it for Lambda to point at.

* Right now, uploading isn't completely working due to an async issue with the Tornado-Botocore dependency. Still investigating what the options are. May have to create a service around Thumbbor and use it as a CLI tool rather than a service.

## SafeURL hash calculation
* For hash calculation with safe URL, use following snippet to find signed_path value
```bash
http_key='mysecuritykey' # security key provided to lambda env variable
http_path='200x200/smart/sub-folder/myimage.jpg' # sample options for myimage
hashed = hmac.new(str(http_key),str(http_path),sha1)
encoded = base64.b64encode(hashed.digest())
signed_path = encoded.replace('/','_').replace('+','-')
```

***

Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.

Licensed under the Amazon Software License (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at

    http://aws.amazon.com/asl/

or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and limitations under the License.
