### Branching and Merging (Lab 5b)

Let's use our changes to the CODEOWNERS file to try making a change in our clone of the repository in GitHub,
then pushing that change up to the repository.

* Create a new branch, for example git checkout -b newbranch
* Create the .github directory if it does not exist, then the CODEOWNERS file in that directory.
* Use git to add the file to the commit: git add CODEOWNERS
* Commit the file with git, git commit -S -m `add CODEOWNERS file'
* Push this commit to github.com, git push origin newbranch
* Use the github.com website to open and merge the pull request.
