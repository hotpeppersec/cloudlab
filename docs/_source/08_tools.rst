.. include:: global.rst

=====
Tools
=====

.. image:: /project/image/railway-4101305_1920.jpg
   :align: center

|

We can reduce our Mean Time To Deploy (MTTD) [#]_ by using tools to prepare and
generate our machine images programatically, and with scripting languages
such as HCL, which Terraform [#]_ is based on. In this section we examine these
tools in greater depth.

.. index::
   single: MTTD
   single: Terraform

.. figure:: /project/image/infra_flow.png
   :align: center
   :name: myFig4
   :alt: alternate text
   :figclass: align-center

   The pipeline flow.

|

Consider the following diagram :numref:`myFig4` as we discuss the tools we'll use to
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
   :caption: A JSON file for Packer in AWS
   :name: A JSON file for Packer in AWS
   :linenos:

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
         "Project": "DevSecOps",
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
            "cp /home/secdevops/rapid_secdev_framework/packer/authorized_keys /home/secdevops/.ssh",
            "chown -R ubuntu /home/ubuntu",
            "cp /home/ubuntu/rapid_secdev_framework/packer/ctfd.service /etc/systemd/system"
      ]}
   ]
   }

Packer Example Configuration for GCP
====================================

Here is an example of how to set up a JSON file to build a Packer image in
Google Compute. Save the contents of this file into `packer/gcp-debian-host.json`:

