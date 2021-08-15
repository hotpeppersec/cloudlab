# syntax=docker/dockerfile:1

FROM alpine:3.14

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/devsecfranklin/devsecops-tactical-workbook"

ENV HOME /home/devsecops
RUN (groupadd engr && useradd -d $HOME -ms /bin/bash -g engr devsecops)
WORKDIR ${HOME}
COPY . ${MY_DIR}

RUN apk add --virtual --no-cache \
  wget \
  make \
  unzip \
  bash \
  git \
  ca-certificates \
  openssh \
  && rm -rf /var/cache/apk/*
