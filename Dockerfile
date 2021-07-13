# syntax=docker/dockerfile:1

FROM pandoc/latex

LABEL maintainer="Franklin Diaz <franklin@bitsmasher.net>"
LABEL org.opencontainers.image.source="https://github.com/devsecfranklin/devsecops-tactical-book"

# Install additional LaTeX packages
# this takes f o r e v e r 
#RUN tlmgr update --self && tlmgr install pgf

WORKDIR /workspace/devsecops-tactical-book/book

COPY . /workspace/devsecops-tactical-book

#RUN \
#  make book
