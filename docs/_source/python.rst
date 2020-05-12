.. include:: global.rst

======
Python
======

.. image:: ../images/snake-1634293_1920.jpg
      :align: center

An item of note, Python3 is the only choice at this point. Python
2.x End of Life was January 1st, 2020 [#]_ .

.. [#] https://github.com/python/devguide/pull/344 

.. index::
   single: Python3

*****************
Requirements File
*****************

We will make use of a requirements file under `python/requirements.txt` so we can 
manage the required Python modules needed to build and run the Python portions of our
project.

*****************
Test requirements
*****************

Some requirements are strictly intended to be part of the test harness, but are not 
needed for the application proper. Using a separate file, such as `python/requirements-test.txt`
makes this delineation clear to other develoeprs and folks who are not familiar with 
the project.

********************
The __init__.py File
********************

We add this file to let the Python interpreter know that the directories
it is found in are a contiguous part of our project. Since module imports and
function definitions in this file are availabel to all the python code files
in the directory, we can use it to our advantage. For example, try adding this 
quick and dirty logging function to `__init__.py`:

.. code-block:: python

   '''
   Configure logger
   '''
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

Check the results in the file `/var/log/cloudlab/cloudlab.log`.

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
      "requirements.txt" [shape=rectangle];
      "requirements-test.txt" [shape=rectangle];
      "__init__.py" [shape=rectangle];
      "/home/secdevops" -> "cloudlab";
      "cloudlab" -> "python";
      "python" -> "__init__.py";
      "python" -> "requirements.txt";
      "python" -> "requirements-test.txt";
   }