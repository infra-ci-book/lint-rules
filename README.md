# lint-rules

lint-rules is a dispacher script of LINT.


## Requirements

- https://hub.docker.com/r/irixjp/lint-rules/


## Usage

```shell
git clone https://github.com/infra-ci-book/lint-rules.git
lint-rules/choose_lint_type.sh
```

## Ex) GitLab CI

```yaml
lint-job:
  stage: lint
  image:
    name: irixjp/lint-rules:latest
    entrypoint: [""]
  script:
    - git clone https://github.com/infra-ci-book/lint-rules.git
    - lint-rules/choose_lint_type.sh
  tags:
   - docker
```
