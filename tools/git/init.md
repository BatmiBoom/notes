# TOC

- [GIT](#git)
  - [PORRCELAIN AND PLUMBING](#porrcelain-and-plumbing)
  - [PORCELAIN](#porcelain)
    - [CONFIG](#config)
      - [GET](#get)
      - [UNSET](#unset)
      - [DUPLICATES](#duplicates)
      - [UNSET ALL](#unset-all)
      - [REMOVE A SECTION](#remove-a-section)
      - [LOCATIONS](#locations)
    - [STATUS](#status)
    - [STAGING](#staging)
    - [COMMIT](#commit)
    - [GIT LOG](#git-log)
      - [LOG FLAGS](#log-flags)
      - [GIT LOG REMOTE](#git-log-remote)
      - [COMMIT HASH](#commit-hash)
  - [PLUMBING](#plumbing)
    - [GIT FILES](#git-files)
    - [THE OBJECT FILE](#the-object-file)
    - [TREES AND BLOBS](#trees-and-blobs)
  - [STORING DATA](#storing-data)
    - [OPTIMIZATION](#optimization)
  - [BRANCHS](#branchs)
    - [HOW TO RENAME A BRANCH](#how-to-rename-a-branch)
    - [NEW BRANCH](#new-branch)
    - [SWITCHING BRANCHES](#switching-branches)
    - [DELETING BRANCH](#deleting-branch)
    - [DEFAULT BRANCH](#default-branch)
  - [MERGE](#merge)
    - [MERGE COMMITS](#merge-commits)
    - [MERGE LOG](#merge-log)
    - [FAST FORWARD MERGE](#fast-forward-merge)
    - [MERGE REMOTE](#merge-remote)
  - [REBASE](#rebase)
    - [WHEN TO REBASE](#when-to-rebase)
  - [UNDOING CHANGES](#undoing-changes)
    - [GIT RESET](#git-reset)
    - [RESET TO A SPECIFIC COMMIT](#reset-to-a-specific-commit)
  - [GIT REMOTE](#git-remote)
    - [ADDING A REMOTE](#adding-a-remote)
    - [FETCH](#fetch)
  - [GIT PUSH](#git-push)
    - [ALTERNATIVE OPTIONS](#alternative-options)
  - [GIT PULL](#git-pull)

# GIT

Git is the distributed version control system (VCS). Nearly every developer in the world uses it to manage their code. It has quite a monopoly on VCS. Developers use Git to:

- Keep a history of their code changes
- Revert mistakes made in their code
- Collaborate with other developers
- Make backups of their code
- And much more

## PORRCELAIN AND PLUMBING

In Git, commandas are divided into high-level ("porcelain") commands and low-level ("plumbing") commands. The porcelain commands are the ones that you will use most often as a developer to interact with your code.

Some porcelain commands are

- git status
- git add
- git commit
- git push
- git pull
- git log

Some plumbing commands are:

- git apply
- git commit-tree
- git hash-object

## PORCELAIN

### CONFIG

The very first step of any project is to create a repository. A Git "repository" (or "repo") represents a single project. You'll typically have one repository for each project you work on.

A repo is essentially just a directory that contains a project (other directories and files). The only difference is that also contains a hidden `.git` directory. That hidden directory is where Git stores all of its internal tracking and versioning information for the project

We need to configure Git to contain your information. Whenever code changes, Git tracks who made the change. To ensure you get proper credit for all the code you write, you need to set your name and email.

Git comes with a configuration both at the global and the repo (project) level. Most of the time, you'll just use the global config.

```console
git config --add --global user.name "github_username_here"
git config --add --global user.email "email@example.com"
```

Let's take the command apart:

- git config: The command to interact with your Git configuration.
- --add: Flag stating you want to add a configuration.
- --global: Flag stating you want this configuration to be stored globally in your ~/.gitconfig. The opposite is `local`, which stores the configuration in the current repository only.
- user: The section.
- name: The key within the section.
- "ThePrimeagen": The value you want to set for the key.

Finally, let's set a default branch. Run:

```console
git config --global init.defaultBranch master
```

Git has a command to view the contents of your config:

`git config --list --local`

or

```console
cat ~/.gitconfig
```

#### GET

We've used --list to see all the configuration values, but the --get flag is useful for getting a single value.

`git config --get <key>`

#### UNSET

The --unset flag is used to remove a configuration value. For example:

`git config --unset <key>`

#### DUPLICATES

Typically, in a key/value store, like a Python dictionary, you aren't allowed to have duplicate keys. Strangely enough, Git doesn't care.

#### UNSET ALL

The --unset-all flag is useful if you ever really want to purge all instances of a key from your configuration. Conversely, the --unset flag only works with a single instance of a key.

`git config --unset-all example.key`

#### REMOVE A SECTION

As I pointed out before, the webflyx section is nonsensical because Git doesn't use it for anything. While we can store any key/value pairs we want in our Git configuration, it doesn't mean we should.

The --remove-section flag is used to remove an entire section from your Git configuration. For example:

`git config --remove-section section`

#### LOCATIONS

There are several locations where Git can be configured. From more general to more specific, they are:

- system: /etc/gitconfig, a file that configures Git for all users on the system
- global: ~/.gitconfig, a file that configures Git for all projects of a user
- local: .git/config, a file that configures Git for a specific project
- worktree: .git/config.worktree, a file that configures Git for part of a project

### STATUS

A file can be in one of several states in a Git repository. Here are a few important ones:

- untracked: Not being tracked by Git
- staged: Marked for inclusion in the next commit
- committed: Saved to the repository's history

The git status command shows you the current state of your repo. It will tell you which files are untracked, staged, and committed.

### STAGING

Before making a commit we have to stage a file. A easy way to stage every file is to do

`git add .`

But that's often not what you want. To stage single files we can do

`git add <path-to-file | pattern>`

### COMMIT

After staging a file, we can commit it.

A commit is a snapshot of the repository at a given point in time. It's a way to save the state of the repository, and it's how Git keeps track of changes to the project. A commit comes with a message that describes the changes made in the commit.

Here's how to commit all of your staged files:

`git commit -m "your message here"`

If we screw up a commit message, you can change it with the `--amend` flag.

`git commit --amend -m "new message`

### GIT LOG

A Git repo is a (potentially very long) list of commits, where each commit represents the full state of the repository at a given point in time.

The git log command shows a history of the commits in a repository. This is what makes Git a version control system. You can see:

- Who made a commit
- When the commit was made
- What was changed

#### LOG FLAGS

- `--decorate=` It can be one of:
  - short (the default)
  - full (shows the full ref name)
  - no (no decoration)
- `--oneline`:
  - This flag will show you a more compact view of the log
- `--all`:
  - It shows all the commits for all the branches
- `--graph`:
  - Shows a nice ASCII art representation of your commit history
- `-- parents`:
  - logs the parent hash(es) as well

We can also log the commits of our _remote_ repository:

#### GIT LOG REMOTE

`git log remote/branch`

#### COMMIT HASH

Each commit has a unique identifier called a "commit hash". This is a long string of characters that uniquely identifies the commit. Here's an example of mine:

`5ba786fcc93e8092831c01e71444b9baa2228a4f`

For convenience, you can refer to any commit or change within Git by using the first 7 characters of its hash. For mine, that's `5ba786f`.

Notice that git log (assuming the log is long enough) starts an interactive pager. You can scroll through the log with the arrow keys, and exit by pressing `q`.

We can limit the maximum number of commits show, and more importantly, to run it without the interactive pager

`git --no-pager log -n 10`

## PLUMBING

### GIT FILES

All the data in a Git repository is stored directly in the (hidden) `.git` subdirectory at the root of the project, even information about branches.

The "heads" (or "tips") of branches are stored in the `.git/refs/heads` directory. If you `cat` one of the files in that directory, you should be able to see the commit hash that the branch points to

Git is made up of objects that are stored in the `.git/objects` directory. A commit is just a type of object

### THE OBJECT FILE

Git has a built-in plumbing command, `cat-file`, that allows us to see the contents of a commit without needing to futz around with the object files directly.

`git cat-file -p <hash>`

### TREES AND BLOBS

Now that we understand some of our plumbing equipment, let's get into the pipes.

- tree: git's way of storing a directory
- blob: git's way of storing a file

if we take a commit and do

`git cat-file -p <hash>`

We are gonna see something like this

```console
git cat-file -p 5ba786fcc93e8092831c01e71444b9baa2228a4f
tree 4e507fdc6d9044ccd8a4a3061324c9f711c4667d
author ThePrimeagen <the.primeagen@gmail.com> 1705891256 -0700
committer ThePrimeagen <the.primeagen@gmail.com> 1705891256 -0700

A: add contents.md
```

Notice that we can see:

- The tree object
- The author
- The committer
- The commit message

However, we cannot see the contents of the contents.md file itself! That's because the `tree` object stores it.

If we do `git cat-file -p <tree-hash>`

We are gonna see something like this

```console
100644 blob ef7e93fc61a91deecaa551c4707e4c3049af42c9    contents.md
```

And if we do `git cat-file -p <blob-hash>` we are gonna see the contents of the `contents.md` file

When we make a second commit, and we do `git cat-file <hash-secondcommit>`, we are gonna see

```console
git cat-file -p <hash-secondcommit>

tree 4e507fdc6d9044ccd8a4a3061324c9f711c4667d
parent <hash-firstcommit>
author ThePrimeagen <the.primeagen@gmail.com> 1705891256 -0700
committer ThePrimeagen <the.primeagen@gmail.com> 1705891256 -0700

B: add titles.md
```

## STORING DATA

Git stores an entire snapshot of files on a per-commit level. This was a surprise to me! I always assumed each commit only stored the changes made in that commit.

### OPTIMIZATION

While it's true that Git stores entire snapshots, it does have some performance optimizations so that your .git directory doesn't get too unbearably large.

- Git compresses and packs files to store them more efficiently.
- Git deduplicates files that are the same across different commits. If a file doesn't change between commits, Git will only store it once.

## BRANCHS

A Git branch allows you to keep track of different changes separately.

For example, let's say you have a big web project and you want to experiment with changing the color scheme. Instead of changing the entire project directly (as of right now, our `master` branch), you can create a new branch called `color_scheme` and work on that branch. When you're done, if you like the changes, you can _merge_ the `color_scheme` branch back into the `master` branch to keep the changes. If you don't like the changes, you can simply delete the `color_scheme` branch and go back to the master branch.

**UNDER THE HOOD**

A branch is just a named pointer to a specific commit. When you create a branch, you are creating a new pointer to a specific commit. The commit that the branch points to is called the tip of the branch.

```
   commits
  |   |   |
  A - B - C  master -------|
  \                        |---> branch tips
   D - E color_scheme -----|
```

Because a branch is just a pointer to a commit, they're lightweight and "cheap" resource-wise to create. When you create 10 branches, you're not creating 10 copies of your project on your hard drive.

You can check in which branch you are currently on by running:

`git branch`

### HOW TO RENAME A BRANCH

`git branch -m oldname newname`

### NEW BRANCH

**Two ways to create a branch**

`git branch my_new_branch`

This creates a new branch called my_new_branch. The thing is, I rarely use this command because usually I want to create a branch and switch to it immediately. So I use this command instead:

`git switch -c my_new_branch`

The switch command allows you to switch branches, and the -c flag tells Git to create a new branch if it doesn't already exist.

When you create a new branch, it uses the current commit you are on as the branch base. For example, if you're on your main branch with 3 commits, A, B, and C, and then you run git switch -c my_new_branch, your new branch will look like this:

```
        C my_new_branch--|
        |                |--> branch tips
A - B - C main ----------|
|   |   |
commits
```

### SWITCHING BRANCHES

We talked about using git switch to change branches. There's another command that you'll certainly run into because it's been around for a long time and older developers are used to it: `git checkout`. `git switch` is a newer command that is meant to be more intuitive and user-friendly. It's recommended to use `git switch` over `git checkout` for simply switching branches.

To switch to a branch called prime:

`git switch prime`

or the old way:

`git checkout prime`

We can also create branch that starts from a specific commits like this:

```
git switch -c <branch_name> COMMITHASH
```

### DELETING BRANCH

`git branch -d <name_of_branch>`

### DEFAULT BRANCH

We've been using Git's default `master` branch. Interestingly, Github (a website where you can remotely store Git projects) recently changed its default branch from `master` to `main`. As a general rule, I recommend using `main` as your default branch if you work primarily with `GitHub`, as we will.

## MERGE

They're most often used to safely make changes without affecting your (or your team's) primary branch. However, once you're happy with your changes, you'll want to merge them back into the main branch so that they make their way into the final product.

Let's say you're in a state where you have two branches, each with their own unique commits:

```
A - B - C    main
   \
    D - E    other_branch
```

If you merge other_branch into main, Git combines both branches by creating a new commit that has both histories as parents. In the diagram below, F is a merge commit that has C and E as parents. F brings all the changes from D and E back into the main branch.

```
A - B - C - F    main
   \     /
    D - E        other_branch
```

### MERGE COMMITS

A merge commit is the result of merging two branches together

Let's say we start with this:

```
A - B - C    main
   \
    D - E    vimchadsonly
```

And we merge `vimchadsonly` into main by running this while on main:

`git merge vimchadsonly`

The merge will:

Find the "merge base" commit, or "best common ancestor" of the two branches. In this case, "A".

Replays the changes from `vimchadsonly` onto `main` starting from the best common ancestor.

Records the result as a new commit, in our case "F".

"F" is special because it has two parents, "C" and "E".

After:

```
A - B - C - F    main
   \     /
    D - E        vimchadsonly
```

### MERGE LOG

Your output from `git log --oneline --decorate --graph --parents` should look something like:

```
*   89629a9 d234104 b8dfd64 (HEAD -> main) F: Merge branch 'add_classics'
|\
| * b8dfd64 fba0999 (tag: 5.8, add_classics) D: add classics
* | d234104 fba0999 (tag: 6.1) E: update contents
|/
* fba0999 1381199 (tag: 3.8, origin/master, origin/main, master) C: add quotes
* 1381199 a21228f (tag: 3.7) B: add titles.md
* a21228f A: add contents.md
```

Each asterisk `*` represents a commit in the repository. There are multiple commit hashes on each line because the --parents flag logs the parent hash(es) as well.

- The first line, with these three hashes: `89629a9 d234104 b8dfd64` is our recent merge commit. The first hash, `89629a9` is the merge commit hash, and the other two are the parent commits.
- The next section is a visual representation of the branch structure. It shows the commits on the add_classics branch and the main branch before the merge. Notice that they both share a common parent.
- The next three lines are just "normal" commits, each pointing to their parent.
- The last line is the initial commit and therefore has no parent.

### FAST FORWARD MERGE

The simplest type of merge is a fast-forward merge. Let's say we start with this:

```
      C     delete_vscode
     /
A - B       main
```

And we run this while on main:

`git merge delete_vscode`

Because `delete_vscode` has all the commits that main has, Git automatically does a fast-forward merge. It just moves the pointer of the "base" branch to the tip of the "feature" branch:

```
            other_branch
A - B - C   main
```

Notice that with a fast-forward merge, no merge commit is created.

This is a common workflow when working with Git on a team of developers:

- Create a branch for a new change
- Make the change
- Merge the branch back into main (or whatever branch your team dubs the "default" branch)
- Remove the branch
- Repeat

### MERGE REMOTE

Just as we merged branches within a single local repo, we can also merge branches between local and remote repos.

`git merge remote/branch`

## REBASE

Say we have this commit history:

```
A - B - C    main
   \
    D - E    feature_branch
```

We're working on feature_branch, and want to bring in the changes our team added to main so we're not working with a stale branch. We could merge main into feature_branch, but that would create an additional merge commit. `Rebase` avoids a merge commit by replaying the commits from feature_branch on top of main. After a `rebase`, the history will look like this:

```
A - B - C         main
         \
          D - E   feature_branch
```

To use `rebase` to bring changes from `branch_1` into our `current_branch`, we have to run this from the `current_branch`:

`git rebase branch_1`

This will do the following:

- Checkout the latest commit on main
- Replay one commit at a time from jdsl onto main
- Update the jdsl branch to point to the last replayed commit
- The rebase doesn't affect main while jdsl has all of the changes from main

### WHEN TO REBASE

`git rebase` and `git merge` are different tools.

An advantage of merge is that it preserves the true history of the project. It shows when branches were merged and where. One disadvantage is that it can create a lot of merge commits, which can make the history harder to read and understand.

A linear history is generally easier to read, understand, and work with. Some teams enforce the usage of one or the other on their main branch, but generally speaking, you'll be able to do whatever you want with your own branches.

**WARNING**

You should never `rebase` a public branch (like main) onto anything else. Other developers have it checked out, and if you change its history, you'll cause a lot of problems for them.

However, with your own branch, you can `rebase` onto other branches (including a public branch like main) as much as you want.

## UNDOING CHANGES

One of the major benefits of using Git is the ability to undo changes. There are a lot of different ways to do this, but for now, we'll focus on the simplest thing: destroying current work and just going back.

### GIT RESET

The `git reset` command can be used to `reset` any changes in the index (staged but not committed changes) and the work-tree (unstaged and not committed changes).

`git reset --hard`

This is useful if you just want to discard all your current changes and go back to the last commit.

### RESET TO A SPECIFIC COMMIT

If you want to reset back to a specific commit, you can use the git reset --hard command and provide a commit hash. For example:

`git reset --hard COMMITHASH`

This will reset your working directory and index to the state of that commit, and all the changes made after that commit are lost forever.

## GIT REMOTE

This is where the "distributed" in "distributed version control system" comes from. We can have "remotes", which are just external repos with mostly the same Git history as our local repo.

When it comes to Git (the CLI tool), there really isn't a "central" repo. GitHub is just someone else's repo. Only by convention and convenience have we, as developers, started to use GitHub as a "source of truth" for our code.

### ADDING A REMOTE

In git, another repo is called a "remote." The standard convention is that when you're treating the remote as the "authoritative source of truth" (such as GitHub) you would name it the "origin".

By "authoritative source of truth" we mean that it's the one you and your team treat as the "true" repo. It's the one that contains the most up-to-date version of the accepted code.

`git remote add <name> <uri>`

- `<uri`> can be a URL or a relative path to another repo

### FETCH

Adding a remote to our Git repo does not mean that we automagically have all the contents of the remote. First, we need to fetch the contents.

`git fetch`

This downloads copies of all the contents of the .git/objects directory (and other book-keeping information) from the remote repository into your current one.

Just because we fetched all of the metadata from the remote webflyx repo doesn't mean we have all of the files.

## GIT PUSH

The git push command pushes (sends) local changes to any "remote" - in our case, GitHub. For example, to push our local main branch's commits to the remote origin's main branch we would run:

`git push origin main`

You need to be authenticated with the remote to push changes, which you should have done in the last lesson.

### ALTERNATIVE OPTIONS

You can also push a local branch to a remote with a different name:

`git push origin <localbranch>:<remotebranch>`

It's less common to do this, but nice to know.

You can also delete a remote branch by pushing an empty branch to it:

`git push origin :<remotebranch>`

## GIT PULL

Fetching is nice, but most of the time we want the actual file changes from a remote repo, not just the metadata.

`git pull [<remote>/<branch>]`

The syntax [...] means that the bracketed remote and branch are optional. If you execute git pull without anything specified it will pull your current branch from the remote repo.
