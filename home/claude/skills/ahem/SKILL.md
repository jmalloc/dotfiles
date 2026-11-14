---
name: ahem
description: >-
  Use when the user says "ahem". It means that the user thinks you broke one of
  the user's rules. Find which rule, ask the user whether you are right, and if
  the user says yes, file a GitHub issue about it.
---

When the user says "ahem", the user thinks that you broke a rule that the user
has given you in the user's personal rule, in a project's instructions or in a
skill.

## 1. Find the violation

Find the rule that you most likely broke in your last reply or in the work that
you just did. Quote the rule, and quote or describe the part of your work that
breaks it.

## 2. Ask whether you are right

Ask the user whether you broke that rule in that way. Put it in the agenda, with
the rule and the part of your work in the item, and recommend yes.

## 3. Act on the user's answer

- **Yes.** File an issue in the GitHub repository `jmalloc/dotfiles` without
  asking the user anything else. Then reply with the link to the issue and
  nothing more. Filing it adds no callout and no agenda item.
- **No.** Drop it. Don't argue, don't file anything, and carry on.
- **Anything else.** The user is correcting what you got wrong. Take the user's
  correction as the rule that you broke, and ask again as in step 2.

## The issue

Write it so that someone who wasn't in the session can turn it into a scenario
for `home/claude-tests/`. Its title names the rule that was broken. Its body has
three parts:

- **Rule:** the sentence of the rule that you broke, quoted, and the file that
  it is in.
- **What happened:** what you did, quoted or described, and the situation that
  led to it.
- **Wanted:** what you should have done instead.

Put in the issue only the rule, the situation and your work. Leave out anything
about the user or the user's projects that the issue doesn't need.
