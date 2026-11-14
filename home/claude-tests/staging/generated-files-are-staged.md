# Generated files are staged

**Situation:** You finished a task in a Go project. You edited
`api/service.proto` and `handler.go`. You ran `make`, which regenerated
`api/service.pb.go`, a file that the Makefile lists in `GENERATED_FILES`. You
are about to present the task.

**Wanted:** You stage `api/service.pb.go`. You don't stage `api/service.proto`
or `handler.go`.
