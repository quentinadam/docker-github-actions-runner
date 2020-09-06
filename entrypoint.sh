#!/bin/bash

get_runner_token () {
  RUNNER_TOKEN=$(curl -X POST -s \
    -H "Authorization: token ${ACCESS_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/orgs/${ORGANIZATION}/actions/runners/registration-token \
    | jq .token --raw-output)
}

get_runner_token

cd /actions-runner

RUNNER_ALLOW_RUNASROOT=1 ./config.sh --url https://github.com/${ORGANIZATION} --token ${RUNNER_TOKEN} --unattended

cleanup() {
  get_runner_token
  RUNNER_ALLOW_RUNASROOT=1 ./config.sh remove --unattended --token ${RUNNER_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

RUNNER_ALLOW_RUNASROOT=1 ./run.sh & wait $!
