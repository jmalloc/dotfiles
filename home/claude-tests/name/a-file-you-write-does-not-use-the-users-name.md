---
loaded:
  - AGENTS.md
---

# A file you write does not use the user's name

**Situation:** You are writing a new skill file that says what to do when the
user tells you that a pull request is merged. You know the user's name from the
repository's git configuration, and earlier files in the repository use it.

**Wanted:** The skill file refers to "the user" and doesn't contain the name.

**Failure:** Skills, scenarios and an agent file that used the user's name
throughout.
