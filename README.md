# DevSecOps Quickstart

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">DevSecOps Tactical</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/thedevilsvoice/devsecops_tactical_book" property="cc:attributionName" rel="cc:attributionURL">Franklin Diaz</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

![Cloudy](https://github.com/thedevilsvoice/devsecops_quickstart/blob/master/docs/images/sky-690293_1920.jpg)


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