.. code-block:: bash
   :caption: A JSON file to build Packer image in Google Compute
   :name: A JSON file to build Packer image in Google Compute
   :linenos:

   {
      "builders": [
         {
            "type": "googlecompute",
            "account_file": "/home/secdevops/.config/gcloud/my-gcloud-creds-file.json",
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
            "mkdir -p /home/secdevops/.ssh",
            "chmod 700 /home/secdevops/.ssh"
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
to create the image. You shoudl see output similar to the following, but with a unique
AMI ID.

.. code-block:: bash
   :caption: Building a Packer image
   :name: Building a Packer image
   :linenos:

   Build 'amazon-ebs' finished.

   ==> Builds finished. The artifacts of successful builds are:
   --> amazon-ebs: AMIs were created:
   us-west-2: ami-0e9e6427509a9d0b5

The AMI ID "ami-0e9e6427509a9d0b5" is now a usable image that we can include in our
Terraform builds.

Removing Packer Images from Cloud Provider
==========================================

You may want to remove the images from AWS/GCP since storing them incurs additional cost, whether
they are in use or not [#]_ .

.. [#] https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Images:sort=name

To remove stale machine images from AWS, you may try a tool such as aws-amicleaner [#]_ , which is
available to be installed via Python/pip as well as from the GitHub repository for the project.

.. [#] https://github.com/bonclay7/aws-amicleaner


Another AWS specfic tool is "lambda-packerjanitor" [#]_ from Trusworks.

.. [#] https://registry.terraform.io/modules/trussworks/lambda-packerjanitor/aws/1.0.0

*********
Terraform
*********

Terraform, created by Hashicorp in 2014, is a tool for building, changing, and versioning
infrastructure safely and efficiently [#]_ . Install the latest version of Terraform in preparation
for the activities that follow.

.. [#] https://www.terraform.io/intro/index.html

.. index::
   single: Terraform

Consider the relevant Terraform files that we will include in our projects.

.. graphviz::
   :caption: Key Terraform Files
   :align: center

   digraph folders {
      "aws" [shape=folder];
      "main.tf" [shape=rect];
      "output.tf" [shape=rect];
      "terraform.tfvars" [shape=rect];
      "variables.tf" [shape=rect];
      "aws" -> "main.tf";
      "aws" -> "output.tf";
      "aws" -> "terraform.tfvars";
      "aws" -> "variables.tf";
   }



terraform.tfvars
================

When working with AWS as cloud provider, life gets a bit easier if you save a copy of your
console credentials in a file called `terraform.tfvars` as seen in the next example. You must
be very careful not to commit these credentials to GitHub! Adding the line `terraform.tfvars`
to your `.gitignore` file at the top level of your lab repository helps a lot. Keeping track of
your credentials is very important!

.. index::
   single: terraform.tfvars

An example of a local terraform.tfvars file follows. Remember that this file will never be
checked into GitHub or any other revision control toolset.

.. code-block:: bash
   :caption: An example terraform.tfvars file
   :name: An example terraform.tfvars file

   aws_access_key = AKIAJCQ6WHUXVOKZ8RQQ
   aws_secret_key = q27qR8fwdHLUh7WOEH3JVd2VHjfRlQs1jlhhbZbQ

main.tf
=======

This file will contain the bulk of our Terraform configurations. As with Python, we have the ability to
reference modules, both internal and exteral. The main.tf file is the place the module references are made.

.. code-block:: bash
   :caption: Example of how to reference an external module
   :name: Example of how to reference an external module
   :linenos:

   module "security_group" {
      source  = "terraform-aws-modules/security-group/aws"
      version = "~> 3.0"

      name        = "DevSecOps"
      description = "Security group for the cloud lab"
      vpc_id      = data.aws_vpc.default.id

      ingress_cidr_blocks = ["0.0.0.0/0"]
      ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
      egress_rules        = ["all-all"]
   }


We can also designate our data sources in the main.tf file. Consider the following Terraform data sources.
These AWS data sources reference our Virtual Private Cloud (VPC) and provider-assigned IPv4 Subnets.

.. code-block:: bash
   :caption: Designation of data sources in main.tf
   :name: Designation of data sources in main.tf
   :linenos:

   data "aws_vpc" "default" {
   default = true
   }

   data "aws_subnet_ids" "all" {
   vpc_id = data.aws_vpc.default.id
   }


.. index::
   single: main.tf

outputs.tf
==========

We can display or export the resources we've created in `main.tf` using a file known as
`outputs.tf`. We may have a need to display the IP address of host instances we've just
created, which is helpful to a user who needs to log in. We may also wish to make values
available to other Terraform modules.

Consider the following output declarations from our example code.

.. code-block:: bash
   :caption: Displaying resources from our main.tf file
   :name: Displaying resources from our main.tf file
   :linenos:

   output "web_public_ip" {
      description = "Public IPs assigned to the web instance"
      value       = aws_instance.web.public_ip
   }

   output "kali_public_ip" {
      description = "Public IPs assigned to the kali instance"
      value       = aws_instance.kali.public_ip
   }

.. index::
   single: outputs.tf

variables.tf
============

The `variables.tf` file is another common file seen in projects in AWS, GCP and other cloud providers.
It contains declarations of variables, and often values for variables as well, that will be used in
the `main.tf` file. As an example there might be region information or even the name of the image we
created previously with Packer.

.. index::
   single: variables.tf

Consider the following example. Here we declare a "region" variable in the file variables.tf.

.. code-block:: bash
   :caption: Declaring a region in variables.tf
   :name: Declaring a region in variables.tf

   variable "region" {
      description = "AWS region to launch servers."
      default     = "us-west-2"
   }

Verification
============

Terraform has some commands, `validate` and `fmt` (short for "format") that we can use to syntactically
verify our configuration before sending it off to the cloud provider to act upon. Validating
your Terraform files is as easy as  typing `terraform validate` in the directory the files exist in.

.. code-block:: bash
   :caption: Validating Terraform files
   :name: Validating Terraform files

   user@devsecops::~/workspace/rapid_secdev_framework/aws$ terraform validate
   Success! The configuration is valid.

To get your Terrform files into a clean standard format, the `terraform fmt` command works well. There
is also the option to do this formatting from inside the VSCode window on a per-file basis.

Plan
====

First we will will create a "plan" in preparation for application.

.. code-block:: bash
   :caption: Creating a plan file with Terraform
   :name: Creating a plan file with Terraform
   :linenos:

   user@devsecops::~/workspace/rapid_secdev_framework/aws$ terraform plan -out franklin.out
   Refreshing Terraform state in-memory prior to plan...
   The refreshed state will be used to calculate this plan, but will not be
   persisted to local or remote state storage.

   data.aws_vpc.default: Refreshing state...
   data.aws_subnet_ids.all: Refreshing state...

   ------------------------------------------------------------------------

   An execution plan has been generated and is shown below.
   Resource actions are indicated with the following symbols:
   + create


   Plan: 8 to add, 0 to change, 0 to destroy.

   ------------------------------------------------------------------------

   This plan was saved to: franklin.out

   To perform exactly these actions, run the following command to apply:
      terraform apply "franklin.out"

Apply
=====

The `apply` action is where the rubber meets the proverbial road. This action will transmit our
configurations to the cloud provider and allocate the necessary resources to stand up our environment.

With our plan in place, we can now "apply" that plan to the cloud provider. This can take a counsiderable
amount of time, depending on the complexity of the desired configuration. Note that Terraform will
prompt you to enter "yes" before it will proceed.

.. code-block:: bash
   :caption: Applying a Terraform plan from file
   :name: Applying a Terraform plan from file
   :linenos:

   user@devsecops::~/workspace/rapid_secdev_framework/aws$ terraform apply
   data.aws_vpc.default: Refreshing state...
   data.aws_subnet_ids.all: Refreshing state...

   An execution plan has been generated and is shown below.
   Resource actions are indicated with the following symbols:
      + create

   Plan: 8 to add, 0 to change, 0 to destroy.

   Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.

      Enter a value: yes

   Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

   Outputs:

   kali_public_ip = 34.221.121.11
   web_public_ip = 54.186.129.232

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

There is a test framework known as "molecule" that can be used to test ansible playbooks.

.. index::
   single: Molecule

.. code-block:: bash
   :caption: Testing Ansible with Molecule
   :name: Testing Ansible with Molecule
   :linenos:

   $ molecule init role -r logfwd
   --> Initializing new role logfwd...
   Initialized role in /ansible/roles/logfwd successfully.

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
   :caption: Unencrypted data
   :name: Unencrypted data

   My dog has fleas.

Now we can encrypt some data using this file as the encryption key. For the sake of example, let's
assume we have a file called `data_to_protect.txt` that we would like to encrypt.

.. code-block:: bash
   :caption: Encrypting date file with another file as the key
   :name: Encrypting date file with another file as the key

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
   :caption: Decrypting our data file
   :name: Decrypting our data file

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
      "devsecops" [shape=folder];
      "ansible" [shape=folder];
      "aws" [shape=folder];
      "packer" [shape=folder];
      "aws-debian-host.json" [shape=rect];
      "gcp-debian-host.json" [shape=rect];
      "main.tf" [shape=rect];
      "outputs.tf" [shape=rect];
      "terraform.tfvars" [shape=rect];
      "variables.tf" [shape=rect];
      "devsecops" -> "ansible";
      "devsecops" -> "aws";
      "devsecops" -> "packer";
      "aws" -> "main.tf";
      "aws" -> "outputs.tf";
      "aws" -> "terraform.tfvars";
      "aws" -> "variables.tf";
      "packer" -> "aws-debian-host.json";
      "packer" -> "gcp-debian-host.json";

   }
