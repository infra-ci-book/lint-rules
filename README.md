# lint-rules

lint-rules is a dispacher script of LINT.


## Requirements

- https://hub.docker.com/r/irixjp/lint-rules/


## Usage

Apply lint to all files
```shell
git clone https://github.com/infra-ci-book/lint-rules.git
lint-rules/lint_master.sh
```

Apply lint to branch files
```shell
git clone https://github.com/infra-ci-book/lint-rules.git
lint-rules/lint_branches.sh
```

## Ex) GitLab CI

```yaml
Lint_Check_Master:
  stage: lint
  image:
    name: irixjp/lint-rules:latest
    entrypoint: [""]
  script:
    - git clone https://github.com/infra-ci-book/lint-rules.git
    - lint-rules/lint_master.sh
  only:
    - master
  tags:
    - docker

Lint_Check_Branches:
  stage: lint
  image:
    name: irixjp/lint-rules:latest
    entrypoint: [""]
  script:
    - git clone https://github.com/infra-ci-book/lint-rules.git
    - lint-rules/lint_branches.sh
  only:
    - branches
  except:
    - master
  tags:
    - docker
```

## Test list

- ANSIBLE0002: Trailing whitespace
  - There should not be any trailing whitespace
- ANSIBLE0004: Git checkouts must contain explicit version
  - All version control checkouts must point to an explicit commit or tag, not just "latest"
- ANSIBLE0005: Mercurial checkouts must contain explicit revision
  - All version control checkouts must point to an explicit commit or tag, not just "latest"
- ANSIBLE0006: Using command rather than module
  - Executing a command when there is an Ansible module is generally a bad idea
- ANSIBLE0007: Using command rather than an argument to e.g. file
  - Executing a command when there is are arguments to modules is generally a bad idea
- ANSIBLE0008: Deprecated sudo
  - Instead of sudo/sudo_user, use become/become_user.
- ANSIBLE0009: Octal file permissions must contain leading zero
  - Numeric file permissions without leading zero can behavein unexpected ways. See http://docs.ansible.com/ansible/file_module.html
- ANSIBLE0010: Package installs should not use latest
  - Package installs should use state=present with or without a version
- ANSIBLE0011: All tasks should be named
  - All tasks should have a distinct name for readability and for --start-at-task to work
- ANSIBLE0012: Commands should not change things if nothing needs doing
  - Commands should either read information (and thus set changed_when) or not do something if it has already been done (using creates/removes) or only do it if another check has a particular result (when)
- ANSIBLE0013: Use shell only when shell functionality is required
  - Shell should only be used when piping, redirecting or chaining commands (and Ansible would be preferred for some of those!)
- ANSIBLE0014: Environment variables don't work as part of command
  - Environment variables should be passed to shell or command through environment argument
- ANSIBLE0015: Using bare variables is deprecated
  - Using bare variables is deprecated. Update yourplaybooks so that the environment value uses the full variablesyntax ("{{your_variable}}").
- ANSIBLE0016: Tasks that run when changed should likely be handlers
  - If a task has a `when: result.changed` setting, it's effectively acting as a handler
- ANSIBLE0017: become_user requires become to work as expected
  - become_user without become will not actually change user
- ANSIBLE0018: Deprecated always_run
  - Instead of always_run, use check_mode.
