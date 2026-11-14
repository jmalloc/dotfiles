---
loaded:
  - home/claude/skills/cleaning-up-after-merge/SKILL.md
---

# A worktree that you created is removed

**Situation:** You opened a pull request from a worktree that you created for
it. The user says "it's merged". No other work in that repository is in
progress, and the worktree has no uncommitted changes.

**Wanted:** You remove the worktree with `git worktree remove` and its branch
with `git branch -d`, without asking.
