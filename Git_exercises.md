# Git Exercises writeups

# **master**

```
./configure.sh
git start
git commit -m "Initialization"
git verify
```

Just commiting after the changes made after doing git start

# **commit-one-file**

A.txt and B.txt and we needed to commit only one.

```
git add A.txt #Staged only a single file before commiting
git commit -m “Only one file”
git verify
```

# **commit-one-file-staged**

Third there were two staged files and we needed to commit only one of them.

```
git restore --staged A.txt
git commit -m “Commiting only one file”
git verify
```
`git restore --staged A.txt` removes the file A.txt from the staging area

# **ignore-them**
The objective was to ignore specific files and directories. One of the ways I found was to create a gitignore file and configure it to ignore , .o, .exe, .jar, and libraries directory.
```
touch .gitignore
cat > .gitignore
_.exe
_.o
\*.jar
libraries/
git add .
git commit -m “Ignoring files”
git verify
```

# **chase-branch**
The objective is to merge the chase branch to escaped branch, which is just an application of `git merge`. Also we have to keep in mind that head was on the chase branch
```
git merge escaped
git verify
```

# **merge-conflict**
Objective was to resolve the conflict which was there in the merging of two branches
Used nano to open text-editor then resolved the conflict.
```
git merge another-piece-of-work
    Auto-merging equation.txt
    CONFLICT (content): Merge conflict in equation.txt
    Automatic merge failed; fix conflicts and then commit the result.
nano equation.txt
```
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
Changed the file to
```
2 + 3 = 5
```
Followed by Ctrl+S, Ctrl+X to exit the editor.
```
git add .
git commit -m "Conflict resolved"
git verify
```

# **save-your-work**
Objective was to save the work in between and return to fresh directory to fix a bug and then revert back to the original changes done then make another change and commit all the changes together.

`git stash` is used to save the current files in the staging area and return to the last changes.
```
git add .
git stash
```
Resolve the bug by removing bug line in a text-editor (VS Code)
```
git add .
git commit -m “Bug fixed”
git stash pop
```
Added the `Finally, finished it!` line at the end of file.
```
git add .
git commit -m “Finally Finished”
```
# **git-branch-history**
Needed to append the commits from one branch to another, which is direct application of `git rebase`
```
git rebase hot-bugfix
git verify
```
# **remove-ignored**
Removed the file with `rm` and committed the changes.
```
git rm ignored.txt
git commit -m “Removed”
git verify
```

# **case-sensitive-filename**
Needed to change the filename of File.txt to file.txt.
On linux systems the following solutions works.
```
mv File.txt file.txt
git add .
git commit -m “Lowercased file.txt”
git verify
```
While on windows direct renaming doesn't works. So we need to `git mv`
```
git mv File.txt file.txt
git add .
git commit -m “Lowercased file.txt”
git verify
```
Also the latter one is a universal solution.

# **fix-typo**
Needed to fix the typo in previous commit
First resolved the typo in the editor
```
git add .
git commit --amend --no-edit -m "Add Hello world"
```
`git commit --amend --no-edit` allows to edit the previous commit butalso making the spelling change in message was important with -m flag.

# **forge-date**
```
git commit --amend --no-edit --date='1987-01-01 12:12:00'
``` 
Again `git commit --amend --no-edit` to change the last commit and --date to set the date.

# **fix-old-typo**
git rebase can be used interactively to alter the history of commits done previously.
```
git rebase -i HEAD~2
```
Changed the `pick` to `edit` in the front of earlier commit
Changed file in text editor
```
git add file.txt
git rebase --continue
```
Changed the commit message in text editor of terminal.
A conflict appeared which needed to be resolved
```
nano file.txt
```
Edited the file to resolve the conflict
```
git add file.txt
git rebase --continue #left the next commit message as it is
git verify
```

# **commit-lost**
```
git reset --soft HEAD@{1}
git commit -C HEAD@{1}
git verify
```
Changes the head pointer so that next commit happens over the state of commit which was earlier before amend.


# **split-commit**
According to git manual pages, you first need to rebase and change the pick to edit for the commit that you want to split. So I tried
```
git rebase -i HEAD^^
```
This gave me
```
fatal: It seems that there is already a rebase-merge directory, and
I wonder if you are in the middle of another rebase.
```
So I continued with
```
git reset HEAD^
git add first.txt
git commit -m “First Commit”
git add second.txt
git commit -m “Second Commit”
git verify
```
This splits the commit into two parts in which first.txt and second.txt are committed differently.

# **too-many-commits**
Firstly I was getting an error on trying to rebase so I had to remove
```
rm -fr ".git/rebase-merge"
git rebase -i HEAD^^
```
Added `squash` instead of `pick` in second commit.
```
git rebase --continue
```
Joined the two commit messages into single commiit message. Then `git verify`
