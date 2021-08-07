## Lab Container (Lab 3a)

I have created a ``lab container'' to define the lab environment. You can use this container to try out some of the
commands shown in this chapter. Directions for building and running the container are available in 
[the included markdown file](https://github.com/devsecfranklin/devsecops-tactical-workbook/tree/main/code/chapter-three/lab-3a.md).
For now we don't have to be concerned about the syntax and composition of the Dockerfile. We will look more closely
at Docker and Dockerfiles in an upcoming chapter.

An advantage with executing lab commands in a container is we can try things without altering the configuration of
our host operating system. The packages we install and configurations under test are, well, ephemeral!

### Build the Lab Container

    docker build -t frank378:chapter-three \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') .

### Inspect the Lab Container

In this example, the container image ID is `cdf6b6fafe03`. Substitue this string
in your actual image build. The "docker inspect" command will return a great deal of information about the
new container image in a JSON format.

    #Successfully built cdf6b6fafe03  <-- substitue with the value from your docker build
    docker inspect cdf6b6fafe03
    docker images

### Run the Lab Container

    docker run --rm  -it --entrypoint /bin/bash cdf6b6fafe03

### Cleanup Lab Container

After you are finished working in the container, exit out and run these commands to delete the
container and clean up the stale images.

    docker image rm cdf6b6fafe03
    docker system prune
