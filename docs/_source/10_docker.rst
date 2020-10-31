.. include:: global.rst

==========
Containers
==========

.. image:: ../images/container-4203677_1920.jpg
   :align: center

Creating a fully functioning software ecosystem for our serice or 
project is known as containerization. The most popular and common
tool for acheiving containerization is Docker. Using Docker, we can
programatically build up an environment for our project, and pass the
entirety of this encapsulated environmentfrom our local development
machine, into the Continuous Integration pipeline for testing, and even 
all the way to our production environment.

With containerization of our projects, we can take advantge of 
immutability [#]_, starting in our development environment, 
the test environment and eventually our production environment. Using immutable 
containers means we have hosts that are ephemeral. Ephemerality is the 
concept of things being transitory, existing only briefly [#]_. Rather 
than spending a great deal of time patching and upgrading containers, virtual machines, 
or bare metal, we're going to quickly create a new container 
in place of the old one.

.. [#] https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure/
.. [#] https://en.wikipedia.org/wiki/Ephemerality

.. index::
   single: immutability
   single: Ephemerality
   single: Docker

Using Docker also gives us the benefit of being able to switch quickly 
between base OS images with just a few lines of code change to our project. 
See the Docker website for instructions on how to install and configure
Docker [#]_ .

.. [#] https://docs.docker.com/get-docker/

Once you have Docker installed and running on your workstation, take a look at 
the two example files below. For now it's OK to see them and
get a general familiarity with their contents. Later we will use these files to 
create containers for our projects.

***********************
Container Orchestration
***********************

**********
Dockerfile
**********

The Dockerfile is our basic unit of containerization. That is to say, our
containers, and the applications they contain, are defined by the Dockerfile.
Each Dockerfile is predicated on a base image, like Debian 10 as shown in 
the example below.

Consider a directory called `docker`_ and a file called `Dockerfile` within
this directory. Note the capitalization of the first letter in the file name.
Some IDE's will key off this file and allow for additional syntax highlighting.

.. _docker: https://github.com/hotpeppersec/rapid_secdev_framework/tree/master/docker
.. _Dockerfile: https://github.com/hotpeppersec/rapid_secdev_framework/blob/master/docker/Dockerfile

.. index::
   single: Dockerfile

.. code-block:: bash

   FROM python:3.8.2-buster
   LABEL maintainer "Franklin Diaz <franklin@bitsmasher.net>"

   ENV DEBIAN_FRONTEND noninteractive
   
   ADD . /project
   WORKDIR /project
   
   RUN apt update; \
      apt -y install apt-utils



******************
docker-compose.yml
******************

The `docker-compose.yml` file allows us to manage multiple Docker containers 
for one or more applications. We will add this file to our project so we are 
prepared to extend our work later, as needed.

.. index::
   single: docker-compose.yml

A file called `docker-compose.yml` will exist alongside our `Dockerfile`
in our `docker` directory.

.. code-block:: bash

   version: '3'
   services:
   cloudlab:
      hostname: cloudlab
      container_name: cloudlab
      volumes:
         - ..:/project
      build:
         context: ..
         dockerfile: docker/Dockerfile

.. raw:: latex

    \clearpage

**************************
Docker Directory Structure
**************************

Files and folders relevant to the Docker portion of our project 
are organized as seen below.

.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      "cloudlab" [shape=folder];
      "docker" [shape=folder];
      "docker-compose.yml" [shape=rect];
      "Dockerfile" [shape=rect];
      "cloudlab" -> "docker";
      "docker" -> "Dockerfile";
      "docker" -> "docker-compose.yml";
   }