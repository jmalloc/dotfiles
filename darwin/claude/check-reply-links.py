"""Blocks a Claude Code reply that mentions a file or an issue without a link.

Claude Code runs this as a Stop hook, after the agent finishes a reply, and
passes it the reply's last message as "last_assistant_message". The hook looks
for two things outside code blocks and existing links:

  - text that looks like a file path, such as `docs/plan.md`, in backticks or
    not, and
  - an issue or pull request number such as #123.

If it finds any, it prints a "block" decision, and Claude Code sends the reason
back to the agent instead of ending the turn, so the agent rewrites the reply
with links. When the agent has already been blocked once in this turn, the hook
lets the reply through, so that a false positive can't stop a turn from ending.
"""

import json
import re
import sys

# File extensions that mark a word as a file name rather than, say, a Go
# identifier such as sync.Mutex.
EXTENSIONS = (
    "bash cfg conf css csv go html ini js json jsonl lock log md mod nix proto "
    "py rs sh sql sum svg tf toml ts tsx txt xml yaml yml zsh"
).split()

FENCE = re.compile(r"^(```|~~~).*?^\1[^\n]*$", re.MULTILINE | re.DOTALL)
LINK = re.compile(r"\[[^\]]*\]\([^)]*\)")
URL = re.compile(r"https?://\S+")
CODE = re.compile(r"`([^`\n]+)`")
FILE_WORD = re.compile(
    r"(?<![\w/.@-])((?:~|\.{1,2})?/?[\w@-][\w@./-]*\.(?:"
    + "|".join(EXTENSIONS)
    + r"))(?![\w/-])"
)
ISSUE = re.compile(r"(?<![\w/&\]])#(\d+)\b")


def main():
    hook = json.load(sys.stdin)

    if hook.get("stop_hook_active"):
        return

    problems = find_problems(hook.get("last_assistant_message", ""))

    if problems:
        print(
            json.dumps(
                {
                    "decision": "block",
                    "reason": (
                        "The reply mentions these without a link: "
                        + ", ".join(problems)
                        + ". Rewrite the reply so that each one is a markdown link."
                        + " Link a file by its path relative to the workspace,"
                        + " or by its absolute path if it's outside the workspace."
                        + " If one of them isn't a file or an issue, say so and"
                        + " leave it as it is."
                    ),
                }
            )
        )


def find_problems(reply):
    """Returns each file path and issue number that the reply doesn't link."""

    prose = FENCE.sub("", reply)
    prose = LINK.sub("", prose)
    prose = URL.sub("", prose)

    found = []

    for span in CODE.findall(prose):
        if " " not in span and looks_like_path(span):
            found.append(f"`{span}`")

    prose = CODE.sub("", prose)
    found += FILE_WORD.findall(prose)
    found += ["#" + n for n in ISSUE.findall(prose)]

    return list(dict.fromkeys(found))


def looks_like_path(span):
    """Reports whether text in backticks looks like a file path.

    A slash command such as /effort, and an extension such as .pb.go, aren't
    paths, so a leading "/" needs a second "/" or a "." after it, and a leading
    "." needs a "/" after it.
    """

    if span.startswith(("~/", "./", "../")):
        return True

    if span.startswith("/"):
        return "/" in span[1:] or "." in span

    if span.startswith(".") and "/" not in span:
        return False

    return FILE_WORD.fullmatch(span) is not None


if __name__ == "__main__":
    main()
