.. include:: global.rst

=============
The Cloud Lab
=============

.. image:: ../../images/milky-way-984050_1920.jpg
   :align: center

|

We've reached the point where it's time to assemble all our functional blocks into
a proper lab using resources of a cloud service provider.

***************
Getting Started
***************

Setting up AWS
==============

Establish an AWS account.

Install Docker
==============

Install Docker on your local machine. Create a Dockerfile and docker-compose.yml.

Set Up GitHub Account
=====================

Create a GitHub account, Generate a SSH key and GPG key. Add to GitHub

Configure Project Repository
============================

Create a GitHub repo for our project. Clone the repo. Copy the Dockerfile and docker-compose.yml into the new project directory. Create a branch.
Commit the files to the branch and push to repo on GitHub.
Merge the branch, then do a pull to sync your local clone.

Configure Testing
=================

Walk through the steps of adding GitHub Actions that will validate the Terraform we will be writing to
establish our lab infrastructure.

**************
Infrastructure
**************

Lab Diagram
===========

Let's take a look at the lab environment we intend to create.

Add a Makefile
==============

Add a Makefile that will respond to the "make docker" command.

Create a Host with Packer
=========================

Write Some Terraform Files
==========================

************
Applications
************

Python Application
==================

******
Extras
******

Add a Firewall
==============

Every keep needs walls around the castle to stop the bad guys
from getting in. The Palo Alto VM-300 series firewall is available as an image that
can be installed in AWS or GCP as desired.
