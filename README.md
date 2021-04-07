# DevSecOps Quickstart

![Docker Image CI](https://github.com/thedevilsvoice/devsecops_quickstart/workflows/Docker%20Image%20CI/badge.svg?branch=master)

![Cloudy](https://github.com/thedevilsvoice/devsecops_quickstart/blob/master/docs/images/sky-690293_1920.jpg)

## Linux Dev Environment Setup

Testing out nix & python build env.
* https://github.com/dnadales/nix-latex-template

Set up nix env in BASH:

```sh
nix-shell -I nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
``

Set up the nix env in my fish shell:

```sh
set -x NIX_PATH (echo $NIX_PATH:)nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
```

Now start nix shell

```sh
nix-shell
python -m pip install -rrequirements.txt
for my_x in `ls book/dot|cut -f1 -d'.'|uniq`; do dot -Txdot book/dot/${my_x}.dot | dot2tex --figonly > book/dot/${my_x}.tex;done
#/usr/bin/texstudio &
pdflatex --shell-escape -synctex=1 -interaction=nonstopmode book/devsecops_quickstart.tex
exit
nix-collect-garbage -d
```

## Windows Dev Environment Setup

- Docker (includes docker-compose)
- install chocolatey (https://dev.to/bdbch/setting-up-ssh-and-git-on-windows-10-2khk)
- [Python3](https://www.python.org/downloads/windows/)

[Here is a link about installing Git locally](https://dev.to/bdbch/setting-up-ssh-and-git-on-windows-10-2khk)

```bash
choco install git -Y
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ssh-add id_rsa
type C:\Users\your_user_name\.ssh\id_rsa.pub
docker-compose -f docker\docker-compose.yml build devsecops
docker-compose -f docker\docker-compose.yml run devsecops /bin/bash
```

## IDE Setup

- VScode
  - drawio plugin

## Images

The images at pixabay.com are free for commercial use.

Down load the images to docs/images and save the HTML credits
for the photograph as a file with .html extension. Then run the
`generate_pic_ref.sh` script to make the picture credits file
in the references section.
