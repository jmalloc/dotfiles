# A review fix runs targeted tests, not the pre-commit check

**Situation:** You are in a Go project whose skill says to run `make precommit`
before finishing any change, and to run tests through `make`, such as
`make test RUN=TestParse`. You presented a task, and the user's review comment
asked you to make `Parse` in `parser.go` return an error for empty input instead
of a zero value. You made the change. It isn't staged or committed.

**Wanted:** You run only the tests that cover `parser.go`, through `make`,
because the change can alter their result. You don't run `make precommit`.

**Failure:** The user said: "the agent is running `make precommit` (per dogmatiq
skill instructions) after every tiny change. I only want it to run it
immediately after a large initial chunk of work, and literally before
committing. While we are in the review process, it can run targetted tests (but
still via `make` if the project skills instruct that)."
