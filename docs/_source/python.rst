.. include:: global.rst

======
Python
======

.. image:: ../images/snake-1634293_1920.jpg
      :align: center

Getting started in writing programs is easy with Python. It is highly 
extensible since there are so many add on modules available from a 
collection known as Pypi [#]_ . It's fairly easy to learn, epecially when 
compared to other languges. Python runs everywhere for all intents and 
purposes.

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
it is found in are a contiguous part of our project. Since module imports and
function definitions in this file are available to all the python code files
in the directory, we can use it to our advantage. For example, try adding this 
quick and dirty logging function to `lib/__init__.py`:

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

A requirements file under `python/requirements.txt` includes the required
Python modules needed to build and run any Python portions of our
project.

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

Note that we can also include test requirements in our `tox.ini` file, 
detailed in the next section.

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

Example `tox.ini` file:

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

*************
Test Coverage
*************

Unit and functional testing is foundational in developing robust, 
secure code. We want to be sure that when we create new code, we are 
also adding test cases to our test suite that fully cover the new
classes, functions, and so on.

As mentioned previously, we can avail ourselves of the `coverage` module
by adding it to `test-requirements.txt` or the `deps` section of our 
tox.ini file.


.. raw:: latex

    \clearpage
    
**************************
Python Directory Structure
**************************

Files and folders relevant to the Python portions of our project are shown in the diagram below.

.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      "/home/secdevops" [shape=folder];
      "cloudlab" [shape=folder];
      "python" [shape=folder];
      "my_python_app" [shape=folder];
      "requirements.txt" [shape=rectangle];
      "requirements-test.txt" [shape=rectangle];
      "__init__.py" [shape=rectangle];
      "/home/secdevops" -> "cloudlab";
      "cloudlab" -> "python";
      "python" -> "__init__.py";
      "python" -> "requirements.txt";
      "python" -> "requirements-test.txt";
      "python" -> "my_python_app";
   }