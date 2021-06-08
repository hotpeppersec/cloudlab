# syntax=docker/dockerfile:1

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/thedevilsvoice/devsecops-tactical-book"

WORKDIR /workspace/devsecops-tactical-book/book

# Debian packages
ENV DEBIAN_FRONTEND noninteractive
RUN \
    apt update; \
    apt install gnupg2;\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
    apt-get install -y dialog apt-utils; \
    apt-get install -y wget unzip make texlive-full

COPY . /workspace/devsecops-tactical-book

RUN \  
    make book