.. include:: global.rst

=======
Ansible
=======

.. image:: ../images/railway-4101305_1920.jpg
   :align: center

Environments where you have a set of repeatable configuration
steps can be deployed more quickly with Ansible. Building a set of
good Ansible playbooks over team means you can pick and choose 
the most useful patterns in future projects. A true force multiplier.

.. index::
   single: Ansible

**********
Installing
**********

We can extend our existing lab framework by simply adding "ansible" to
`python/requirements.txt`. Now when we type `make docker`, pip will take
care of the installation for us. Then we can experiment with Ansible 
playbook runs inside our Docker container.

*********
Playbooks
*********

Ansible breaks down it's execution runs into discrete workflows known as 
playbooks. Playbooks are executed on the target hosts to implement 
configurations. It's quite useful to be able to kick off a playbook run
on the taget host every 15 minutes. This is a direct example of Continuous 
Deployment in action. If somethings changes in the GitHub repository, we 
want that to propagate out to the targets and the latest configuration to 
be applied to the server. We can also deploy a newer version of an 
application and then stop and start the applicationto effect the change.

Ansible playbooks break down target hosts into groupings known as roles. 

*******
Testing
*******

There is a test framework known as "molecule" that can be used to 
test ansible playbooks in the CI/CD pipeline.

*******************
Directory Structure
*******************
