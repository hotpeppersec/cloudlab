# blank section header

Over the past five or so years I've been doing security development work, 
previously at SalesForce and now at Palo Alto Networks. I've developed a 
pattern of working that allows me to rapidly prototype 
ideas and get them through the CI/CD pipeline and into production. 

This book is me capturing that way of working as a teachable framework 
for experimentation and giving folks a way to affordably access some of the
latest and greatest technologies available today. The information it contains
is suitable for folks new to the information security, information technology, 
and software industries, as well as season professionals looking to expand 
their skillsets. I like to thin of this framework as a path that folks can follow
to get into the world of software development and operations, more commonly known as "DevOps".

This book introducs technologies in a specific order. We will explore just enough of those technologies to take an example project from local development environment, through our build/test/integration pipeline, and finally to our lab environment hosted on a cloud provider such as Google Cloud or Amazon Web Services. While it is possible
to show the example project working in multiple cloud service providers, I am now
leaning towards focusing on one, AWS, to reduce the complexity. 

The first concept explored in this book is the idea of containerization. More specifically, how to enact containerization using Docker and docker-compose. 
This allows for an ephemeral, immutable environment that we can build and test ideas. 
In other words, our environments are intentionally short-lived, and are meant to 
be destroyed and rebuilt, instead of upgraded as is typically done with traditional
hosts.

Next we touch on revision control as an idea. In particular, we'll use GitHub. We touch on the key steps in setting up a GitHub account, and properly configuring it. This is 
in preparation for working with our follow-along example project.

We then explore Python 3.x as the workhorse language for building out ideas 
in our projects. Readers are introduced to Pythons large library of modules and shown
how to include these in their projects. We could easily include the same pattern
 in this section, but use the Ruby language instead. It has been left out to reduce the complexity.

Now we're ready to look at Makefiles as a way to start to tie these technologies together. Makefiles give us a way to programatically build and control the preceeding technologies. We will show how a Makefile can be used with Docker and Python as 
Makefile targets. As we move forward we will continue to add more targets to our
Makefile. This also simplifies the work we want to do in the build & test portions of
our deployment pipeline.

The CI/CD section is where we begin to talk about the pipelines that deliver our work 
from our local containers, funneling changes to our "cloud" setup in AWS. Here we 
discuss some patterns we can use to run our local containers in a remote test 
environment. 

Infrastructure section introduces the concept of the cloud provider. We explore the 
credentials and steps needed to securely interact with AWS through the command line in preparation
for some automation tools. 

Once we have the proper accounts and credentials in place, we can look at popular 
tools for programatically building server images and provisioning our cloud setups
in AWS. Understanding how to generate machine images with Packer, encrypt our data
with Vault, and maintain and provision our infrastructure as code with Terraform
are all key concepts here. Think of this section as building the house we plan to live
in, if only for a relatively short time.

The Ansible section will be about how, after the platform is created using Terraform, 
we can configure the hosts we've programatically created to meet our needs with specific software packages, provisioning of service users, etc. This might be thought of as furnishing and decorating the house we've just built.

Finally we arrive at the full test lab section, where we can discuss the cloud 
environment in GCP/AWS in it's entirety. We consider larger building blocks of the cloud
environment, various components such as firewalls and specific types of servers. 

## About the Author

Franklin Diaz is a former systems & software engineer, spending 14 years testing and developing Motorola's CDMA cellular base station products. He spent five years Salesforce where he was on the Security Detection Engineering team doing security log
aggregation and data engineering to augment and enhance the detection capabilities
of the blue team. Most recently he is at Palo Alto Networks where he works as a 
Consulting Engineer. 

He is also the lead organizer for the BSides Indy security conference in 
Indianapolis, Indiana.

Mr. Diaz has a Bachelor of Science in Computer Science from Roosevelt University, 
a Master of Science degree in Computer Information Systems from 
Northwestern University, and a Master of Science degree in Network Security & 
Network Engineering from DePaul University.

### Contact Information

```
Franklin Diaz
franklin@bitsmasher.net
(773) 960-5400
```

## Proposed Table of Contents

Here are the most recent chapter titles and count of pages written so far.

