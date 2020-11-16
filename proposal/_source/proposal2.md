## Table of Contents

1. Getting Acclimated

   1.1.   Prerequisites

   1.2.   The Flow (Pipelines)

   1.3.   Lab Exercises

   1.4.   Colophon

   1.5.   Acknowledgements

   1.6.   About the Author

2. Containers

   2.1.   Container Orchestration

   2.2.   Dockerfile

   2.3.   docker-compose.yml

   2.4.   Docker Directory Structure

3. Revision Control

   3.1. github.com

      3.1.1. SSH Key Setup

      3.1.2. GPG Key Setup

      3.1.3. Forking and Cloning Repositories

      3.1.4. Keeping a Clone in Sync

      3.1.5. Creating Repositories 

      3.1.6. Example Repository 

      3.1.7. CODEOWNERS

      3.1.8. The .gitignore file

      3.1.9. Pull Requests

      3.1.10. Repository Settings

      3.1.11. Automated Repository Scanning

      3.1.12. Directory Structure

4. Python

   4.1. The __init__.py File

   4.2. Requirements File

   4.3. Test requirements

   4.4. Project Testing

   4.5. Test Cases

   4.6. Test Coverage 

   4.7. Python Directory Structure

5. Makefiles

   5.1. The PHONY Directive

   5.2. Targets

   5.3. Full Example Makefile

   5.4. Directory Structure with Makefile

6. Continuous Integration & Deployment

   6.1. Linters

   6.2. Linting with Tox

   6.3. GitHub Actions

   6.4. Circle CI

   6.5. TravisCI

   6.6. Directory Structure

7. Infrastructure

   7.1. Amazon Web Services (AWS)

   7.2. Google Cloud Platform (GCP)

   7.3. Directory Structure

8. Tools

   8.1. Packer

   8.2. Terraform

   8.3. Ansible

   8.4. Ansible Vault

   8.5. Tool Directory Structure

9. The Cloud Lab

   9.1. Getting Started

   9.2. Infrastructure

   9.3. Applications

   9.4. Extras

## Annotated Table of Contents

### Chapter 1: Getting Acclimated

This book introduces "DevOps" technologies in a specific order, with the goal of instilling/improving the technical skills of the reader. We explore just enough of those technologies to take an example project from local development environment, through our build/test/integration pipeline, and finally to our lab environment hosted on a cloud provider such as Amazon Web Services (AWS). While it is possible to show the example project working in multiple cloud service providers, I am now leaning towards focusing on one, AWS, to reduce the complexity. 

### Chapter 2: Containers

The first concept explored in this book is the idea of containerization. More specifically, how to enact containerization using Docker and docker-compose. This allows for an ephemeral, immutable environment that we can build and test ideas. In other words, our environments are intentionally short-lived, and are meant to be destroyed and rebuilt, instead of upgraded as is typically done with traditional hosts.

### Chapter 3: Revision Control

Next we touch on revision control as an idea. In particular, we'll use GitHub. We touch on the key steps in setting up a GitHub account, and properly configuring it. This is in preparation for working with our follow-along example project.

### Chapter 4: Python

We then explore Python 3.x as the workhorse language for building out ideas 
in our projects. Readers are introduced to Pythons large library of modules and shown
how to include these in their projects. We could easily include the same pattern
 in this section, but use the Ruby language instead. It has been left out to reduce the complexity.

### Chapter 5: Makefiles

Now we're ready to look at Makefiles as a way to start to tie these technologies together. Makefiles give us a way to programatically build and control the preceeding technologies. We will show how a Makefile can be used with Docker and Python as Makefile targets. As we move forward we will continue to add more targets to our Makefile. This also simplifies the work we want to do in the build & test portions of our deployment pipeline.

### Chapter 6: Continuous Integration & Deployment

The Continuous Integration/Continuous Deployment (CI/CD) chapter is where we begin to talk about the pipelines that our work traverses, starting in our local containers, funneling changes to our "cloud" setup in AWS. Here we discuss some patterns we can use to run our local containers in a remote test environment.

### Chapter 7: Infrastructure

The Infrastructure chapter introduces the concept of the cloud provider. We explore the 
credentials and steps needed to securely interact with AWS through the command line in preparation
for some automation tools.

### Chapter 8: Tools

Once we have the proper accounts and credentials in place, we can look at popular 
tools for programatically building server images and provisioning our cloud setups
in AWS. Understanding how to generate machine images with Packer, encrypt our data
with Vault, and maintain and provision our infrastructure as code with Terraform
are all key concepts here. Think of this section as building the house we plan to live
in, if only for a relatively short time.

The Ansible section will be about how, after the platform is created using Terraform, 
we can configure the hosts we've programatically created to meet our needs with specific software packages, provisioning 
of service users, etc. This might be thought of as furnishing and decorating the house we've just built.

### Chapter 9: The Cloud Lab

Finally we arrive at the full test lab section, where we can discuss the cloud 
environment in GCP/AWS in it's entirety. We consider larger building blocks of the cloud
environment, various components such as firewalls and specific types of servers. A comprehensive project in a public GitHub repository that readers can follow 
along with an try examples from will be maintained. 

[https://github.com/hotpeppersec/rapid_secdev_framework](https://github.com/hotpeppersec/rapid_secdev_framework)
