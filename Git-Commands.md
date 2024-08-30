# Git Commands

## Configuration

### Global Configuration

Set user name globally
    
    git config --global user.name "Your Name"

 Set user email globally

    git config --global user.email "your_email@example.com"

List all global configurations

    git config --global --list

### Local (Repository) Configuration

Set user name for a repository
    
    git config --global user.name "Your Name"

 Set user email for a repository

    git config --global user.email "your_email@example.com"

List all configurations for a repository

    git config --local --list

### List all configurations

    git config --list

## Creating Repositories

Initialize a new Git repository

    git init

Clone an existing repository

    git clone <url>

## Making Changes

Add a file to the staging area

    git add <file>

Add all files to the staging area

    git add .

Commits staged changes with a message

    git commit -m "Commit message"
    
Push changes to remote repository

    git push origin <branch-name>

Pull changes from remote repository

    git pull

Check the status of your working directory

    git status

## Working with Branches

Create a new branch

    git branch <branch-name>

Switch to a branch (choose one of the following)

Using `git checkout`:

    git checkout <branch-name> 

Or using `git switch`:

    git switch <branch-name>

Create a new branch and switch to it (choose one of the following)

Using `git checkout`:

    git checkout -b <branch-name>

Or using `git switch`:

    git switch -c <branch-name>

List all branches

    git branch

List all remote branches

    git branch -r

Delete a branch locally

    git branch -d <branch-name>

Delete a branch remotely

    git push origin --delete <branch-name>

Merge a branch into the current branch

    git merge <branch-name>

Rebase the current branch onto another branch

    git rebase <branch-name>

## Remote Repositories

Add a remote repository

    git remote add <remote> <repository-url>

View remote URLs

    git remote -v

Remove a remote

    git remote remove <remote>

Rename a remote

    git remote rename <old-name> <new-name>

Fetch changes from a remote

    git fetch <remote>

Show changes between the local and remote branches

    git fetch <remote> <branch>

Push changes to a remote branch

    git push <remote> <branch>

Pull changes from a remote branch

    git pull <remote> <branch>

## Viewing History

Show the commit history

    git log

Show changes between commits, commit and working directory, etc.

    git diff

Show changes staged for the next commit

    git diff --cached

Show changes between staged changes and the last commit

    git diff --staged

Show changes between the working directory and the index

    git diff HEAD

Shows detailed view of commit history

    git log --oneline --graph --decorate --all

## Undoing Changes

Unstages the specified file, keeping changes in the working directory

    git reset <file>

Restore a file to the latest commit

    git checkout -- <file>

Reset working directory to the last commit

    git reset --hard HEAD

Reset working directory to the specified commit, discarding all changes

    git reset --hard <commit>

Revert a commit by creating a new commit

    git revert <commit>

## Stashing

List all stashes

    git stash list

Save changes in a stash

    git stash

Save changes with a custom message
    
    git stash push -m "message"

Save changes, including untracked files, with a custom message

    git stash push -u -m "message"

Apply the most recent stash

    git stash apply

Apply a specific stash

    git stash apply stash@{n}

Apply and remove the most recent stash

    git stash pop

Pop a specific stash

    git stash pop stash@{n}

Drop a specific stash

    git stash drop stash@{n}

Clear all stashes

    git stash clear

## Merging

Merge specified branch into the current branch

    git merge <branch-name>

Resolve conflicts in the files

    git add resolved-file
    git commit

Abort a Merge
    
    git merge --abort

## Rebasing

Rebase current branch onto another branch

    git rebase <branch-name>

Continue rebase after resolving conflicts

    git add resolved-file
    git rebase --continue

Abort a Rebase

    git rebase --abort

## Tagging

Create a tag

    git tag <tag-name>

List all tags

    git tag

Show Tag Details

    git show <tagname>

Delete a Tag

    git tag -d <tagname>

Push a Tag to Remote

    git push origin <tagname>

Push All Tags to Remote
    
    git push --tags

Delete a Remote Tag

    git push origin --delete <tagname>

## Cherry-Picking

Apply a commit from another branch to current branch

    git cherry-pick <commit-hash>

If conflicts occur, resolve them in the files, then use:

    git add <resolved-file>
    git cherry-pick --continue

 Abort cherry-pick

    git cherry-pick --abort

## Help

Get help for a specific Git command
    
    git help <command>
