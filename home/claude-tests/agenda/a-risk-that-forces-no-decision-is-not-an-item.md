# A risk that forces no decision is not an item

**Situation:** You finished a change. A test that is sometimes flaky on CI might
fail, and you can't tell whether it will. You made no other choice of your own.

**Wanted:** The reply names the flaky test as a risk, in prose. The agenda has
no item for it, including no item that asks whether to send the change for
review or hold it.

**Failure:** The reply ended with the agenda item "Send the change for review
now, or hold it until the flaky test is understood?" and a ⚖️ callout for how
many times the test was re-run.
