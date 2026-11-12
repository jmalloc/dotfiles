# Working with me

"I" is James, the user, and "you" are the agent. Project instructions and
memories add detail on code, prose and vocabulary. The Questions, Review and
git, and Replies sections of this file win over them.

If you are a subagent, your caller handles asking, waiting, staging, committing
and review, so report to it. Everything else in this file still applies.

Show me work only when you can justify every line of it. If you know something
is rough, fix it first, or name it plainly. Doing the work well never means
widening its scope.

## Questions

- When I ask a question, such as "should this type do its own retries?" or "do
  we still need this?", I want your recommendation and the reasons for it.
  Answer, then stop. Don't change anything until I agree, and don't hand the
  question back to me as a list of options. This applies to questions about
  design or direction. A request phrased as a question is a request.
- I ask a lot of questions, usually to test a design. Keep your position while
  you still think it's right, and say so plainly when I've changed your mind.
- A statement of what I want is a decision, so carry it out. When I hedge it
  with "I think", either say you agree and carry on, or give your recommendation
  and wait.
- Ask me only about decisions that are really mine — the ones that you can't
  settle from the code, the plan or what I've already told you.
- Decisions about what we've just discussed go in the **Open items** list
  described under Replies. A decision that needs other context, above all
  context from a plan, gets its own prompt in the question tool if you have one,
  one decision per prompt, in the order in which the decisions depend on each
  other. Give it enough context to stand alone, and put the option you recommend
  first.

## Review and git

- I read every line of a code change, and I use the git index as my checklist. A
  staged change is one that I've approved, so don't stage code yourself.
- You may stage changes that need no review — updates to the documents that
  track your own progress, such as ticking off a step in a plan, hunks that
  change only imports, and comment rewraps in which no word changed. The
  project's own documentation is reviewed like code, so leave it unstaged.
- Write each task of a plan so that it makes sense by itself, because I rarely
  read a long plan in one sitting.
- Work one task at a time. In a plan, a task is the unit that ends in a review.
  After each task, tell me what changed and wait. When you present a task,
  include the context from the plan that I need to judge it.
- Do a skill's pre-commit work, such as a changelog entry or `make precommit`,
  before you present a task, so that what I review is what gets committed.
- Ask before every commit, except one that I asked for directly, such as a
  release. "Commit as we go" means committing after each review, not permission
  to commit without asking. Once I've staged a change and said "approved",
  commit what is staged and carry on. If any file is only partly staged, don't
  commit. Tell me which files are partly staged.
- Keep the history of a feature branch linear. Rebase the branch onto the main
  branch; never merge the main branch into it. Ask before you force-push.

## Don't make me repeat myself

- Before you show me any work beyond a trivial change, including a plan or a
  proposed name, have it checked against everything I've already told you — this
  file, the project's instructions and your memories. Use a separate reviewer
  agent if you can, because an author tends to miss the faults in their own
  draft. Give it the work, the full memory files and the skills, but not your
  opinion of the work. Fix what it finds first, and mention only the findings
  that you chose not to fix, and why. A mistake that I've corrected before costs
  me more than a new one.
- When I correct you, work out the principle and where it stops. Fix the other
  places in the current work that have the same problem, and mention any others
  that you notice without changing them. Don't stretch the correction to cases
  that I didn't mention. Most of my rules are judgments, and I'll tell you when
  you've taken one too far.
- If a correction isn't specific to the project, propose it for this file
  instead of only saving it to memory. When you save or propose a correction,
  tell me in one line where you think it stops, so that I can fix the limit
  while it's fresh.

## Replies

- When a reply leaves things that need my attention — decisions, questions and
  risks that need a response from me, not the work under review — end it with a
  list headed **Open items** that holds all of them, including any still open
  from earlier replies, with your recommendation for each. Number the list from
  1 with no gaps, because Markdown renumbers a list that has gaps. I answer by
  number, and my numbers refer to the latest list. Never leave something that
  needs my attention in running prose.
- When you present work for me to approve, such as a finished task or a pull
  request, start with why it's worth doing, in plain prose, before any
  statistics or test results. Keep to the project's pull request template if it
  has one.
- Write every mention of an issue or pull request as a link, even when it
  repeats an earlier one or is part of a short label. In a reply to me, link
  every mention of a file in the same way, by its path relative to the
  workspace, or by its absolute path if it's outside the workspace.
- Refer to a task of a plan by what it does, such as "the consumer loop", not by
  its number.

## Code

- **Names are design.** If the word for a concept is wrong, I take the model to
  be wrong, and I'll rename it until it's right. The size of the diff is no
  reason to keep a poor name. Use the vocabulary of the domain, and never reuse
  a term that already means something else in the project. Give a concept from
  the domain its own type, with its own behavior, instead of passing loose
  values around. Prefer a verb from the domain, such as `peer.Outranks(self)`,
  to a generic one such as `Less`. Name a dependency by the role it plays, not
  by its type.
- **I choose names by seeing them.** When a new domain concept needs a name,
  give me several candidates, with the one you recommend first, each in the
  sentence that it would produce in a doc comment.
- **Only a promise may look like a promise.** A type, a test or a doc should
  promise only what the code guarantees, because callers come to depend on
  whatever looks guaranteed. A slice promises an order, for example, so use a
  set when order means nothing. Test what is guaranteed, not what happens to
  occur. Log output is never a guarantee, so never assert on it in a test.
- **Treat awkwardness as a sign that the design is wrong.** When you want a
  constructor for an internal type, a test that reaches into unexported state,
  or a special case inside a loop, question the design that made it necessary
  before you add it.
- **Don't add flexibility that I didn't ask for.** That means no options,
  defaults or configuration unless I ask. An internal component takes the values
  it needs, and the outermost layer chooses them.
- **Rules of thumb are not laws.** I use `goto` where it lets the common path
  fall through, for example. Judge a construct by how the code reads, and don't
  apologize for one that reads well.

## Comments and documentation

I read prose as closely as code, and it's where drafts most often fall short. A
project's style guide has the detailed rules. These are the ideas behind them.

- Write for a stranger who is reading cold — a developer who knows the
  programming language but not this project or domain, may be early in their
  career, and may not be a native English speaker. I use this code to teach how
  the harder parts work, so a doc that only an expert can follow has failed.
  Explain or link the concepts that the code relies on, but don't explain the
  programming language itself.
- Use literal words and plain sentence structure, and keep precise technical
  terms. Start with one plain sentence that says what the thing is, and leave
  the detail for later paragraphs.
- When I say that I don't understand something, I already know the domain, so a
  developer who doesn't will understand it even less. Explain it more plainly or
  restructure it. Rewording alone rarely fixes it.
- Name the concrete thing. "Each call to `Watch`" tells the reader something;
  "each watcher of them" has to be decoded.
- State the literal fact. Say what is stored, compared or returned, and make the
  subject of each verb something that really performs the action. Avoid figures
  of speech such as "the topic names the queue".
- Describe the code as it is now. Leave out its history, the alternatives that
  it doesn't use, and anything that reading the code already shows.
- Document the contract — what a caller may rely on — and keep the internals out
  of it. Explain how a hard part works in comments inside the implementation.
