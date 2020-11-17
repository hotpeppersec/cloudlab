.. include:: global.rst

=====================
DevSecOps Quick Start
=====================

.. image:: ../images/sky-690293_1920.jpg
   :align: center

|

The world is changing with respect to how how softare is created and maintained. Folks
at the leading edge in todays computing industry are not just building software, but
are curating it through a cyclical process of continuous development, testing, use, and
improvement. With increasing frequency, applications and workloads are moving to 
computing environments that are abstracted away, managed by invisible armies of engineers
at comapnies other than their own. Of course we are referring to those multitentant cloud
type computing landscapes. Passing one or more fully encapsulated applications to a cloud 
provider for the purposes of having them host it as a production environment has become
commonplace. Further, cloud service providers are adding new features and capabilites at
breakneck speed. 

At the time of this writing in 2020, about 40% of production workloads are 
running on containers and serverless deployments.  Bare metal and virtual machines currently host 
a bit over 60% of production workloads. Containerized workload use is expected to 
increase even more in the coming years. Conversely, bare metal and VM usage is expected 
to decrease [#]_ . It's not a question of if, but how quickly commoditization of 
compute resources takes place, perhaps leaving only a few main providers of these cloud resources.
This is not unlike how power generation and distribution became centralized in the previous century, now
the domain of a few large utility companies. Nothing beyond considerations of time, money, and
practicality stop you from making your own electricity, but most folks are keen to invest their 
efforts in other pursuits.

.. [#] https://start.paloaltonetworks.com/esg-research-cloud-native-devsecops-report.html 

In this book, we will explore a combination of techniques that can refresh
your skills and align your projects with the technological leading edge. 
We will introduce various popular technolgies, then use common bits and pieces of these to create a secure build 
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
a solid base of code examples and problem solving techniques that will greatly 
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

********
Colophon
********

This book was written in the reStructuredText file format [#]_ . The Sphinx module for Python
was used to format these files and programatically generate HTML, PDF, LaTeX, and other working
formats used in the typesetting process.

.. [#]  https://en.wikipedia.org/wiki/ReStructuredText

****************
Acknowledgements
****************

Creation is a long and twisty path, fraught with the distractions of a life well-lived and
the frenetic pace of a day and age that clamors for a million tiny bits of our attention. A
supportive and loving family is the touchstone that 

****************
About the Author
****************

Franklin Diaz is a Computer Scientist and lifelong computer hobbyist. He spent 14 years
as a Software Engineer, testing and developing Motorola's CDMA cellular base station products.
He spent five years Salesforce where he was on the Security Detection Engineering team doing
security log aggregation and Data Engineering to augment and enhance the detection capabilities
of the Blue Team. Most recently he is at Palo Alto Networks where he works as a Consulting
Engineer. He is also the lead organizer for the BSides Indy security conference in Indianapolis,
Indiana. His education includes a Bachelor of Science in Computer Science from Roosevelt University, 
a Master of Science degree in Computer Information Systems from Northwestern University, and a
Master of Science degree in Network Security & Network Engineering from DePaul University.

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
Python and it's dependencies to an instance of Docker. For this reason,
we will move to discussing containerization using Docker in the chapter 
following this one.

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

|

.. image:: ../images/setup-vscode.png
   :align: center

|

********************
The Flow (Pipelines)
********************

Work products, such as code and documents for example, begin their life on developer workstations. We
will refer to this as the "local"
environment. These work products are created, reviewed and checked into revision control systems (GitHub
for example) by the DevSecOps practitioner. Test cases are created and run against the work at check-in time, to ensure 
stability, security, and compatibility with the exsiting code base. The automation required to to execute
tests every time work is checked in is also the responsibility of the DevSecOps engineers. As seen in :numref:`myFig1` 
work typically "flows" from the local environments, into a test environment, and finally to production. We 
will refer to the entirety of this flow as a "pipeline". Code from one or more local environments is checked 
in to revision control throughout a typical workday, and continuously tested and integrated with the 
main code base. That is to say, work undergoes "Continuous Inetegration" (CI) with the main code base,
and often "Continuous Delivery" (CD) between local, test, and production environments. This is where the 
term "CI/CD Pipeline" comes from.

|

.. figure:: ../images/flow.png
   :align: center
   :name: myFig1
   :alt: A typical build pipeline
   :figclass: align-center

   Typical build pipeline.

|

While the CI/CD Pipeline is often the primary focus of the DevSecOps engineer, other pipelines exist as 
well. For example, Data Engineers build and maintain Data Science pipelines for to get information into a data lake, 
or for Data Scientists to be able to create machine learning models from.

*************
Lab Exercises
*************

This book features a final chapter to guide the reader through applying the information
introduced between this one and that. You are encouraged to jump ahead, go back and re-read, 
do the parts you think you can use right away and skip that parts you don;t think you will
ever use. Learning can be a non-linear experience and you are encouraged to "color outside
the lines" to the extent you feel comfortable doing so. 
