.. include:: global.rst

=============================
Automated Repository Scanning
=============================

.. image:: ../../images/code-4333398_1920.jpg
   :align: center

|

Here are a few GitHub plugins that are free for single-user/non-commercial scenarios.
Let's leave some of the tedious work to the bots so we can focus on our journey to the
cloud!

********
Renovate
********

WhiteSource Renovate is what's known as a dependency scanner. It is free for single user to
add from the GitHub Marketplace [#]_ . It can tell you when you are using a version of a module
or image that is out of date. For example, if you have a Dockerfile that specifies Python 3.8.1,
Renovate will open a pull request on your repository to update the version string in that Dockerfile
to the most current version available. You can also grant Renovate the permissions required to
simply merge the change with no human interaction. Renovate supports JavaScript, Java, Ruby, PHP,
Python, Go, Cargo, Elixir, Docker, and more.

.. [#] https://github.com/marketplace/renovate

Once you've signed up and specified which repositories you want Renovate to monitor, it opens a
pull request to install a simple default configuration file called `renovate.json`. Merge this
initial pull request and you're up and running!

****
LGTM
****

Semmle is a company that runs a code scanning service we can use to keep
an eye on our repositories for issues with syntax and dependencies. It is tightly coupled with
github.com and can be configured from lgtm.com after logging in with your GitHub credentials.

As a fun aside, LGTM stands for "looks good to me", something developers will add as review
comments when the pull request is simple or matches expectations.

******
CodeQL
******

This just released method of scanning code semantics as we would any other data
allows you to write queries [#]_ to find issues.

.. [#] https://securitylab.github.com/tools/codeql
