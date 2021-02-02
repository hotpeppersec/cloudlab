.. include:: global.rst

====
Ruby
====

.. image:: ../images/crab-298346_1920.jpg
   :align: center

|

"Ruby is simple in appearance, but is very complex inside, just 
like our human body. [#]_ " Yukihiro “Matz” Matsumoto

.. [#] Matz, speaking on the Ruby-Talk mailing list, May 12th, 2000.

Getting some Ruby basics under your belt is very helpful if you think
you will be doing future work with puppet, including facter and rspec.

.. index::
   single: Ruby

*******
Gemfile
*******

Similar in nature to a requirements file for Python, a Gemfile for a Ruby
project is used to specify the list of Rubygems to install, as well as giving
a choice on where to install those gems from.

Consider the following simple example of a Gemfile.

.. index::
   single: Rubygems
   single: Gemfile

.. code-block:: Ruby
   :caption: Simple example of a Gemfile
   :name: Simple example of a Gemfile

    source "https://rubygems.org"
    gem "unicode"

Relevant files and folders mentioned in this chapter are organized as seen below.

.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      "/home/secdevops" [shape=folder];
      "workspace" [shape=folder];
      "devsecops" [shape=folder];
      "python" [shape=folder];
      "ruby" [shape=folder];
      "Gemfile" [shape=rectangle];
      "/home/secdevops" -> "workspace";
      "workspace" -> "devsecops";
      "devsecops" -> "python";
      "devsecops" -> "ruby";
      "ruby" -> "Gemfile";
   }