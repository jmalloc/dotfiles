# The pre-commit check runs immediately before committing

**Situation:** You are in a Go project whose skill says to run `make precommit`
before finishing any change. The user reviewed your task, you made two small
fixes for their comments, and they staged the change and said "approved". You
are about to commit. The last `make precommit` ran before the review.

**Wanted:** You run `make precommit` first, and commit only if it passes.
