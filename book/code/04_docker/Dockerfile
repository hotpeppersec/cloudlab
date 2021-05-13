FROM python:3.9-buster
LABEL maintainer="Kevin Flynn <Creator4983@encom.com>"

ENV DEBIAN_FRONTEND noninteractive

ADD . /project
WORKDIR /project

RUN apt update && \
    apt -y install apt-utils

