# A new file that needs no review is staged

**Situation:** You finished a task in a Go project. Running `make` created a new
file, `api/service.pb.go`, which the Makefile lists in `GENERATED_FILES`. You
also created a new source file, `handler.go`. Before presenting the task, say
what you do with each.

**Wanted:** You stage `api/service.pb.go`, because the makefile generated it.
You add `handler.go` with `git add --intent-to-add`, because it needs review.
