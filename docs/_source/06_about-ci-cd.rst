.. include:: global.rst

===================================
Continuous Integration & Deployment
===================================

.. image:: ../images/finland-905712_1920.jpg
   :align: center

|

Accomodations for Continuous Integration (CI) & Continuous Deployment (CD) in our projects
directly corresponds to our chances of success.

.. index::
   single: CI
   single: Continuous Deployment
   single: CD 
   single: Continuous Integration
   
*******
Linters
*******

There are small programs for most (every?) language that you can run before
pushing your changes to GitHub that will catch syntactical and sometimes even
programmatic issues. Consider Python, which is very sensitive with regard to 
indentation. You can programatiacally detect and even correct issues before your
work gets too far down the pipe. This is also a good way to make sure folks
are not committing dirty code to your repositories.

.. index::
   single: lint
   single: linters
   
Here are some of the linters I have found useful for languages I encounter frequently.

.. list-table:: Linters
   :header-rows: 1

   * - Language
     - Name
     - Source
   * - Ansible
     - ansible-lint
     - python (pip install ansible-lint)
   * - Markdown
     - mdl
     - ruby (gem install mdl)
   * - Puppet
     - puppet-lint
     - ruby (gem install puppet-lint) [#]_
   * - Python
     - pylint/flake8
     - python (pip install pylint/flake8)
   * - Terraform
     - tflint
     - https://github.com/terraform-linters/tflint

.. [#] http://puppet-lint.com/

****************
Linting with Tox
****************

Recall that we are using Tox as our main test framework. 
To set up Tox to do our linting work for us, we can add an environment 
to our envlist called "pylint" and then declare it in a new stanza in 
tox.ini. Notice how we let "deps" do the work of installing the "pylint"
dependency for us.

.. index::
   single: pylint

.. code-block:: python
   :caption: Directing Tox to perform code linting
   :name: Directing Tox to perform code linting
   :linenos:

  [tox]
   envlist = py38. pylint
   skip_missing_interpreters = true

  [pylint]
  deps =
    pylint
  commands=
    # the -rn flag will suppress report output (warnings)
    pylint -rn --rcfile=.pylintrc my_resume/my_resume.py

**************
GitHub Actions
**************

GitHub Actions is a recent introduction to the github.com website that lets you perform 
Continuous Integration on your repository, and Continuous Deployment as desired.

.. index::
   single: GitHub Actions

Docker
======

Let's see how we can leverage Actions to build the docker target in our project. Save this
YAML file under `codelab/.github/workflows/docker_compose.yml` to have GitHub Actions execute 
our `make docker` target from our custom Makefile.

.. code-block:: yaml
   :caption: Directing GitHub Actions to execute our make docker directive
   :name: Directing GitHub Actions to execute our make docker directive
   :linenos:

  ---
  name: CloudLab Docker Image CI
  on:
    push:
      branches: [ master ]
    pull_request:
      branches: [ master ]
  jobs:
    build:
      runs-on: ubuntu-latest
      env:
        SHODAN_KEY: ${{ secrets.shodanKey }}
      steps:
      - uses: actions/checkout@v2
      - name: Set up Python 3.8
        uses: actions/setup-python@v1
        with:
          python-version: 3.8
      - name: Build the docker-compose stack
        run: |
          sudo apt -y install python3-setuptools
          make docker

Python
======

Save this YAML file under `codelab/.github/workflows/python.yml` to have GitHub Actions execute 
our `make python` target from our custom Makefile.

.. code-block:: yaml
   :caption: Directing GitHub Actions to execute our make python directive
   :name: Directing GitHub Actions to execute our make python directive
   :linenos:
  
  ---
  name: CloudLab Python CI
  on:
    push:
      branches: [ master ]
    pull_request:
      branches: [ master ]
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
      - uses: actions/checkout@v2
      - name: Set up Python 3.8
        uses: actions/setup-python@v1
        with:
          python-version: 3.8
      - name: Install dependencies
        run: make python
      - name: Lint with flake8
        run: |
          pip install flake8
          # stop the build if there are Python syntax errors or undefined names
          flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
          # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
          flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
      - name: Test with pytest
        run: |
          sudo mkdir -p /var/log/cloudlab
          sudo chmod 777 /var/log/cloudlab
          make test

Packer
======

Save this YAML file under `codelab/.github/workflows/packer.yml` to have GitHub Actions validate
and build our AMI image with Packer.

.. index::
   single: Packer

.. code-block:: yaml
   :caption: Build Packer image via GitHub Actions
   :name: Build Packer image via GitHub Actions
   :linenos:

  ---
    name: Packer
    on:
      push:
    jobs:
      packer:
        runs-on: ubuntu-latest
        name: packer
        steps:
          - name: Checkout Repository
            uses: actions/checkout@v2
          - name: Python setup
            uses: actions/setup-python@v1
            with:
              python-version: '3.8' # Version range or exact version of a Python version to use, using SemVer's version range syntax
              architecture: 'x64' # optional x64 or x86. Defaults to x64 if not specified
          - name: Install Python Goodies
            run: python -m pip install -rpython/requirements.txt
          # fix backwards incompatibilities in template
          - name: Fix Template
            uses: operatehappy/packer-github-actions@master
            with:
              command: fix
              target: packer/aws-debian-host.json
          # validate templates
          - name: Validate Template
            uses: operatehappy/packer-github-actions@master
            with:
              command: validate
              arguments: -syntax-only
              target: packer/aws-debian-host.json
    
          # build artifact
          - name: Build Artifact
            uses: operatehappy/packer-github-actions@master
            with:
              command: build
              target: packer/aws-debian-host.json
              arguments: "-color=false -on-error=abort"

Markdown
========

The following example YAML file illustrates how to validate GitHub flavored Markdown
text files using a GitHub Action.

.. index::
   single: Markdown
   single: markdownlint

.. code-block:: yaml
   :caption: Validate Markdown files via GitHub Actions
   :name: Validate Markdown files via GitHub Actions
   :linenos:

  name: CI
  on:
    push:
      branches: [ master ]
    pull_request:
      branches: [ master ]
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
      - uses: actions/checkout@v2
      - name: markdownlint-cli
        uses: nosborn/github-action-markdown-cli@v1.1.1
        with:
          files: .
        config_file: ".markdownlint.json"

Note the designation of a configuration file named `.markdownlint.json` at the top
level of our repository. This JSON file is used to skip certain checks by the markdownlint tool.

.. code-block:: json
   :caption: Skip the listed Markdown lint checks
   :name: Skip the listed Markdown lint checks
   :linenos:

  {
      "default": true,
      "MD013": false,
      "MD033": false,
      "MD041": false,
      "MD047": false
  }

*********
Circle CI
*********

Circle CI is a Continuous Integation service free for non-commercial projects. 

.. index::
   single: Circle CI

.. code-block:: yaml
   :caption: A YAML file for Circle CI configuration
   :name: A YAML file for Circle CI configuration
   :linenos:

  # Python CircleCI 2.0 configuration file
  # 
  # Check https://circleci.com/docs/2.0/language-python/ for more details
  # 
  version: 2
  jobs:
    build:
      docker:
        # specify the version you desire here
        # use `-browsers` prefix for selenium tests, e.g. `3.6.1-browsers`
        - image: circleci/python:3.6.1
          environment:
            FLASK_APP: my_resume.py
            FLASK_DEBUG: 1
      # Specify service dependencies here if necessary
      # CircleCI maintains a library of pre-built images
      # documented at https://circleci.com/docs/2.0/circleci-images/
      # - image: circleci/postgres:9.4
      working_directory: ~/repo
      steps:
        - checkout
      # Download and cache dependencies
        - restore_cache:
            keys:
              - v1-dependencies-{{ checksum "requirements/requirements.dev" }}
              # fallback to using the latest cache if no exact match is found
              - v1-dependencies-
        - run:
            name: install dependencies
            command: |
              python3 -m pip install --user virtualenv
              ~/.local/bin/virtualenv venv
              . venv/bin/activate
              python3 -m pip install -r requirements/requirements.dev
    test:
      docker:
        - image: circleci/python:3.6.1
          environment:
            FLASK_APP: my_resume.py
            FLASK_DEBUG: 1
      working_directory: ~/repo
      steps:
        - checkout
      # Download and cache dependencies
        - restore_cache:
            keys:
              - v1-dependencies-{{ checksum "requirements/requirements.dev" }}
              # fallback to using the latest cache if no exact match is found
              - v1-dependencies-
        - run: 
            name: run tests
            command: |
              python3 -m pip install --user virtualenv
              python3 -m pip install --user tox
              #~/.local/bin/virtualenv venv
              #. venv/bin/activate
              #python3 -m pip install --user -r requirements/requirements.dev
              echo "lets do some testing"
              # move test commands to tox.ini
              #~/.local/bin/tox -e venv
              ~/.local/bin/tox
  workflows:
    version: 2
    build_and_test:
      jobs:
        - build
        - test


********
TravisCI
********

Travis CI is a hosted continuous integration service used to build and test software projects 
hosted at GitHub and Bitbucket. They have a great tutorial available [#]_ if you care to 
dig a bit deeper.

.. [#] https://docs.travis-ci.com/user/tutorial/

By enabling Travis CI integration through the GitHub Marketplace [#]_ you can
integrate their scanners with your repository.

.. [#] https://github.com/marketplace/travis-ci

.. index::
   single: Travis CI

Docker
======

You can test Docker containers in your CI/CD pipeline. As seen in the following example I 
created a YAML file named `.travis.yml` to enable automatic molecule 
testing of ansible roles in Travis CI. I also set a flag in the repo settings 
that prevent the PR from being merged until Travis CI flags the build as passing.

.. index::
   single: Docker
   single: Molecule

.. code-block:: yaml
   :caption: Testing Ansible using Molecule in Travis CI
   :name: Testing Ansible using Molecule in Travis CI
   :linenos:
  
    ---
    sudo: required
    dist: xenial   # required for Python >= 3.7
    language: python
    services: 
      - docker
    python:
      - "3.7"
      - "3.8"
    before_install:
      - sudo apt-get -qq update
      - python3 -m pip install wheel
      - python3 -m pip install -rrequirements.txt
      - python3 -m pip install -rrequirements-test.txt
    script: 
      - cd playbooks/roles/webserver && molecule test

The contents of the requirements files and the example Ansible code is available in 
the cloudlab repo.

Markdown
========

Save these lines to a file named `.travis.yml` to scan all the markdown
files in your repository.

.. index::
   single: Markdown

.. code-block:: yaml
   :caption: Validating Markdown files using Travis CI
   :name: Validating Markdown files using Travis CI
   :linenos:

    ---
    sudo: required
    services:
      - docker    
    before_install:
      - sudo apt-get -qq update
      - gem install mdl --no-ri --no-rdoc
    script:
      - mdl -c .mdlrc .

You can also create an `.mdlrc` file to give `mdl` direction on what to scan for.

.. index::
   single: .mdlrc

.. code-block:: bash
   :caption: An example .mdlrc file to configure the mdl (markdownlint) tool
   :name: An example .mdlrc file to configure the mdl (markdownlint) tool

   rules "MD001" ,"MD002" ,"MD003" ,"MD004" ,"MD005" ,"MD006" ,"MD007" ,"MD009" ,"MD010" ,"MD011" ,"MD012" ,"MD014" ,"MD018" ,"MD019" ,"MD020" ,"MD021" ,"MD022" ,"MD023" ,"MD025" ,"MD026" ,"MD027" ,"MD028" ,"MD029" ,"MD030" ,"MD031" ,"MD032" ,"MD034" ,"MD035" ,"MD036" ,"MD037" ,"MD038" ,"MD039" 

.. raw:: latex

    \clearpage

*******************
Directory Structure
*******************

Relevant folders and files related to our build pipeline are shown below. The
users home directory and `workspace` subdirectory is implied and removed from 
the diagram for clarity.

.. graphviz::
   :caption: GitHub Actions
   :align: center

   digraph folders {
      "cloudlab" [shape=folder];
      ".github" [shape=folder];
      "workflows" [shape=folder];
      ".circleci" [shape=folder];
      "config.yml" [shape=rectangle;]
      "docker_compose.yml" [shape=rectangle];
      "packer.yml" [shape=rectangle];
      "python.yml" [shape=rectangle];
      "markdown.yml" [shape=rectangle];
      ".travis.yml" [shape=rectangle];
      ".mdlrc" [shape=rectangle];
      ".markdownlint.json" [shape=rectangle];
      "cloudlab" -> ".github";
      "cloudlab" -> ".mdlrc";
      "cloudlab" -> ".travis.yml";
      "cloudlab" -> ".markdownlint.json";
      "cloudlab" -> ".circleci";
      ".circleci" -> "config.yml";
      ".github" -> "workflows";
      "workflows" -> "docker_compose.yml";
      "workflows" -> "markdown.yml";
      "workflows" -> "packer.yml";
      "workflows" -> "python.yml";
   }