| Chapter       | Latest Page Count |
| ------------- | ----------------- |
| Getting Started | 2 |
| Containerization | 3 |
| Revision Control | 8 |
| Python | 4 |
| Makefiles | 4 |
| Continuous Integration & Deployment | 8 |
| Infrastructure | 3 |
| Tools | 11 |
| The Cloud Lab | 0 |
| Shifting Left | 0 |

## Sample Chapter

### Makefiles

A Makefile is a good way to put shorts sets of oft repeated steps at the fingertips of the developer. Rather than typing three complicated and possibly hard to recall strings to kick off your Docker container, you can simply type `make docker` and have everything build as desired. We’re going to be using GNU Make for our projects.

#### The PHONY Directive
If a file or directory exists with the same name as a stanza in the Makefile, you will need to specify it under the PHONY directive. This will allow the Makefile to find and run the desired commands.

Consider this example, where we have three directories (docker, docs, and python) and we also have three Makefile directives of the same name:

```
.PHONY: docker docs python
```

#### Makefile Targets

Makefiles are comprised of various stanzas, know as targets. This is where the work gets done. Let’s add a target for Docker and a target for Python to make our lives easier in the future. Consider the two target stanzas below.

When the docker target is called by the use when `make docker` is typed at the CLI, the fist thing that happens is the python target is called. If the `python/requirements.txt` file exists, we attempt to install the modules listed therein with the Python “pip” package manager. Once completed, the thread of execution returns to the docker target, sending the user a message to stdout that we will be building with docker-compose. After a quick check for existence of the file `/.dockerenv`, we use docker-compose to build from our Dockerfile, and then start a BASH shell in our “cloudlab” container.

```
docker: python ## build docker container for testing
        echo "Building CloudLab with docker-compose"
        @if [ -f /.dockerenv ]; then \
        echo "***> Don't run make docker inside docker container <***" && exit 1; fi docker-compose -f docker/docker-compose.yml build cloudlab
        @docker-compose -f docker/docker-compose.yml run cloudlab /bin/bash

python: ## setup python3
        if [ ! -f /.dockerenv ]; then echo "Run make python inside docker container" && exit 1; fi
        echo "Set up the Python Environment"
        if [ -f "python/requirements.txt" ]; then \
            python -m pip install -rpython/requirements.txt; fi
```

Be sure when you indent in a Makefile that you use tabs, not spaces. You can use the backslash character to combine two consecutive lines into one logical line.

#### Full Example Makefile

Here is a full example of a working Makefile.

```
   .PHONY: docker docs python

   REQS := python/requirements.txt
   REQS_TEST := python/requirements-test.txt
   # Used for colorizing output of echo messages
   BLUE := "\\033[1\;36m"
   NC := "\\033[0m" # No color/default

   define PRINT_HELP_PYSCRIPT
   import re, sys

   for line in sys.stdin:
   match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
   if match:
      target, help = match.groups()
      print("%-20s %s" % (target, help))
   endef

   export PRINT_HELP_PYSCRIPT

   help:
      @python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

   clean: ## Cleanup all the things
      find . -name '*.pyc' | xargs rm -rf
      find . -name '__pycache__' | xargs rm -rf

   docker: python ## build docker container for testing
      $(MAKE) print-status MSG="Building with docker-compose"
      @if [ -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Don't run make docker inside docker container <***" && exit 1; fi
      docker-compose -f docker/docker-compose.yml build cloudlab
      @docker-compose -f docker/docker-compose.yml run cloudlab /bin/bash

   print-status:
      @:$(call check_defined, MSG, Message to print)
      @echo "$(BLUE)$(MSG)$(NC)"

   python: ## setup python3
      if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make python inside docker container" && exit 1; fi
      $(MAKE) print-status MSG="Set up the Python environment"
      if [ -f '$(REQS)' ]; then python3 -m pip install -r$(REQS); fi

   test: python ## test all the things
      if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make test inside docker container" && exit 1; fi
      $(MAKE) print-status MSG="Set up the test harness"
      if [ -f '$(REQS_TEST)' ]; then python3 -m pip install -r$(REQS_TEST); fi
      #tox
```

#### Directory Structure with Makefile

Relevant files and folders related to our Makefile are organized as seen below.


