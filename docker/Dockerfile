#FROM debian:buster-slim
FROM python:3.9-slim-buster
LABEL maintainer "Franklin Diaz <franklin@bitsmasher.net>"

ENV DEBIAN_FRONTEND noninteractive

ADD . /project
WORKDIR /project

# env stuff
RUN apt update && apt -y install apt-utils make latexmk 
    #texlive-fonts-recommended texlive-latex-extra texlive-xetex
# book stuff
RUN make python
#RUN if [ ! -d "pygments-css" ]; then git clone https://github.com/richleland/pygments-css.git; fi; \
#if [ ! -d "pygments-css" ]; then git clone https://github.com/richleland/pygments-css.git; fi; \
#cp /book/pygments-css/vim.css /book/docs/theme/static/
#RUN make book
#RUN chown -R 1000:9001 /project
