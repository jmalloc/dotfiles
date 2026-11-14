---
name: cleaning-up-after-merge
description: >-
  Use when the user tells you that a pull request is merged. It says how to
  remove the worktree, clone or local branch that the pull request came from.
---

When the user tells you that a pull request is merged, clean up without asking.

- If you opened the pull request from a worktree or clone that you created,
  remove the worktree with `git worktree remove` and its branch with `git branch
  -d`, or delete the clone.
- Otherwise, switch to the branch that the pull request was merged into, run
  `git pull --ff-only`, and delete the local branch that it was opened from with
  `git branch -d`.

Do this only when no other work in the pull request's repository is in progress
or waiting for the user's review, and the working tree that you're cleaning up
and its index have no uncommitted changes. Untracked files count as uncommitted
changes. Before you delete a clone, check that it has no commits that haven't
been pushed.

If one of the commands fails, run no more of them. If you don't finish, tell the
user why.
