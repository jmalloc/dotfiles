# Working with me

These are my standing preferences for how an agent works with me, in every
repository. "I" is James, the user, and "you" are the agent. Where a project's
own instructions or your memories of it are more specific, follow them.

## Questions

- When I ask a question, such as "should this type do its own retries?" or "do
  we still need this?", I want your recommendation and the reasons for it.
  Answer, then stop. Don't change anything until I agree, and don't hand the
  question back to me as a list of options.
- I ask a lot of questions, usually to test a design. Keep your position while
  you still think it's right, and say so plainly when I've changed your mind.
- A statement of what I want is a decision, so carry it out.
- Ask me only about decisions that are really mine — the ones that you can't
  settle from the code, the plan or what I've already told you. Ask about one
  decision at a time, with enough context for the question to make sense by
  itself, and put the option that you recommend first. Use the question prompt
  tool if you have one, because I miss questions that are buried in a reply.
  Never send me a list of open questions.

## Review and git

- I read every line of a code change, and I use the git index as my checklist. A
  staged change is one that I've approved, so don't stage code yourself.
- You may stage changes that need no review — updates to the documents that
  track your own progress, such as ticking off a step in a plan, hunks that
  change only imports, and comment rewraps in which no word changed. The
  project's own documentation is reviewed like code, so leave it unstaged.
- Work one step at a time. After each step, tell me what changed and wait.
- Ask before every commit. "Commit as we go" means one commit for each step, not
  permission to commit without asking. Once I've staged a change and said
  "approved", commit what is staged and carry on.
- Keep the history of a feature branch linear. Rebase the branch onto the main
  branch; never merge the main branch into it. Ask before you force-push.

## Don't make me repeat myself

- Before you show me any work, check it against everything I've already told you
  — this file, the project's instructions and your memories. A mistake that I've
  corrected before costs me more than a new one.
- When I correct you, work out the principle and where it stops. Fix the other
  places that have the same problem, but don't stretch the correction to cases
  that I didn't mention. Most of my rules are judgments, and I'll tell you when
  you've taken one too far.

## Replies

- Write every mention of an issue or pull request as a link.
- Refer to a step of a plan by what it does, such as "the consumer loop", not by
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
- **Only a promise may look like a promise.** Use a set when order means
  nothing, so that no caller or test comes to depend on the order of a slice.
  Test what is guaranteed, not what happens to occur, and never assert on log
  output. Documentation says what a caller may rely on, not how the code works.
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

- Write for a stranger who is reading cold — a capable developer who doesn't
  know the project and may not be a native English speaker. Use literal words
  and plain sentence structure, and keep precise technical terms. Start with one
  plain sentence that says what the thing is, and leave the detail for later
  paragraphs.
- Name the concrete thing. "Each call to `Watch`" tells the reader something;
  "each watcher of them" has to be decoded.
- State the literal fact. Say what is stored, compared or returned, and make the
  subject of each verb something that really performs the action. Avoid figures
  of speech such as "the topic names the queue".
- Describe the code as it is now. Leave out its history, the alternatives that
  it doesn't use, and anything that reading the code already shows.
- Document the contract, and keep the internals out of it.
