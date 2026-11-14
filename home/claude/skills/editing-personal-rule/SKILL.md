---
name: editing-personal-rule
description: >-
  Use when changing home/claude/rules/personal.md in the dotfiles repository, or
  the scenarios in home/claude-tests/ that test it. The user reviews the
  behavior that the user wants, not the text of the rule.
---

`home/claude/rules/personal.md` is the user's personal rule for Claude Code.
Every session loads it, in every project, and so does every subagent. The user
doesn't read the text of a change to it, and the user doesn't approve the
scenario files in `home/claude-tests/`. The user decides each new behavior when
you ask, sees the choices that you made yourself in callouts, and catches
failures with `ahem`. Your job is to produce a rule that gets the behavior the
user wants with as few instructions as possible, and to spend the user's
attention only where it is needed.

## 1. Identify the behavior

Start from a failure that a real session had, such as a reply that the user
quotes. A rule added because it sounds right, with no failure behind it, is a
guess.

Write each behavior as its own file, `home/claude-tests/<group>/<name>.md`,
where the group is the part of the rule or the skill that it tests. The file is
a title and these parts:

- **Situation:** what the agent is doing and what it can see, in a few
  sentences. It must be enough for an agent that has read only the rule.
- **Loaded:** optional, and given as a `loaded:` list in the file's front
  matter. The files, such as a skill or a project's memory, that the agent has
  loaded besides the rule.
- **Wanted:** what the agent does or writes, in terms that you can check from
  its reply, such as "ends with a table that has one row per close call". Don't
  describe the wording of the rule.
- **Failure:** the real reply or behavior that led to the scenario, quoted. Omit
  this for a scenario that guards against a likely failure and has none yet.

Write scenarios at the edges too: next to a neighboring instruction in the rule,
inside a subagent, and next to a skill or a project's template that covers the
same ground. A scenario that already exists may cover the new behavior. Reuse it
before you write another.

Take the wanted behavior from what the user has already said. Where the user
hasn't decided it, put it in the agenda before you edit the rule, one row for
each behavior, with your recommendation.

## 2. Change the rule

Make the smallest change that gets the wanted behavior.

- **Widen or remove before adding.** Read the instructions near the failure. If
  one almost covers it, widen it. If an instruction doesn't change what an agent
  does in any scenario, remove it.
- **It belongs in this file.** This file holds how to work with the user and the
  principles behind the user's taste in code and prose, for every repository. A
  skill holds conventions for one kind of task and loads only when the task
  matches. A project's memory holds that project's vocabulary and decisions that
  are still changing.
- **State a principle, then one or two examples.** An agent treats each example
  as a case that the rule covers, so check each one against the rest of the
  file.
- **An agent can tell whether it applies,** from what it can see, in the middle
  of other work, with no memory of this conversation. It makes sense for a
  subagent, which has no user to ask. It doesn't contradict a skill or override
  a project's instructions where it shouldn't.
- **Use the file's existing words,** such as "Agenda", "task" and "approve". Use
  literal wording, with no figures of speech. Describe the rule as it is now,
  without its history.
- Lines wrap at 80 columns.

## 3. Run the scenarios

Run every scenario file under `home/claude-tests/`, not only the new ones.

1. Start one `rule-scenario-runner` agent per scenario, all in the same message.
   Give each the path to the rule file, the scenario's Situation and the paths
   in its `loaded:` list. Don't give it Wanted, Failure, your opinion of the
   change, or any other scenario.
2. Compare each result with Wanted. A result passes, fails, or is uncertain.
   Treat an uncertain result as a failure, unless every reading of it leads to
   harmless behavior. Name such a scenario to the user, list each reading, and
   say why each one is harmless.
3. Fix the wording and run again until every scenario passes.
4. Removal test: for each instruction that you added or widened, run the
   scenarios against a copy of the rule without it, in the scratchpad. If no
   scenario behaves differently, remove the instruction.

Then have the `instruction-checker` agent check the change once, and fix what it
finds.

## 4. Present one feature at a time

Present each feature as its own hand-in and its own commit, even when you
changed several in one session. A hand-in opens with the failure that the change
fixes, then says in a line each what behavior changed, and names the
instructions that you added, widened or removed. It has a callout for each
choice that you made yourself. It doesn't ask the user to read the rule's text
or the scenario files.

How much of the user's attention a behavior gets depends on how hard it is to
undo:

- **Hard to undo, or acts outside the session:** git actions such as staging,
  committing, pushing and deleting, filing or posting anything externally, and
  anything that overrides the user's review rules. Each one is its own agenda
  row before you commit.
- **Changes only how you write replies:** the agenda, callouts, emojis and
  wording. Commit it after the scenarios pass, and report it in the hand-in. The
  user judges it by seeing it in use.
- **Tests, skill wording and the layout of the tests:** the user doesn't see
  these unless a scenario fails.

Ask before every commit, with one agenda row for the feature. When the user says
yes, stage and commit that feature's files. The commit goes straight onto the
default branch, not through a pull request. Committing doesn't install anything.
Run `make install`, then check that each file that you changed under
`home/claude` has the same content under `~/.claude`.
