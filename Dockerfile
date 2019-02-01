FROM lambci/lambda:build-python2.7

RUN yum install yum-utils --skip-broken -y
RUN yum install epel-release -y
RUN yum update -y
RUN yum install zip wget git libpng-devel libcurl-devel gcc python-devel libjpeg-devel -y
RUN pip install setuptools==39.0.1 --user
RUN pip install virtualenv==15.2.0 --user

COPY . /thumbor
WORKDIR /thumbor/deployment
