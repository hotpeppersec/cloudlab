.. include:: global.rst

==========
Containers
==========

.. image:: ../images/container-4203677_1920.jpg
   :align: center

|

.. raw:: latex
\chapterquote{Who says God has created this world? We have created it by
our own imagination.God is supreme, independent. When we say he has
created this illusion, we lower him and his infinity. He is beyond all
this.Only when we find him in ourselves, and even in our day to day life,
do all doubts vanish.}{Meher Baba}

|

Containerization is the process of generating a fully functioning software ecosystem that
includes code and dependencies for part or all of a project. The most popular and common
tool for realizing containerization is Docker. Using Docker, we can programatically build
an environment for our project, and pass the entirety of this encapsulated environment
from our local development machine, into the Continuous Integration (CI) pipeline for testing,
and eventually into our production environment. Containerization helps us by offering a
consistent operating experience across disparate environments.

.. index::
   single: Continuous Integration
   single: Containerization
   single: Docker

It is more desirable to create projects that are built
and replaced frequently, than it is to attempt to upgrade and repair the infrastructure, platforms,
and project code. Attempts to patch and upgrade project hosts "in place", such as with
bare metal platforms for example, quickly reveal great difficulty in maintaining consistency
with the project source. This also introduces issues keeping operating system packages current,
yet still compatible with the project. Imagine a situation where an upgrade to a package is necessary
to meet security requirements, but this very same upgrade means the project stop working since
the package features have also changed. The result is most likely angry end users and customers.
Certainly not a situation we ever like to find ourselves in.

