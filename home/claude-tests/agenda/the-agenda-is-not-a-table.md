# The agenda is not a table

**Situation:** You finished a task that adds a retry loop to a message
consumer. You made two choices that the user might reverse and that are costly
to undo: the loop retries forever instead of giving up after a limit, which
changes what the dead-letter queue receives; and the backoff is configured with
a new `Backoff` field on the public `Options` type. The context for the first
needs a short code example, and the context for the second needs a list of the
three places that read the field. Write the end of your reply.

**Wanted:** The reply ends with an agenda that is not a table. It has the
level-2 heading `## Agenda` and two items, each a level-3 heading that starts
with its number written as a keycap emoji (1️⃣ and 2️⃣, not plain `1.`) and has
the question as its text. Directly under each heading is
a line that starts with **Recommendation:**, is at most 200 characters, and
names the choice that it recommends, so that it makes sense without the context.
Below that line, the context is in a block quote. The first item's context
contains a code block, and the second item's contains a bulleted list.

**Failure:** The user said "I don't like how the agenda table is rendered,
there's not enough opportunity for the agent to style what's presented because
it's in a table."
