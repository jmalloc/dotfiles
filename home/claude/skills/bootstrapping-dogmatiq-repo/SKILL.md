---
name: bootstrapping-dogmatiq-repo
description: Use when setting up a new Dogmatiq repository, or one that lacks the standard files (Makefile, .gitignore, apm.yml, mise.toml, CHANGELOG.md, README.md). Triggers: new repo, set up repo, bootstrap repo, repo basics, standard files.
---

Add the files that every Dogmatiq repository has to the current repository. Ask the user for nothing that you can look up. Leave a file alone if it already exists, and mention any way in which it differs from the template.

Add only the files below. Other files, such as a `package.json`, `go.mod`, `doc.go`, `.vscode/`, or a makefile include for JavaScript, Docker, Helm, Protobuf or Prettier, depend on what the project is, so they are not part of this skill.

## Find the inputs

- **Name**: the repository's name, from `git remote get-url origin`, or the directory name if there is no remote.
- **Description**: `gh repo view --json description --jq .description`. Drop a leading 🚧. If the repository has no description, ask the user once.
- **Go**: whether there is a `go.mod`.
- **Agent config version**: `gh api repos/dogmatiq/agent-config/releases/latest --jq .tag_name`.

## Don't write the generated files

Terraform generates these files from the `dogmatiq/repos` repository. Each has a "DO NOT EDIT!" header. Never write them by hand.

- `LICENSE`
- `codecov.yml`
- `.github/dependabot.yml`
- `.github/workflows/ci.yml`
- `.github/workflows/dependabot.yml`
- `.github/workflows/publish-release.yml`

If any of them is missing, run `git pull` first, because Terraform commits them to the remote. If they are still missing, the repository is probably not registered in `dogmatiq/repos` yet. Tell the user, and carry on with the rest.

## Write these files

### Makefile

Include the shared makefiles in this order: the base, the changelog, the Go include if the repository is a Go project, then APM. The `.makefiles/%` rule goes last.

```make
-include .makefiles/Makefile
-include .makefiles/pkg/changelog/v2/Makefile
-include .makefiles/pkg/go/v1/Makefile
-include .makefiles/pkg/apm/v1/Makefile

.makefiles/%:
	@curl -sfL https://makefiles.dev/v1 | bash /dev/stdin "$@"
```

- Leave the Go line out if the repository is not a Go project.

### .gitignore

A repository's `.gitignore` ignores only what the repository itself produces.

```gitignore
/.makefiles/
/artifacts/
apm_modules/
/apm.lock.yaml
```

### apm.yml

```yaml
name: <name>
version: 0.0.0
dependencies:
  apm:
    - "dogmatiq/agent-config/internal#<agent config version>"
```

### mise.toml

```toml
[tools]
apm = "0"
```

### CHANGELOG.md

Leave `[Unreleased]` empty. An entry is added with the change that needs it.

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog], and this project adheres to
[Semantic Versioning].

<!-- references -->

[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[semantic versioning]: https://semver.org/spec/v2.0.0.html

## [Unreleased]
```

### README.md

Follow the `writing-prose` skill. The title is the repository's name in title case. The paragraph is the description, expanded into one or two plain sentences only if the description is too short to stand alone. Don't invent features, installation steps or usage.

```markdown
<div align="center">

# <Title>

<description>

[![Latest Version](https://img.shields.io/github/tag/dogmatiq/<name>.svg?&style=for-the-badge&label=semver)](https://github.com/dogmatiq/<name>/releases)
[![Build Status](https://img.shields.io/github/actions/workflow/status/dogmatiq/<name>/ci.yml?style=for-the-badge&branch=main)](https://github.com/dogmatiq/<name>/actions/workflows/ci.yml)

</div>
```

- For Go, put this badge first and this one last, so there are four:
  - `[![Documentation](https://img.shields.io/badge/go.dev-documentation-007d9c?&style=for-the-badge)](https://pkg.go.dev/github.com/dogmatiq/<name>)`
  - `[![Code Coverage](https://img.shields.io/codecov/c/github/dogmatiq/<name>/main.svg?style=for-the-badge)](https://codecov.io/github/dogmatiq/<name>)`
- If the repository has no release tags, add this under the badges:

  ```markdown
  > [!WARNING]
  > This project is under development and has not been released.
  ```

## Check

Run `make`. It installs the shared makefiles and the agent skills, which confirms that the Makefile and `apm.yml` work. Then run `git status` and confirm that only the files above, plus anything you were already changing, are new or modified. The installed makefiles and skills are ignored.

Report which files you wrote, which you skipped because they existed, and which generated files are missing.
