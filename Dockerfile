# syntax=docker/dockerfile:1

FROM ubuntu:bionic
#FROM pandoc/latex

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/devsecfranklin/devsecops-tactical-workbook"

# Install additional LaTeX packages
# this takes f o r e v e r 
#RUN tlmgr update --self && tlmgr install pgf

RUN ln -snf /usr/share/zoneinfo/Etc/UTC /etc/localtime \
    && echo "Etc/UTC" > /etc/timezone \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y make \
    && apt-get install texlive-latex-base texlive-latex-extra texlive-fonts-recommended xzdec -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/devsecops-tactical-workbook/book
ENV MY_DIR /workspace/devsecops-tactical-workbook
COPY . ${MY_DIR}

ENV DEBIAN_FRONTEND noninteractive

RUN \
  make book
