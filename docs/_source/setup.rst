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
of Open Source and commercial tools that are available. By focusing on a few we can blaze a
trail to success in our projects.

We have a goal in mind of selecting complementary tools and process to construct 
and streamline our ways of working. We will attempt to leverage these ways to 
get us quickly and securely to a working lab environment. At the same time we 
should strive for simplicity and reduction of complexity whenever possible. Experience tells us that 
tools and process that are too cumbersome or burdensome are typically circumvented, or even abandoned. 
Complexity in our processes beome the snags and side projects that are the enemy 
of productivity. Refuse to shave more yaks than absolutely necessary!

==================
Getting Acclimated
==================

Let's start by considering the objectives for this book.

- Create an extensible lab environment for rapid prototyping and development.
- Get out of our old comfort zone, into a new one.
- Keep our lab costs down while meeting the rest of the objectives. Utilize free services and open source tools to the extent possible.
- Use the published Best Practices for each tool we choose to employ.
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

When we choose to use a tool, say Ansible for example, it only makes sense to also adopt the
most up-to-date best practices for using that tool. File system layout, naming conventions,
script syntax and organization, and so on. We get to enjoy the clear and safe path
forged by the folks that came before us, and with whom we share many goals. 

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

There are times I catch myself switching between VSCode and a terminal window to do a quick 
edit in vi or interact with GitHub. Over time I am changing the way I work in an attempt to 
reduce attempts to refocus between windows on my desktop.

.. image:: ../images/setup-vscode.png
   :align: center

********************
The Flow (Pipelines)
********************

Work products, such as code and documents for example, begin their life on developer workstations. We
will refer to this as the "local"
environment. These work products are created, reviewed and checked into revision control systems (GitHub
for example) by the DevSecOps engineer. Test cases are created and run against the work at check-in time, to ensure 
stability, security, and compatibility with the exsiting code base. The automation required to to execute
tests every time work is checked in is also the responsibility of the DevSecOps engineers. Work typically 
"flows" from the local environments, into a test environment, and finally to production. We will refer to 
the entirety of this flow as a "pipeline". Code from multiple local environments is checked in to revision
control throughout a typical workday, and continuously tested and integrated with the main code base.
That is to say, work undergoes "Continuous Inetegration" (CI) with the main code base, and often "Continuous
Deployment" (CD) between local, test, and production environments. This is where the term "CI/CD Pipeline" 
comes from.

While the CI/CD Pipeline is often the primary focus of the DevSecOps engineer, other pipelines exist as 
well. For example, Data Engineers build and maintain Data Science pipelines for to get information into a data lake, 
or for Data Scientists to be able to create machine learning models from.

******************
Learning Resources
******************

Training & Certification
========================



Social Media 
============

#mentoringmonday hashtag on twitter

Reading List
============