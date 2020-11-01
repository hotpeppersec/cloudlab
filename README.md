# DevSecOps Quickstart

![Docker Image CI](https://github.com/thedevilsvoice/devsecops_quickstart/workflows/Docker%20Image%20CI/badge.svg?branch=master)

![Cloudy](https://github.com/thedevilsvoice/devsecops_quickstart/blob/master/docs/images/sky-690293_1920.jpg)

## Images

The images at pixabay.com are free for commercial use.

Down load the images to docs/images and save the HTML credits
for the photograph as a file with .html extension. Then run the
`generate_pic_ref.sh` script to make the picture credits file
in the references section.

## To generate PDF of book

Should be done from inside the Docker container. The PDF will persist
outside the Docker container in the users filesystem until
the `make clean` command is issued.

```bash
make docker
#cd docs && sphinx-build -M latexpdf . _build
make docs
```

- PDF will be in `docs/_build/latex/devsecopsquickstart.pdf`
- Find the file in `file:///home/thedevilsvoice/workspace/devsecops_quickstart/docs/_build/latex/devsecopsquickstart.pdf`
  - If you open in firefox you get a nice nav bar on the left side.

## Epub

Should be done from inside the docker container.

```bash
make docker
cd docs && make epub
```

The epub file will be in `docs/_build/epub/DevSecOpsQuickStart.epub`. It
will persist outside the Docker container in the users filesystem until
the `make clean` command is issued.

Now you can use Calibre to view the epub file, and Sigil to edit the
epub file as needed.

```bash
sudo apt -y install calibre sigil
```

## Kindle (deprecated)

Now you can generate the kindle .mobi file. Note that [kindlegen is no longer
available](https://www.amazon.com/gp/feature.html?docId=1000765211)). Note that
the .mobi format is for testing on older devices that do not support 
Enhanced Typesetting.

```bash
kindlegen _build/epub/CloudLab.epub
```

Results in a file called `CloudLab.mobi`
