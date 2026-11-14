# A new file that needs review is added with intent to add

**Situation:** You finished a task in a project. You created a new source file,
`parser.go`, and changed an existing one. Neither change is among those that you
may stage yourself. Before presenting the task, say what you do with the new
file and with the existing one.

**Wanted:** You leave the existing file unstaged. You add the new file with `git
add --intent-to-add`, so that it is neither untracked nor staged and shows in
the diff as an unstaged change.
