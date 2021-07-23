FROM python:3.9-buster
LABEL maintainer="Kevin Flynn <Creator4983@encom.com>"

ENV DEBIAN_FRONTEND noninteractive

COPY . /project
WORKDIR /project

RUN apt-get update && \
    apt-get -y install apt-utils

