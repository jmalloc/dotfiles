# Reviewing changes to the personal rule

[`home/claude/rules/personal.md`][rule] is my personal rule for Claude Code.
Every session loads it, in every project, and so does every subagent. This
document lists what a change to it must satisfy, for whoever writes the change
and for whoever reviews it. Where a check has caught a real problem, it gives
that problem as an example. The project's [`AGENTS.md`][agents] points to this
document, so the `instruction-checker` agent, defined in
[`home/claude/agents/instruction-checker.md`][checker], checks a change to the
rule against it. The agent can't run the scenario tests in "Has it been
tested?", so the author still runs those.

## Does the change earn its place?

- **It fixes something that a real session got wrong.** A line added because it
  sounds right, with no failure behind it, is a guess. For example, the bullet
  about starting with why came from pull request bodies that opened with a line
  of sizes and part numbers, and gave a statistic as the only reason.
- **Nothing in the file already covers it.** Read the bullets near it. If an
  existing bullet almost covers the failure, widen that bullet instead of adding
  a new one.
- **It belongs in this file.**
  - This file holds how to work with me, and the principles behind my taste in
    code and prose. It applies in every repository.
  - A skill holds the conventions that every contributor to a project follows,
    such as how to test, detailed prose rules and commit messages. A skill loads
    only when it is relevant, so it doesn't count against this file's size.
  - A project's memory holds that project's vocabulary, decisions that are still
    changing, and trials that haven't proved themselves yet.
- **It states a principle, not one incident.** A list of examples copied from
  one failure, such as "statistics, links or verification", reads as the whole
  rule and misses the next case. State the principle, then give one or two
  examples.

## Size

The cost of this file isn't the tokens it uses. About 2,000 tokens is small next
to the system prompt that loads with it. The cost is the number of separate
instructions. The more instructions an agent has, the less likely it is to
follow any one of them, and the instructions that apply only now and then are
the ones it's least likely to follow. Each new instruction is also another
chance for two of them to conflict.

- **It adds as few instructions as it can.** Widening an existing bullet is
  better than adding a new one.
- **The file is under about 2,000 words.** The word count doesn't measure the
  cost, but it's a cheap signal that the file needs pruning. Past it, prune the
  file before adding anything else.

## Can an agent apply it?

An agent reads the rule literally, without the context of the conversation that
produced it, and usually in the middle of other work.

- **An agent can tell whether it applies.** The agent must be able to decide
  from what it can see. "A pull request body for me" failed this check, because
  an agent can't tell which pull requests are for me. "Work for me to approve"
  passes, because an agent knows who approves the work.
- **Every example is a case that it should cover.** An agent treats each example
  as a case that the rule covers. A draft of the bullet about starting with why
  listed "a proposal" as an example, so it would also have changed how an agent
  answers my questions, which the Questions section already covers. Check each
  example against the rest of the file.
- **It overrides only what it should.** The opening paragraph says that the
  Questions, Review and git, and Replies sections win over project instructions
  and memories. A bullet in those sections therefore overrides a project's
  instructions, such as its pull request template. If that isn't intended, the
  bullet must say what takes precedence over it, as the bullet about starting
  with why does with "Keep to the project's pull request template if it has
  one."
- **It doesn't contradict a skill.** Read the skills that cover the same ground,
  such as `committing`, `releasing` and `building`. A proposed sentence said
  that this file wins over "a skill's or harness's instruction", which would
  have overridden the `committing` skills in exactly the cases that they cover.
- **It makes sense for a subagent.** A subagent loads this file, but it has no
  user to ask, and its caller handles "asking, waiting, staging, committing and
  review". Check that the new instruction works for a subagent, or that the
  paragraph about subagents already exempts it.
- **It uses the file's existing words.** Use the terms that the file already
  uses, such as "Open items", "task" and "approve". A new word for an existing
  concept reads as a new concept. A bullet once mentioned "the list" before the
  file had introduced any list, and the list is now named "Open items".
- **The wording is literal.** The file asks for literal prose in docs, and the
  same applies to the file itself. Avoid figures of speech, and words whose
  meaning depends on the conversation that produced them. Write "programming
  language" where "language" could mean English. A bold label at the start of a
  bullet may be a short slogan, such as "Names are design.", as long as the
  sentences after it state the rule literally.
- **It describes the rule as it is now.** Leave out the history of a rule and
  any trial. A trial lives in a project's memory until it has proved itself.

## Has it been tested?

A change to the rule is tested by experiment, like code.

- **An independent agent tested it.** The agent was given the changed file, the
  diff and concrete scenarios, but not the author's opinion of the change or the
  answers the author expects.
- **The scenarios reach the edges.** Each scenario is a situation and a
  question, such as "James asks whether this type should do its own retries.
  Does the new bullet change how you answer?". Some scenarios sit at the edges
  of the scope, and some put the new text next to another bullet, a skill or a
  project's template.
- **Every scenario passes.** A wrong or uncertain answer is a failing test. Fix
  the wording and test again. An uncertain answer may stand only when every
  reading leads to harmless behavior. The reply that presents the change then
  names the scenario, lists every reading that the tester reported, and says why
  each one is harmless, so that approving the change accepts that judgment.

## Mechanics

- Lines wrap at 80 columns.
- A change to the rule doesn't go through a pull request. I review it locally,
  in the git index, and the commit goes straight onto the default branch once I
  approve it.
- The reply that presents the change opens with the failure that the change
  fixes. It gives the word count from `wc -w`, and says which scenarios were
  tested.
- Committing doesn't install anything. Run `make install`, then check that each
  file that you changed under `home/claude` has the same content under
  `~/.claude`.

[rule]: ../home/claude/rules/personal.md
[checker]: ../home/claude/agents/instruction-checker.md
[agents]: ../AGENTS.md
