# syntax=docker/dockerfile:1

FROM pandoc/latex

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/thedevilsvoice/devsecops-tactical-book"

# Install additional LaTeX packages
RUN tlmgr update --self && tlmgr install \
  pgf # <list of packages goes here>

WORKDIR /workspace/devsecops-tactical-book/book

COPY . /workspace/devsecops-tactical-book

RUN \  
    make book
