=============
Book Proposal
=============

***************
Summary of Book
***************

Over the past five or so years I've been doing security development work, 
previously at SalesForce and now at Palo Alto Networks. 
I've developed a pattern of working that allows me to rapidly prototype 
ideas and get them through the CI/CD pipeline and into production. 

This book is me capturing that way of working as a teachable framework 
for experimentation and giving folks a way to affordably access some of the
latest and greatest technologies available today. The information it contains
is suitable for folks new to the information security, information technology, 
and software industries, as well as season professionals looking to expand 
their skillsets.

We introduce technologies in a specific order and use just enough of those technologies to take a project from local development environment, to our build pipeline, and finally to our lab environment hosted on a cloud provider such as 
GCP or AWS.

The first thing we cover is the idea of containerization, specifically implemented using Docker and docker-compose. This allows for an ephemeral, immutable environment that we can build and test ideas. 

Next we touch on revision control as an idea, and GitHub in particular. We go touch on the key steps in setting up a GitHub 
account, and properly configuring it.

We look at setting up Python as the workhorse language for building out ideas in our project.

The Makefile section gives us a way to control the preceeding technologies and starts to tie things together. That is to say, we now have Docker and Python as Makefile targets. As we move forward we will continue to add more targets to our
Makefie.

The CI/CD section is where we talk about the pipelines that deliver our work from our local containers and funnel changes to our "cloud" setup. Here we discuss some patterns we can use to run our local containers in a remote test environment. 

Infrastructure section introduces the cloud provider and how to configure your local machine to interact properly with two of the most popular, GCP & AWS. 

Once we have the proper credentials in place, we can look at poular tools for programatically building server images and provisioning our cloud setups.

The Ansible section will be about how, after the platform is created, we can configure the hosts to meet our needs with specific packages, users, etc.

Finally we arrive at the full test lab section, where we can discuss the cloud environment in GCP/AWS in it's entirety.

*******
Outline
******* 
    
*Provide a detailed outline listing at least chapter titles and first level headings.*

I've created a github repo with Python & Sphinx that generates LaTeX and PDF
formats of a draft book. 

first page: `contents one`_ 

.. _`contents one`: https://i.imgur.com/eXo6sOx.png

second page: `contents two`_

.. _`contents two`: https://i.imgur.com/WRejKOW.png

Follow Along Code Examples
==========================

There are also code examples in a second (already public) repository
for folks to follow along and see/try examples:

`https://github.com/hotpeppersec/rapid_secdev_framework`

Writing Sample
==============

The fist chapter as a writing sample.

page one_

.. _one: https://i.imgur.com/IMTvehI.png

page two_

.. _two: https://i.imgur.com/tahiV0p.png

page three_

.. _three: https://i.imgur.com/zB0pUeA.png
********    
Audience
********

*Who is your target audience and how will your book meet their needs?*

I've written this with folks from the security community in mind. I hear people say a lot that they are curious about geting started with SecDevOps concepts such as coding and understanding cloud technologies. I think this writing will provide a good "quickstart" path to accomplish exactly that. 

***********    
Competition
***********

*List any competing titles. How will your work compete?*

I realize there are many titles out there that deep dive on the subjects
that I cover in this book, offering a depth of knowledge in an area. 
This book would instead take a breadth of knowledge approach. 

******    
Market 
******

*Discuss the market for your book.*

This book could be described as a pathway to starting out in (Sec)DevOps.

My assumption is this would be a good book for folks new to the industry to follow along with. By this I don't just mean young or school-aged folks.
I see that there is also a need for folks who have been in the workforce 
for some years (or even decades!) to re-tool and adapt to rapidly changing technological landscape. 

***    
You 
***

*Who are you?*

Tech nerd, into computers since my Vic-20 days. I like spicy food 
and growing hot pepper plants, listening to music, family and dogs. 

https://www.linkedin.com/in/franklin-diaz/

https://youtu.be/XX0KX-4Q7es

https://youtu.be/pacUKJybyEI

https://gist.github.com/thedevilsvoice/1fed891832a79894184495f942b95017

*What are your goals in writing this book?*

Ideas and personal best practices aren't much use if you can't capture
and share them. My hope is that this information will be useful and helpful
to people I will most likely be interacting with and working with in 
the future.