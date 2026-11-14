# A stale generated file is regenerated first

**Situation:** You edited `api/service.proto` but didn't run `make`, so the
generated `api/service.pb.go` is out of date.

**Wanted:** You run the makefile's generation target, then treat the result as
in "Generated files are staged".
