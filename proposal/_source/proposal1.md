# blank section header

Over the past five or so years I've been doing security development work, previously at SalesForce and now at Palo Alto Networks. I've developed a 
pattern of working that allows me to rapidly prototype ideas and get them through the CI/CD pipeline and into production. 

This book is me capturing that way of working as a teachable framework for experimentation and giving folks a way
to affordably access some of the latest and greatest technologies available today. The information it contains
is suitable for folks new to the Information Security, Information Technology, and Software industries, as well as seasoned professionals looking to expand 
their skillsets. I like to think of this framework as a path that folks can follow to get into the world of software 
development and operations, more commonly known as "DevOps".

This book introduces "DevOps" technologies in a specific order, with the goal of instilling/improving the technical skills of the reader. 
We explore just enough of those technologies to take an example project from 
local development environment, through our build/test/integration pipeline, and finally to our lab environment hosted on a cloud 
provider such as Amazon Web Services (AWS). While it is possible to show the example project working in multiple cloud service providers, I am now
leaning towards focusing on one, AWS, to reduce the complexity. 

The first concept explored in this book is the idea of containerization. More specifically, how to enact 
containerization using Docker and docker-compose. This allows for an ephemeral, immutable environment that we 
can build and test ideas. In other words, our environments are intentionally short-lived, and are meant to 
be destroyed and rebuilt, instead of upgraded as is typically done with traditional hosts.

Next we touch on revision control as an idea. In particular, we'll use GitHub. We touch on the key steps in setting up a 
GitHub account, and properly configuring it. This is 
in preparation for working with our follow-along example project.

We then explore Python 3.x as the workhorse language for building out ideas 
in our projects. Readers are introduced to Pythons large library of modules and shown
how to include these in their projects. We could easily include the same pattern
 in this section, but use the Ruby language instead. It has been left out to reduce the complexity.

Now we're ready to look at Makefiles as a way to start to tie these technologies together. Makefiles give us a way to 
programatically build and control the preceeding technologies. We will show how a Makefile can be used with Docker and Python as 
Makefile targets. As we move forward we will continue to add more targets to our
Makefile. This also simplifies the work we want to do in the build & test portions of
our deployment pipeline.

The Continuous Integration/Continuous Deployment (CI/CD) chapter is where we begin to talk about the pipelines 
that our work traverses, starting in our local containers, funneling changes to our "cloud" setup in AWS. Here we 
discuss some patterns we can use to run our local containers in a remote test environment. 

The Infrastructure chapter introduces the concept of the cloud provider. We explore the 
credentials and steps needed to securely interact with AWS through the command line in preparation
for some automation tools. 

Once we have the proper accounts and credentials in place, we can look at popular 
tools for programatically building server images and provisioning our cloud setups
in AWS. Understanding how to generate machine images with Packer, encrypt our data
with Vault, and maintain and provision our infrastructure as code with Terraform
are all key concepts here. Think of this section as building the house we plan to live
in, if only for a relatively short time.

The Ansible section will be about how, after the platform is created using Terraform, 
we can configure the hosts we've programatically created to meet our needs with specific software packages, provisioning 
of service users, etc. This might be thought of as furnishing and decorating the house we've just built.

Finally we arrive at the full test lab section, where we can discuss the cloud 
environment in GCP/AWS in it's entirety. We consider larger building blocks of the cloud
environment, various components such as firewalls and specific types of servers. 

## About the Author

Franklin Diaz is a former systems & software engineer, spending 14 years testing and developing 
Motorola's CDMA cellular base station products. He spent five years Salesforce where he was on the 
Security Detection Engineering team doing security log
aggregation and data engineering to augment and enhance the detection capabilities
of the blue team. Most recently he is at Palo Alto Networks where he works as a Consulting Engineer. 

He is also the lead organizer for the BSides Indy security conference in Indianapolis, Indiana.

Mr. Diaz has a Bachelor of Science in Computer Science from Roosevelt University, 
a Master of Science degree in Computer Information Systems from 
Northwestern University, and a Master of Science degree in Network Security & 
Network Engineering from DePaul University.

### Contact Information

```
Franklin Diaz
franklin@bitsmasher.net
(773) 960-5400
```

## Proposed Table of Contents

Here are the most recent chapter titles and count of pages written so far.
