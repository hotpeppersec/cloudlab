.. include:: global.rst

****************
Podman & Buildah
****************

There is a more secure alternative [#]_ to Docker for creating containers.
You can install Podman by following the instructions [#]_ at their web site.

.. [#] https://opensource.com/article/18/10/podman-more-secure-way-run-containers
.. [#] https://podman.io/getting-started/installation.html

Here is the change for the `unprivileged_userns_clone` error:

.. code-block:: bash

   thedevilsvoice@grimoire::~$ podman
   cannot clone: Operation not permitted
   user namespaces are not enabled in /proc/sys/kernel/unprivileged_userns_clone
   Error: could not get runtime: cannot re-exec process
   thedevilsvoice@grimoire::~$ sudo sysctl kernel.unprivileged_userns_clone=1
   thedevilsvoice@grimoire::~$ podman-v
   podman version 1.9.1

Once podman is installed properly you should be able to `alias docker=podman`
and use it as a drop in replacement for docker.