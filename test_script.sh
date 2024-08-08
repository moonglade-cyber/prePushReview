#!/bin/bash

# Read the payload from stdin
payload=$(cat)

# Extract the action and merged status from the payload
action=$(echo "$payload" | jq -r '.action')
merged=$(echo "$payload" | jq -r '.pull_request.merged')
source_branch=$(echo "$payload" | jq -r '.pull_request.head.ref')

# Check if the action is 'closed' and the pull request is not merged
if [ "$action" == "closed" ] && [ "$merged" == "false" ]; then
  # Delete the source branch
  git push origin --delete "$source_branch"
fi
