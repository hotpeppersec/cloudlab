.. include:: global.rst

======
Python
======

.. image:: ../images/snake-1634293_1920.jpg
      :align: center

Getting started in writing programs is easy with Python. It is highly 
extensible since there are many add on modules available from a 
collection known as Pypi [#]_ . Python is fairly easy to learn, epecially when 
compared to other languges. Python runs "everywhere", for all intents and 
purposes. For all these reasons, Python is a great choice.

.. [#] https://pypi.org/

An item of note, Python3 is our only choice at this point. Python
2.x End of Life was January 1st, 2020 [#]_ . 

.. [#] https://github.com/python/devguide/pull/344 

.. index::
   single: Python3

********************
The __init__.py File
********************

We add this file to let the Python interpreter know that the directories
it is found in are a contiguous part of our Python project. Since module imports and
function definitions in this file are available to all the python code files
in the directory, we can use it to our advantage. For example, try adding this 
quick and dirty logging function to `python/cloudlab/lib/__init__.py`:

.. code-block:: python

   import logging
   from pathlib import Pathigure logger
   
   Path("/var/log/cloudlab").mkdir(parents=True, exist_ok=True)
   logging.basicConfig(
      filename="/var/log/cloudlab/cloudlab.log",
      level=logging.DEBUG,
      format="[%(asctime)s] [%(filename)s:%(lineno)s - %(funcName)5s() - 
      %(processName)s] %(levelname)s - %(message)s"
   )

Now we can create a Python file `log_test.py` and call the logger from 
within like so:

.. code-block:: python

   import logging
   from pathlib import Path

   def main():
      logging.debug('Loggy Loggerton')
   if __name__ == "__main__":
      main()

Check the results in the file `/var/log/secdevops/cloudlab.log`.


*****************
Requirements File
*****************

A requirements file under `python/requirements.txt` lists the required
Python modules needed to build and run any Python portions of our cloudlab project.
We also add a check in the Makefile to verify the existence of the `requirements.txt` 
file. The intention is, so we can quickly cut and paste the Makefile into a new project, 
but not break anything if no requirements are present yet.


.. index::
   single: requirements.txt

*****************
Test requirements
*****************

Some requirements are strictly intended to be part of the test harness, 
but are not needed for the application proper. Using a separate file, 
such as `python/requirements-test.txt`,
makes this delineation clear to folks who are not
familiar with the project. 

.. index::
   single: requirements-test.txt

Note that we can also include test requirements in our `tox.ini` file, as detailed in the next section.

***************
Project Testing
***************

Security and reliability in our lab and rapid prototyping work is just 
as important as it is in our work for the Production environment. In fact, 
you might say it's even more important since todays rapid mock ups can easily 
wind up making it into the build pipeine when folks are under a time crunch to 
deliver.

There are many test frameworks out there, lots of great ideas put forth by
the community. For our current efforts, we've settled on Tox as the framework 
of choice. It dovetails nicely with the rest of our patterns. Tox allows us
to manage requirements for virtual environments when testing, acts as a front
end to `pytest` and `coverage` modules, and much more. It is highly configurable
and extensible. For example we can test that an
application is compatible with multiple versions of Python.

.. index::
   single: Tox

Use the `make test` command inside the docker container to run the test suite
for the project.

.. index::
   single: make test

An example `tox.ini` file follow. Take notice of the "deps" section, where Python
module requirements can be specified. In our current configuration, these are in lieu 
of test harness requirements specified in our `python/requirements-test.txt` file.

.. index::
   single: tox.ini

.. code-block:: python

   [tox]
   envlist = py38
   skip_missing_interpreters = true

   [testenv]
   setenv = 
     PYTHONPATH = .
     PYTHONHTTPSVERIFY=0 
   deps = 
     coverage
     pytest
   commands = 
     coverage run -m pytest -v --capture=sys
     coverage report --omit="*/test*,.tox/*"

**********
Test Cases
**********

Unit and functional testing is foundational in developing robust, secure code. 
We want to be sure that when we create new code, we are 
also adding test cases to our test suite that fully cover the new classes, 
functions, and so on.

.. index::
   single: Test Cases (Python)

Consider the following example unit test case. The purpose is to test that the
function `check_docker()` in the file `python/cloudlab/lib/helper_functions.py` 
returns `True` when called from inside a Docker container.

.. code-block:: python

   import pytest
   from cloudlab.lib.helper_functions import check_docker


   def test_check_docker():
      assert(check_docker())

*************
Test Coverage
*************

As mentioned previously, we can avail ourselves of the `coverage` module
by adding it to `test-requirements.txt` or the `deps` section of our 
tox.ini file. The purpose is to automatically generate a report on how much of
our code is "covered" by test cases in `python/test`.

.. index::
   single: Coverage
   single: Test Coverage
    
**************************
Python Directory Structure
**************************

Files and folders relevant to the Python portions of our project are shown in the diagram below.

.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      1 [label="python", shape=folder];
      2 [label="cloudlab", shape=folder];
      3 [label="lib", shape=folder];
      4 [label="requirements.txt", shape=rectangle];
      5 [label="requirements-test.txt", shape=rectangle];
      6 [label="__init__.py", shape=rectangle];
      7 [label="__init__.py", shape=rectangle];
      8 [label="test", shape=folder];
      9 [label="cloudlab.py", shape=rectangle];
      A [label="__init__.py", shape=rectangle];
      B [label="__init__.py", shape=rectangle];
      C [label="tox.ini", shape=rectangle];
      D [label="helper_functions.py", shape=rectangle];

      1 -> 2;
      1 -> 6;
      2 -> 3;
      1 -> 4;
      1 -> 5;
      2 -> 7;
      1 -> 8;
      2 -> 9;
      8 -> A;
      3 -> B;
      1 -> C;
      3 -> D;
   }