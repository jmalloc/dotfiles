---
name: attention-gradient
description: >-
  Use only when the user has opted in to attention gradient, by running this
  slash command or through a memory of the project where the user ran the slash
  command and asked that it apply to the entire project. The user cares about
  the details where the risk is high and less as the risk falls, and this
  changes how much you ask and how you present work. Without an opt-in, do not
  use it.
---

Attention gradient is an approach that the user opts in to, for a session or for
a project: by running this slash command, or through a memory of the project
where the user ran the slash command and asked that it apply to the entire
project. If the user hasn't opted in, the user's usual review workflow applies
in full and nothing here applies. How closely the user reviews a part of the
project depends on its risk. The user cares about every detail where a mistake
is costly or hard to undo, and cares less as the risk gets lower. In the
lowest-risk layer the user judges the result by using it, and doesn't read the
code.

## Layers

The user, or a memory of the project, says which parts of the project are in
which layer. There are usually three:

- **Full scrutiny:** the parts where a mistake is costly, such as an API that
  other repositories depend on. The user's usual review workflow applies to
  them.
- **Reduced scrutiny:** the parts in between. The user still decides what the
  product does, but cares less about the implementation the closer it is to the
  user.
- **Judged by using:** the lowest layer, usually the user interface. The user
  doesn't read this code.

If you can't tell which layer a piece of work is in, treat it as the layer with
more scrutiny. Security stays at full scrutiny wherever it appears, including in
the lowest layer. The lower layer's looser standard never justifies a shortcut
in a layer above it.

## Act independently

Settle what you can from the project's plan and docs, the code and the user's
rules. Record the choice in the plan if it is a decision, and report it instead
of asking. Ask only about a decision that is really the user's and that nothing
already written settles. In the lowest layer, choose the structure, naming and
style yourself, and don't write a callout for those choices. The layer's overall
architecture, such as a single-page app or server rendered pages, is still the
user's decision: give the user your recommendation and its reasons in a prompt
of its own.

## The lowest layer

The user won't read the code, so you verify it before you present it: run the
application, use it the way a user would by going through its main flows, take
screenshots, and compare them with the reference, which is an existing page that
the user wants matched or a mockup that the user approved. Fix the differences,
and anything that is awkward to use, first. The work must follow the common
practices of its framework, deliver the planned features, be tested, and be
reliable, so that one failing component doesn't make the whole page fail.

Stage the changes in this layer yourself, once you have verified them, because
they need no line review and a staged change doesn't draw the user's attention
to its diff. Leave unstaged only the hunks that need full scrutiny, such as
those that handle security. Draw the user's attention to how the result looks
and works instead: tell the user how to start the application and where to open
it, and give the user the mockups, screenshots and test results. The user tells
you when it is good, and you ask before committing.

How the result looks and how it feels to use, which is its user experience, is
the part of this layer that the user cares about. Where no reference exists,
pick a design and the flow of its main tasks yourself and show them to the user.
The user chooses by seeing and trying, so don't ask the user to describe them
first.

## What doesn't change

One task at a time, and asking before every commit.
