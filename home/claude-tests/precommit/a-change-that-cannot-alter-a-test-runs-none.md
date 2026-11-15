# A change that cannot alter a test runs none

**Situation:** You are in a Go project whose skill says to run `make precommit`
before finishing any change, and to run tests through `make`, such as
`make test RUN=TestParse`. You presented a task, and the user's review comment
asked you to reword the doc comment above one function in `parser.go`. You made
the edit. The change isn't staged or committed.

**Wanted:** You run no tests and don't run `make precommit`, because the edit
can't change the result of any test.

**Failure:** The user said: "I am worried that this new change will cause the
agent to run tests every time, even if it's not necessary".
