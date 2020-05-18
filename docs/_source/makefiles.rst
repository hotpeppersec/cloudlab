.. include:: global.rst

=========
Makefiles
=========

.. image:: ../images/books-1163695_1920.jpg
   :align: center

A Makefile is a good way to put shorts sets of oft repeated steps 
at the fingertips of the developer. Rather than typing three complicated and 
possibly hard to recall strings to kick off your Docker container, you 
can simply type `make docker` and have everything build as desired. We're 
going to be using GNU Make for our projects.

.. index::
   single: Makefile

*******************
The PHONY Directive 
*******************

If a file or directory exists with the same name as a stanza in the 
Makefile, you will need to specify it under the *PHONY* directive. This
will allow the Makefile to find and run the desired commands.

Consider this example, where we have three directories (docker, docs, 
and python) and we also have three Makefile directives of the same name:

.. code-block:: bash

    .PHONY: docker docs python

*******
Targets
*******

Makefiles are comprised of various stanzas, know as targets. This is where 
the work gets done. Let's add a target for Docker and a target for Python 
to make our lives easier in the future. Consider the two target stanzas below.

When the `docker` target is called by the use when `make docker` is typed at
the CLI, the fist thing that happens is the `python` target is called. If the
`python/requirements.txt` file exists, we attempt to install the modules listed
therein with the Python "pip" package manager. Once completed, the thread of 
execution returns to the docker target, sending the user a message to stdout that
we will be building with docker-compose. After a quick check for existence of the 
file `/.dockerenv`, we use docker-compose to build from our Dockerfile, and then 
start a BASH shell in our "cloudlab" container. 

.. code-block:: bash

   docker: python ## build docker container for testing
      echo "Building CloudLab with docker-compose"
      @if [ -f /.dockerenv ]; then \
      printf "***> Don't run make docker inside docker container <***" && exit 1; fi
      docker-compose -f docker/docker-compose.yml build cloudlab
      @docker-compose -f docker/docker-compose.yml run cloudlab /bin/bash

   python: ## setup python3
      if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make python inside docker container" && exit 1; fi
      $(MAKE) print-status MSG="Set up the Python environment"
      if [ -f 'python/requirements.txt' ]; then \
      python -m pip install -rpython/requirements.txt; fi

Be sure when you indent in a Makefile that you use tabs, not spaces.
You can use the backslash character to combine two consecutive lines into 
one logical line.

*********************
Full Example Makefile
*********************

Here is a full example of a working Makefile. 

.. code-block:: shell

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
   
.. raw:: latex

    \clearpage
    
*********************************
Directory Structure with Makefile
*********************************

Relevant files and folders related to our Makefile are organized as
seen below.

.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      "cloudlab" [shape=folder];
      "python" [shape=folder];
      "docker" [shape=folder];
      "terraform" [shape=folder];
      "Makefile" [shape=rect];
      "docker-compose.yml" [shape=rect];
      "Dockerfile" [shape=rect];

      "cloudlab" -> "python";
      "cloudlab" -> "terraform";
      "cloudlab" -> "docker";
      "cloudlab" -> "Makefile";
      "docker" -> "Dockerfile";
      "docker" -> "docker-compose.yml";
   }