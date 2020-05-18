.. include:: global.rst

========
Cloudlab
========

.. image:: ../images/sky-690293_1920.jpg
   :align: center

At the time of this writing in 2020, about 40% of production workloads are 
running on containers and serverless deployments.  Bare metal and virtual machines currently host 
a bit over 60% of production workloads. Containerized workload use is expected to 
increase in the coming years. Conversely, bare metal and VM usage is expected 
to decrease [#]_ . It's not a question of if, but how quickly commoditization of 
compute resources takes place, leaving only a few main providers of these resources.
This is not unlike how power generation and distribution became centralized, now
the domain of a few large utility companies. Nothing beyond considerations of 
practicality stop you from making your own electricity, but you may wish to invest
your time in other pursuits.

.. [#] https://start.paloaltonetworks.com/esg-research-cloud-native-devsecops-report.html 

In this book, we will explore a combination of techniques that can refresh
your skills and align your projects with current software development techniques. 
We can use small bits and pieces from various technolgies to create a secure build 
pipeline for our lab and development work, test, and even production environments. 
The techniques here are meant to help the security-minded developer sharpen her or his
skills, and introduce tips and tactics that benefit the teams they are a part of.
There are many, many ways to reach similar goals these days with the preponderance
of Open Source and commercial tools available. By focusing on a few we can blaze a
trail to success in our projects.

We have a goal in mind of selecting complementary tools and process to construct 
and streamline our ways of working. We will attempt to leverage these ways to 
get us quickly and securely to a working lab environment. At the same time we 
should strive for simplicity and reduction of complexity whenever possible.
Complexity in our processes beome the snags and side projects that are the enemy 
of productivity. Refuse to shave more yaks than absolutely necessary!

===============
Getting Started
===============

Let's quickly look at the objectives for this book.

- Create an extensible lab environment for rapid prototyping and development.
- Get out of our old comfort zone, into a new one.
- Keep our lab costs down while meeting the rest of the objectives.
   - Utilize free services and open source tools to the extent possible.
- Always leave our project in a functional state.

The ideas captured here are not means to any end. Rather, these are meant to 
be starting points that give you the momentum with technologies and techniques
that will streamline your projects. Your job is to keep experimenting and to 
see what is useful enough to stick with you. You will build up
a solid base of code examples and problem solving snippets that will greatly 
increase you efficacy. Over time, tools and processes will rotate in and out of 
your toolbox as technology matures.

Companies will make their services free in the hopes that you will see the value
and usefulness of their products. The hope is that you will see enough utility 
that you will recommend them to your enterprise clients and integrate their 
stuff into your workflows. Not a bad trade-off!

Finally, I've found it very helpful for my peace of mind to always leave my
projects clean and green before walking away from my work station for the day.
Hopefully you find similar benefit should you choose to adopt this practice.

*************
Prerequisites
*************

This book assumes the reader has some basic knowledge of certain concepts. We will
be exploring new ways of working for folks who are somewhat familiar with:

- Linux (UI and command line)
- Python 3
- Familiarity with github.com and the concepts of pull requests and branching.

To follow along with the examples in this book you will need a host running
a recent version of Linux, or another UNIX variant. An Apple laptop
would also be a good choice. Other operating systems may work as well,
if they have the ability to run a BASH shell, install open source 
packages, etc. Support for environments other than Linux or Mac are
beyond the scope of this book.

It is not necessary to install Python 3 locally, since we will contain
Python and it's dependencies to an instance of Docker.

Let's take a look at some of the other foundational environmental elements
we need in place to be successful.

The Workhorse (IDE)
===================

I find it extremely helpful to have an Integrated Development Environment
(IDE) that I don't have to spend a lot of time configuring. Lately that 
is Visual Studio Code [#]_ for me. It works well on both Linux, Mac and other 
operating systems as well. The 
environment is easily extensible to support most any language, linter, or
syntax checker we may have a need for. Folks also seem to be quite fond of Sublime [#]_ 
for it's extensibility.

.. [#] https://code.visualstudio.com/Download
.. [#] https://www.sublimetext.com/

.. index::
   single: VSCode
   single: Sublime

There are times I catch myself switching between VSCode and a terminal
window to do a quick edit in vi or interact with GitHub. Over time I am 
changing the way I work in an attempt to reduce attempts to refocus 
between windows on my desktop.

.. image:: ../images/setup-vscode.png
   :align: center