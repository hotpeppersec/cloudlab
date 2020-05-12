.. include:: global.rst

==============
Infrastructure
==============

.. image:: ../images/cologne-cathedral-1507854_1920.jpg
   :align: center

This chapter details our ability to quickly and uniformly stand up 
and tear down servers and networks to run our workloads. We will look
at some popular cloud computing providers and then delve into ways we
can leverage them to our benefit.

***************************
Google Cloud Platform (GCP)
***************************

Google Cloud Platform (GCP) is a suite of cloud computing 
services that runs on the same infrastructure that Google uses internally 
for its end-user products [#]_ .

.. [#] https://cloud.google.com/

One of the very first things you should do (after creating an account, 
that is) is to configure two-factor authentication [#]_ (2FA).

.. [#] 2FA: https://www.google.com/landing/2step/

.. index::
   single: two-factor authentication



*************************
Amazon Web Services (AWS)
*************************

One of the very first things you should do (after creating an account, 
that is) is to configure mutli-factor authentication [#]_ (MFA).

.. [#] MFA: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html

.. index::
   single: multi-factor authentication

Amazon's AWS is one of the more prevalent cloud providers in terms of
popularity and simultaneously mature and ever-expanding feature set.

*************
Digital Ocean
*************

One of my favorite things about this provider is their collection of tutorials
that they maintain. You can pick up lots of tips and tricks sbout the topics 
in this book by going through their site.

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
      "cloudlab" [shape=folder];
      "gcp" [shape=folder];
      "aws" [shape=folder];
      "digital_ocean" [shape=folder];
      "cloudlab" -> "aws";
      "cloudlab" -> "digital_ocean";
      "cloudlab" -> "gcp";
   }