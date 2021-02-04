.. include:: global.rst

==============
Infrastructure
==============

.. image:: ../images/cologne-cathedral-1507854_1920.jpg
   :align: center

|


Software Infrastructure and Platforms are the foundations upon which our 
scripts, code, and projects are founded. Infrastructure comprises the base upon 
which our containers rest, and the connectivity that allows us to communicate
with them and them with each other.

This chapter details our ability to quickly and uniformly stand up 
and tear down virtual domains and networks to connect our containers and route
their workloads. We will look at some popular cloud computing providers to 
prepare to explore ways we can leverage them to our benefit. 

A Cloud Provider is a company that offers to host our containerized projects and
virtual infrastructure so we dont have to do it ourselves. 

.. index::
   single: Cloud Provider

The virtual resources we subscribe to will be distributed across cloud provider
hardware in data centers around the world with very little oversight or interaction
from us. For example, we can choose a Region of the world for our server instance to
exist in, but we don't need to worry about which machine or rack it's in, or even where
the data center is located.

*************************
Amazon Web Services (AWS)
*************************

Consider (:numref:`myFig4`) which illustrates the connectivity of a basic project using
Amazon Web Services (AWS). 

.. index::
   single: Amazon Web Services

.. figure:: ../images/ddb-no-vpc-endpoint-1024x561.png
   :align: center
   :name: myFig4
   :alt: A simple Public Cloud configuration using AWS as a provider.
   :figclass: align-center

   A simple Public Cloud configuration using AWS as a provider.

|

Getting Set up in AWS
=====================

One of the very first things you should do (after creating an account, 
that is) is to configure mutli-factor authentication [#]_ (MFA).

.. [#] MFA: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html

.. index::
   single: multi-factor authentication
   single: AWS
   single: Amazon Web Services

Amazon's AWS is one of the more prevalent cloud providers in terms of
popularity and simultaneously mature and ever-expanding feature set.

Credentials
===========

Amazon Web Services (AWS) credentials are stored in a hidden directory in your
home directory called ".aws". The file `~/.aws/credentials` shoudl be modified to 
contain your AWS access_id and secret_key as seen below.

.. code-block:: bash
   :caption: Storing AWS Credentials in a flat file
   :name: Storing AWS Credentials in a flat file

   $ cat ~/.aws/credentials 

   [default]
   aws_access_key_id = AKIAJCQ6WHUXVOKZ8RQQ
   aws_secret_access_key = q27qR8fwdHLUh7WOEH3JVd2VHjfRlQs1jlhhbZbQ

Do not share this file with other people. Do not check this file into your GitHub 
repositories under any circumstances.

***************************
Google Cloud Platform (GCP)
***************************

Google Cloud Platform (GCP) is a suite of cloud computing 
services that runs on the same infrastructure that Google uses internally 
for its end-user products [#]_ . If the resources we allocate on GCP were a pyramid, 
the apex of that pyramid would be a "project". A project is made up of the settings, 
permissions, and other metadata that describe your applications [#]_ .

.. [#] https://cloud.google.com/
.. [#] https://cloud.google.com/docs/overview/

.. index::
   single: Google Cloud Platform
   single: GCP

One of the very first things you should do (after creating an account, 
that is) is to configure two-factor authentication [#]_ (2FA).

.. [#] 2FA: https://www.google.com/landing/2step/

.. index::
   single: two-factor authentication

At this point you are ready to install the `gcloud` software development kit (SDK)
on your local machine [#]_ .

.. [#] https://cloud.google.com/sdk/install

.. index::
   single: gcloud

Credentials
===========

Once the `gcloud` SDK is installed, you are ready to set up local credentials 
that allow interaction between your machine and the GCP application programming 
interface (API). In other words, Google hosts a server that you can exchange 
commands with to configure your GCP projects from your local CLI.

GCP credentials are stored in the directory `~/.config/gcloud` as a JSON file. 
Do not share this file with other people. Do not check this file into your GitHub 
repositories under any circumstances.

.. raw:: latex

    \clearpage

*******************
Directory Structure
*******************

Relevant folders and files related to our build pipeline are shown below. The
users home directory and `workspace` subdirectory is implied and removed 
from the diagram for clarity.

.. graphviz::
   :caption: GitHub Actions
   :align: center

   digraph folders {
      "/home/secdevops" [shape=folder];
      "devsecops" [shape=folder];
      ".config" [shape=folder];
      "gcloud" [shape=folder];
      "secdevops-my-proj-000101-420240.json" [shape=rect];
      ".aws" [shape=folder];
      "gcp" [shape=folder];
      "aws" [shape=folder];

      "/home/secdevops" -> ".aws";
      "/home/secdevops" -> ".config";
      ".config" -> "gcloud";
      "gcloud" -> "secdevops-my-proj-000101-420240.json";
      "/home/secdevops" -> "devsecops";
      "devsecops" -> "aws";
      "devsecops" -> "gcp";
   }