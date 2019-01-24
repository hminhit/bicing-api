#!/usr/bin/env bash

# Env needed
#gitlab token
#team
#project
#branch

BADGE_BUILD_URL="https://gitlab.com/"${CI_PROJECT_PATH}"/badges/"${CI_MERGE_REQUEST_SOURCE_BRANCH_NAME}"/build.svg"
echo ${BADGE_BUILD_URL}
BADGE_BUILD=$(curl -s  -X GET "${BADGE_BUILD_URL}" | base64)

PAYLOAD=$(cat << JSON
{
  "branch": "master",
  "commit_message": "New bicing-statistics-api badges",
  "actions": [
    {
      "action": "update",
      "file_path": "bicing-statistics-api/build.svg",
      "encoding": "base64",
      "content": "${BADGE_BUILD}"
    }
  ]
}
JSON
)

curl --request POST \
    --header "PRIVATE-TOKEN: ${BADGE_REPOSITORY_PRIVATE_TOKEN}" \
    --header "Content-Type: application/json" \
    --data "$PAYLOAD" https://gitlab.com/api/v4/projects/10513975/repository/commits
