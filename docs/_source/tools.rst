.. include:: global.rst

=====
Tools
=====

.. image:: ../images/railway-4101305_1920.jpg
   :align: center

We can reduce our mean time to deploy by using tools to prepare and
generate our machine images programatically, and with scripting languages
such as HCL, which Terraform is based on. In this section we examine these
tools in greater depth.

.. index::
   single: Terraform

.. figure:: ../images/infra_flow.png
   :align: center
   :name: myFig1
   :alt: alternate text
   :figclass: align-center

   The pipeline flow.

Consider the following diagram :numref:`myFig1` as we discuss the tools we'll use to 
implement our infrastructure as coode and associated configurations in 
the cloud provider network.

******
Packer
******

Using Hashicorp Packer is a great way to nail down the contents of a machine
image before we bring up an instance. Download Packer from the Hashicorp web
site in preparation for the follwing steps [#]_ . We will focus on creating images
for our cloud provider from the command line. Bear in mind it is also possible to
use Terraform to manage the creation of Packer generated machine images. Generating 
machine images on the fly using Terraform would increase our degree of ephepmerality
and immutability.

.. [#] https://www.packer.io/downloads/

.. index::
   single: Packer

Packer Example Configuration for AWS
====================================

Here is an example of how to set up a JSON file to build a Packer image in 
AWS. Save the contents of this file into `packer/aws-debian-host.json`:

.. code-block:: bash

   {
   "variables": {
      "aws_access_key": "",
      "aws_secret_key": ""
   },
   "builders": [
      {
         "type": "amazon-ebs",
         "access_key": "{{user `aws_access_key`}}",
         "secret_key": "{{user `aws_secret_key`}}",
         "region": "us-west-2",
         "source_ami_filter": {
         "filters": {
            "virtualization-type": "hvm",
            "name": "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*",
            "root-device-type": "ebs"
         },
         "owners": [
            "099720109477"
         ],
         "most_recent": true
         },
         "instance_type": "t2.micro",
         "ssh_username": "ubuntu",
         "ami_name": "generic-lab-host {{timestamp}}",
         "tags": {
         "Name": "Packer-Ansible",
         "Project": "SecDevOps CloudLab",
         "Commit": "unknown"
         }
      }
   ],
   "provisioners": [
      {
         "type": "shell",
         "execute_command": "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'",
         "inline": [
            "mkdir -p /home/secdevops/.ssh",
            "chmod 700 /home/secdevops/.ssh",
            "cd /home/secdevops && git clone https://github.com/wwce/ctf_scoreboard.git",
            "cp /home/secdevops/cloudlab/packer/authorized_keys /home/secdevops/.ssh",
            "chown -R ubuntu /home/ubuntu",
            "cp /home/ubuntu/ctf_scoreboard/packer/ctfd.service /etc/systemd/system"
      ]}
   ]
   }

Packer Example Configuration for GCP
====================================

Here is an example of how to set up a JSON file to build a Packer image in 
Google Compute. Save the contents of this file into `packer/gcp-debian-host.json`:

.. code-block:: bash

   {
      "builders": [
         {
            "type": "googlecompute",
            "account_file": "/home/franklin/.config/gcloud/my-gcloud-creds-file.json",
            "project_id": "sec-dev-ops-000378",
            "source_image_family": "debian-10",
            "zone": "us-central1-a",
            "image_description": "SecDevOps Debian Host",
            "image_name": "generic-lab-host",
            "ssh_username": "root",
            "metadata": { "enable-oslogin": "false" }
         }
      ],
      "provisioners": [
         {
            "type": "shell",
            "inline": [
            "sleep 10",
            "mkdir -p /home/franklin/.ssh",
            "chmod 700 /home/franklin/.ssh"
            ]
         }
      ]
   }

Validating Packer JSON Files
============================

Once the JSON files are created and saved in the packer directory, 
we can use the `packer` tool to validate them. Type 
`packer validate <filename>` to validate each new JSON file. This gives you a
chance to find and fix any errors before the next step, the build phase.

Note that your validation commands may fail if the cloud provider credentials have not been
configured at this point.

Building Images with Packer
===========================

Finally, we are ready to build our new images. Try typing `packer build <filename>`
to create the images in AWS or GCP.

Removing Packer Images from Cloud Provider
==========================================

You may want to remove the images from AWS/GCP since storing them incurs additional cost, whether
they are in use or not [#]_ . 

.. [#] https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Images:sort=name

To remove stale machine images from AWS, you may try a tool such as aws-amicleaner [#]_ , which is 
available to be installed via Python/pip as well as from the GitHub repository for the project.

.. [#] https://github.com/bonclay7/aws-amicleaner

*********
Terraform
*********

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently 
[#]_ . Install the latest version of Terraform from Hashicorp in preparation for the activities 
that follow.

.. [#] https://www.terraform.io/intro/index.html

.. index::
   single: Terraform

terraform.tfvars
================

When working with AWS as cloud provider, life gets a bit easier if you save a copy of your
console credentials in a file called `terraform.tfvars` as seen in the next example. You must
be very careful not to commit these credentials to GitHub! Adding the line `terraform.tfvars`
to your `.gitignore` file at the top level of your lab repository helps a lot. Keeping track of 
your credentials is very important!

.. index::
   single: terraform.tfvars

.. code:: shell

   aws_access_key = AKIAJCQ6WHUXVOKZ8RQQ
   aws_secret_key = q27qR8fwdHLUh7WOEH3JVd2VHjfRlQs1jlhhbZbQ

variables.tf
============

The `variables.tf` file is another common file seen in projects in AWS, GCP and other cloud providers.
It contains declarations of variables, and often values for variables as well. As an example there 
might be region information or even the name of the image we created previously with Packer.

.. index::
   single: variables.tf

main.tf
=======

.. index::
   single: main.tf

Verification
============

Terraform has some commands (validate & plan) that we can use to verify our configuration before 
sending it off to the cloud provider to act upon.

Apply
=====

*******
Ansible
*******

Environments where you have a set of repeatable configuration steps can be deployed more quickly 
with Ansible. Building a set of good Ansible playbooks over team means you can pick and choose 
the most useful patterns in future projects. A true force multiplier.

.. index::
   single: Ansible

Installing Ansible
==================

Simply adding "ansible" to `python/requirements.txt` will make Ansible available in our Docker 
containers. Now when we type `make docker`, pip will take care of the installation for us. Then we can 
experiment with Ansible playbook runs.

Ansible Playbooks
=================

Ansible breaks down it's execution runs into discrete workflows known as playbooks. Playbooks are 
executed on the target hosts to implement configurations. It's quite useful to be able to kick off a 
playbook run on the taget host every 15 minutes. This is a direct example of Continuous Deployment in 
action. If somethings changes in the GitHub repository, we want that to propagate out to the targets 
and the latest configuration to be applied to the server. We can also deploy a newer version of an 
application and then stop and start the applicationto effect the change.

Ansible playbooks break down target hosts into groupings known as roles.

Testing Ansible Playbooks
=========================

There is a test framework known as "molecule" that can be used to 
test ansible playbooks in the CI/CD pipeline.

*************
Ansible Vault
*************

Vault is a tool that is included with Ansible. You may notice that `ansible-vault`
is a symlink back to `ansible` on your system. Vault is an easy way to protect 
secrets using AES-256 encryption in your GitHub repositories. For example, we can use it to secure data at 
rest in a repository, or protect system configuration data as it transits through
our pipelines out to our cloud providers.

.. index::
   single: AES-256
   single: Vault

Encrypting a File with Vault  
============================

.. index::
   single: encryption

Let's try encrypting a file... using another file! Create a text file with some random contents.
For example, create a file in your home directory called my_dog.txt with the following contents:

.. code-block:: bash

   My dog has fleas.

Now we can encrypt some data using this file as the encryption key. For the sake of example, let's
assume we have a file called `data_to_protect.txt` that we would like to encrypt.

.. code-block:: bash

   ansible-vault encrypt --vault-password-file ~/my_dog.txt data_to_protect.txt

Now when we view the `data_to_protect.txt` file, we can see it has been encrypted and appears
as a long series of seemingly nonsense characters.

Decrypting a File with Vault
============================

.. index::
   single: decryption

At some point, we are going to want to decrypt our data so it becomes usable, we can perform operations
on it, and so on. As long as we keep or recreate the original key file on our host, or create an 
identical copy of the key file some some target/remote host, we will be able to decrypt the data. This
is quite useful to us indeed, when it comes to protecting our data.

.. code-block:: bash

   ansible-vault decrypt --vault-password-file ~/my_dog.txt data_to_protect.txt

.. raw:: latex

    \clearpage

************************
Tool Directory Structure
************************

Files and folders relevant to this chapter are organized as shown
below.

.. graphviz::
   :caption: Updated Project Directory
   :align: center

   digraph folders {
      "cloudlab" [shape=folder];
      "packer" [shape=folder];
      "terraform" [shape=folder];
      "aws-debian-host.json" [shape=rect];
      "gcp-debian-host.json" [shape=rect];
      "main.tf" [shape=rect];
      "terraform.tfvars" [shape=rect];
      "variables.tf" [shape=rect];
      "cloudlab" -> "packer";
      "cloudlab" -> "terraform";
      "packer" -> "aws-debian-host.json";
      "packer" -> "gcp-debian-host.json";
      "terraform" -> "main.tf";
      "terraform" -> "terraform.tfvars";
      "terraform" -> "variables.tf";
   }
