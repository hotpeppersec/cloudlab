## Forking and Cloning (Lab 5c) 

The process of performing a pull request (PR) and merging changes is covered fairly extensively on the Web.
Let's take a quick look at how to keep your local clone of a repository, as well as your clone on github.com, 
up to date.

These are the steps to take once your pull request is merged to the main
branch in the main project repository. From the command line on the
machine where your clone resides:

* git checkout master
* git fetch upstream
* git rebase upstream/master
* git push origin master

### Forking

From the original project page on github.com, click the ``fork'' button.
This creates a copy of the original repository on your personal GitHub page.

Now from your personal GitHub repository page, make a clone of that fork from github.com to your machine.

This will allow you to add, update and test code and documentation without altering the original project.
     
### Create a Remote

On your local machine, create a ``remote'' connection back to the original repo.

Use this example command:

    git remote add upstream git@github.com:devsecfranklin/devsecops-tactical-workbook.git

### Create a Pull Request (PR)

After completing these steps you can easily submit pull requests (PRs)
back to the original project.