There is obvious advantage of being able to quickly stand up new clones of our project to
replace existing instances that may be outdated, insecure, etc.
The idea of immutability [#]_, in reference to software projects, is the degree to which something,
our running project for example, can be changed. Immutability is desirable, in that we wish to
be able to simply replace outdated instances of our project in their entirety. Upgrading and
patching are inherently problematic activities, high cost in terms of time, effort and money,
that we have the technology to dissociate from.
With containerization, we can more easily achieve immutability across the
software lifecycle.

.. index::
   single: Immutability

Ephemerality is the concept of something being transitory in nature, existing only
briefly [#]_. Using immutable containers makes it easier to realize infrastructure and hosts
that are ephemeral. Rather than spending a great deal of time patching and upgrading one or
more hosts as we might in a traditional project stack that uses virtual machines or bare metal,
we're going to use Docker to create a new container in place of the old one. In other words, we're
running our project in containers that are immutable and ephemeral to the degree possible.

.. [#] https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure/
.. [#] https://en.wikipedia.org/wiki/Ephemerality

.. index::
   single: Ephemerality

Docker images are "canned" (as in, prefabricated) or custom directives for provisioning
the operating system of a Docker container. One or more images can be used as building blocks
when configuring our containers. For example, a base Linux image and base Python image
might be combined with our customizations that describe and point to our application code,
all of which make up a single containerized "server".
We get the added benefit of being able to switch quickly between base operating system
images with just a few lines of code change to our project. For example, we could easily
modify our container image to be predicated on Debian rather than Red Hat distribution of
Linux kernel and operating system should the need arise.

See the Docker website for instructions on how to install and configure Docker [#]_ .
A properly functioning Docker setup on your local machine is a requirement for the
exercises we will do later. Note that Podman is an acceptable substitute for Docker, as
detailed later in this chapter.

.. [#] https://docs.docker.com/get-docker/

Once you have Docker installed and running on your workstation, take a look at
the two example files below. For now it's OK to see them and
get a general familiarity with their contents. Later we will use these files to
create containers for our projects.

**********
Dockerfile
**********

The Dockerfile is our basic unit of containerization. That is to say, our
containers, and the applications they contain, are defined by the Dockerfile. This Dockerfile
will dictate how we provision resources and include operating system essentials and packages
inside our container. Each Dockerfile is predicated on a base image, such as Python/Debian 10 as
shown in the example below.

Consider a directory named
`Docker <https://github.com/hotpeppersec/rapid_secdev_framework/tree/master/docker>`_
and a file called
`Dockerfile <https://github.com/hotpeppersec/rapid_secdev_framework/blob/master/docker/Dockerfile>`_ within
this directory. Note the capitalization of the first letter in the file name.
Some IDE's will key off this file and allow for additional syntax highlighting.

.. index::
   single: Dockerfile

.. code-block:: bash
   :caption: An example Dockerfile
   :name: Dockerfile
   :linenos:

   FROM python:3.9-buster
   LABEL maintainer "Kevin Flynn <user@example.com>"

   ENV DEBIAN_FRONTEND noninteractive

   ADD . /project
   WORKDIR /project

   RUN apt update; \
      apt -y install apt-utils

A valid Dockerfile begins with the **FROM** instruction. This instruction specifies the base image
that we will use to build our project on. These base images come from the `Docker Hub repositories`_.
We are setting an environment variable **DEBIAN_FRONEND** to the value of `noninteractive`, which
will cause the `apt` command to skip or ignore any interactive menus that are encountered during
execution of the apt command, since these would cause our builds to "hang up" at an inaccessible
interactive prompt. The **ADD** and **WORKDIR** directives are meant to cause Docker to use the `/workdir`
directory as the root of the project "inside" the container. Finally, we are directing Docker to
**RUN** and apt update and install the apt-utils package.

.. _`Docker Hub repositories`: https://docs.docker.com/docker-hub/repos/

******************
docker-compose.yml
******************

The docker-compose tool and its associated docker-compose.yml file allows us to manage
multiple Docker containers for one or more applications. We will add this file to our
project to illustrate it's composition and give ourselves the ability to extend our work
later, as needed.

A file called docker-compose.yml will exist alongside our `Dockerfile` in our docker
directory.

.. index::
   single: docker-compose.yml

.. code-block:: bash
   :caption: An example docker-compose.yml file
   :name: docker-compose.yml
   :linenos:

   version: '3'
   services:
   devsecops:
      hostname: devsecops
      container_name: devsecops
      volumes:
         - ..:/project
      build:
         context: ..
         dockerfile: docker/Dockerfile

The `docker-compose.yml` file begins with a version specification. It's important to
note that the commands and structure of `docker-compose.yml` can vary widely based on
this version. While versions cannot be mixed, all version are valid with respect to
docker-compose itself. Wew specify a service named "devsecops", and assign a host and
container name. Under "volumes" we are mounting the base of the project directory in the
host filesystem as "/project" in the container filesystem. The build "directive" tells
docker-compose how to locate the Dockerfile we wish to use for the containers.

****************************
Exercise: Testing Out Docker
****************************

With Docker properly installed and an understanding of the necessary configuration files,
we can now try out our configuration. See (:numref:`myFig1`) for an illustration of
how to lay out the project files in your local filesystem.

.. raw:: latex

    \clearpage

.. graphviz::
   :caption: Project Directory and Docker related files.
   :align: center
   :name: myFig1

   digraph folders {
      "rapid_secdev_framework" [shape=folder];
      "docker" [shape=folder];
      "docker-compose.yml" [shape=rect];
      "Dockerfile" [shape=rect];
      "rapid_secdev_framework" -> "docker";
      "docker" -> "Dockerfile";
      "docker" -> "docker-compose.yml";
   }

Here is a step by step description of how to prepare the creation of our first
container:

- Create the "rapid_secdev_framework" folder.
  - When creating folders, note that capitalization matters.
- In that folder, create another folder called "docker".
- Now in the docker folder, create a text file with the name "Dockerfile".
  - Copy and paste the example Dockerfile from earlier in this chapter into your text file.
- Also in the docker folder, create a text file with the name "docker-compose.yml"
  - Copy and paste the example docker-compose.yml file from earlier in this chapter into your second text file.

Here is an example of the BASH shell commands you can use to accomplish the steps
of the exercise. You can substitue vi for your favorite text editor as needed. Note
that typing the "docker-compose" command on line 6 will reference the devsecops
"service" we specified on line 3 of the docker-compose.yml file.

.. code-block:: bash
   :caption: Steps to test Docker configuration.
   :name: Steps to test Docker configuration.
   :linenos:

   mkdir rapid_secdev_framework
   cd rapid_secdev_framework
   mkdir docker
   vi docker/Dockerfile
   vi docker/docker-compose.yml

With our files created and populated, we are ready to generate our container
based on our specified configuration.

.. code-block:: bash
   :caption: Build the Docker container.
   :name: Build the Docker container.
   :linenos:

   docker-compose -f docker/docker-compose.yml build devsecops

If all went well, you should now have a shell prompt from "inside" the new container.
Recall that we set our **WORKDIR** variable to `/project` in the Dockerfile.
Following that example, we now have `Dockerfile` and `docker-compose.yml`
in the directory `/project/docker`, having mounted the project directory from the
host machine "inside" the container.

Testing from GitHub
*******************

It should be noted that the link to the GitHub repository for the accompanying project
for this book is
`https://github.com/hotpeppersec/rapid_secdev_framework`_. In the next chapter we will
explore how to "clone" the project repository and do our work directory from there.

.. _`https://github.com/hotpeppersec/rapid_secdev_framework`: https://github.com/hotpeppersec/rapid_secdev_framework

******************************
Substituting Podman for Docker
******************************

Podman is an Open Source container engine from the Open Containers Initiative (OCI). The
Podman service is purportedly capable of being a drop-in replacement for Docker, although
it only runs on Linux hosts at the time of this writing. Podman gives the user the ability to
use traditional Docker commands, without the need to run a daemon to do so, as is the case
with Docker. `According to William Henry of Red Hat Inc`_ , the Podman approach is simply to
directly interact with the image registry, with the container and image storage, and with
the Linux kernel through the runC container runtime process (rather than with a daemon).

.. _`According to William Henry of Red Hat Inc`: https://developers.redhat.com/blog/2019/02/21/podman-and-buildah-for-docker-users/

.. index::
   single: Podman
   single: Open Containers Initiative (OCI)

You can install Podman by `following the instructions`_ at their web site.

.. _`following the instructions`: https://podman.io/getting-started/installation.html

Here is the change for the `unprivileged_userns_clone` error:

.. code-block:: bash

   user@devsecops::~$ podman
   cannot clone: Operation not permitted
   user namespaces are not enabled in /proc/sys/kernel/unprivileged_userns_clone
   Error: could not get runtime: cannot re-exec process
   user@devsecops::~$ sudo sysctl kernel.unprivileged_userns_clone=1
   user@devsecops::~$ podman-v
   podman version 1.9.1

Once Podman is installed properly you should be able to `alias docker=podman`
and use it as a drop in replacement for docker.

***********************
Container Orchestration
***********************

An orchestrator for containers can be thought of as an engine which allows for their
provisioning, deployment, scaling, monitoring, load balancing, and more. The Container
Orchestrator is meant to manage the lifecycle and visibility of a container at all
stages.

Kubernetes is an example, perhaps the penultimate example, of a Container Orchestrator.
Folks throughout the DevSecOps, Software and Security communities are using Kubernetes these
days, and with good reason.  It's adoption as a means to manage and replicate
containers, and scale the applications they contain, has been nothing short of revolutionary.
System administrators and developers can do more, better work. Granted, this comes at the
expense of introduction yet another framework to learn, and and no small amount of complexity.

.. index::
   single: Kubernetes
   single: Orchestration

An orchestrator helps us achieve immutability, and scale to meet user demand quickly and easily
by abstracting away concerns that come with operating workloads in a bare metal or VM
environment.

Kubernetes and other orchestrators are rapidly evolving. To ignore this game-changing
ecosystem is to be left behind in terms of technological prowess. That said, it's just beyond
the scope of this book. Learning about containers, pipelines, infrastructure, and so on
are the foundational elements you will want to become familiar with in preparation for
expanding your mindset into the greater dimensionality that orchestration realizes.

For this stage of our journey to DevSecOps enlightenment, it is enough to know that
orchestration exists and have a bit of familiarity with its purpose.
