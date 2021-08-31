# syntax=docker/dockerfile:1

FROM  python:3.9.7-slim-buster

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/devsecfranklin/devsecops-tactical-workbook"

# mise en place
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages
ENV HOME /home/devsecops
RUN (groupadd engr && useradd -d $HOME -ms /bin/bash -g engr devsecops)

WORKDIR ${HOME}

COPY . ${MY_DIR}

# Debian packages, on Mac 
RUN \
    apt-get update; \
    apt-get install -y dialog apt-utils; \
    apt-get install -y gnupg2 pass

