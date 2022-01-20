# Collaboration / Workflow Exercises

Git and Github are powerful tools that can be used in different ways depending on the preferences of the team. The steps here will demonstrate two approaches.

- [ ] Single repo, multiple contributors (good for small teams)
- [ ] Fork and pull request workflow (Github flow, good for open source)


## Small Team Workflow

For this workflow, you use a single repo on Github and have multiple contributors with write permissions. This can be done with either a private or public repo, and  

1. Make a repo (on Github)
2. Add your neighbor as a contributor (on Github)
3. Both of you follow the pull-edit-commit-push workflow
4. Occassionally you will get a merge conflict!

TODO: add detailed steps to add neighbor as contributor and try this out.

### Make a new repository on Github, and clone it
Follow the instructions from [the previous section](02-practice.md) or just use the test repo you already created.

### Steps adding neighbor as contributor

1. Log into your GitHub account, to the repository you want to share
2. Go to "Settings", then "Collaborators" and add based on Github usernames

![](img/git_hub_collab/new_contrib.png)

3. Your collaborator will need to "accept" the invitation to collaborate. Depending on notification settings, they may see the invitation in their email, or in their Github home screen.

From here, you both should follow the pull-edit-commit-push cycle. At what point can your collaborator see the changes that you are making? What happens if your collaborator pushed changes since you last pulled? What happens if you both edit the same file simultaneously?

Here's a [guide on resolving merge conflicts from Github](https://help.github.com/en/articles/resolving-a-merge-conflict-using-the-command-line)






## Fork and Pull Request

When you are working on an open source project, you may receive contributions from people outside of your organization who you have never met or spoken to offline. They don't have edit permissions on your repo, so how do they contribute improvements to your code?

Outside collaborator takes following steps:

1. Forks a copy of the repo to their own account
2. Clones the fork to their local machine
3. Make a new branch with proposed edits
4. Push edits/new branch back to their Github account
5. Open a pull request to the original upstream repository

Then the original repository owner:

6. Inspects the proposed changes
7. Merges the proposed changes into the main repo (or request changes, or discuss, or reject the request)

Try forking the repo of materials for this workshop. If you are signed into Github, then there should be a "fork" icon in the upper right corner.

![](img/git_hub_collab/fork.png)

This will give you a whole new copy of the repo on **your** Github account.

From here, you make changes to your copied version, and then send a "pull request" to the maintainers of the main version of the repo, saying essentially, "Hey, I made some improvements to your code, I think you might want to incorporate them into your version."

Here's a guide from Github on [Forking a repo](https://help.github.com/en/articles/fork-a-repo)

And another on [creating a pull request from a fork](https://help.github.com/en/articles/creating-a-pull-request-from-a-fork)

___
[Return to Section 2 - Practice: pull, edit, commit, push (and repeat)](02-practice.md)
[Proceed to Section 4 - Exporing repo history](04-history.md)
