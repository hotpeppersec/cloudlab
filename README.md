# DevSecOps Quickstart

![Docker Image CI](https://github.com/thedevilsvoice/devsecops_quickstart/workflows/Docker%20Image%20CI/badge.svg?branch=master)

![Cloudy](https://github.com/thedevilsvoice/devsecops_quickstart/blob/master/docs/images/sky-690293_1920.jpg)

## Linux Dev Environment Setup

```bash
apy install -y graphviz
cd python && nix-shell
python -m pip install -rrequirements.txt
/usr/bin/texstudio &
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

## To generate PDF of book

Should be done from inside the Docker container. The PDF will persist
outside the Docker container in the users filesystem until
the `make clean` command is issued.

```bash
make docker
make book
```

- PDF will be in `book/devsecopsquickstart.pdf`
- Find the file in `file:///home/thedevilsvoice/workspace/devsecops_quickstart/book/devsecopsquickstart.pdf`
  - If you open in firefox you get a nice nav bar on the left side.

## Epub

Should be done from inside the docker container.

```bash
make docker
cd book && make epub
```

The epub file will be in `book/_build/epub/DevSecOpsQuickStart.epub`. It
will persist outside the Docker container in the users filesystem until
the `make clean` command is issued.

Now you can use Calibre to view the epub file, and Sigil to edit the
epub file as needed.

```bash
sudo apt -y install calibre sigil
```

## Images

The images at pixabay.com are free for commercial use.

Down load the images to docs/images and save the HTML credits
for the photograph as a file with .html extension. Then run the
`generate_pic_ref.sh` script to make the picture credits file
in the references section.

## Kindle (deprecated)

Now you can generate the kindle .mobi file. Note that [kindlegen is no longer
available](https://www.amazon.com/gp/feature.html?docId=1000765211)). Note that
the .mobi format is for testing on older devices that do not support
Enhanced Typesetting.

```bash
kindlegen _build/epub/CloudLab.epub
```

Results in a file called `CloudLab.mobi`
