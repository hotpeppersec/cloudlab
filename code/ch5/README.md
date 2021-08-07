# Github

A Dockerfile is provided here to give you a working lab envrionment for the labs in 
this chapter.

## Build the Container

```sh
docker build -t frank378:chapter-five \
--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') .
```

## Inspect the Container

In this example, the container image ID is `cdf6b6fafe03`. Substitue this string
in your actual image build. The "docker inspect" command will return a great deal of infor
mation about the
new container image in a JSON format.

```sh
#Successfully built cdf6b6fafe03  <-- substitue with the value from your docker build
docker inspect cdf6b6fafe03
docker images
```

## Run the Container

```sh
docker run --rm  -it --entrypoint /bin/bash cdf6b6fafe03
```

## Cleanup

After you are finished working in the container, exit out and run these commands to delete
 the
container and clean up the stale images.

```bash
docker image rm cdf6b6fafe03
docker system prune
```

