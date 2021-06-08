# syntax=docker/dockerfile:1

FROM debian:stable-slim

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/thedevilsvoice/devsecops-tactical-book"

WORKDIR /workspace/devsecops-tactical-book/book

# Debian packages
ENV DEBIAN_FRONTEND noninteractive
RUN \
    apt-get update; \
    apt-get install -y --no-install-recommends wget unzip make texlive-full

COPY . /workspace/devsecops-tactical-book

RUN \  
    make book