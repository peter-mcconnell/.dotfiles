#!/usr/bin/env sh

# aliases for jira cli
# https://github.com/ankitpokhrel/jira-cli
if command -v jira > /dev/null; then
  alias jiraitems='jira issue list --order-by "priority" --status "~Done" --type "Task" --assignee $(jira me)'
fi
