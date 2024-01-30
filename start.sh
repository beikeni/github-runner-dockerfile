#!/bin/bash

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN
ORG=$ORG
echo "REPO ${REPOSITORY}"
echo "ACCESS_TOKEN ${ACCESS_TOKEN}"

####RE
REG_TOKEN=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${ACCESS_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/satu-com-ge/actions/runners/registration-token | jq .token --raw-output)

shutdown_signal_handler() {
    echo "Received shutdown signal. Waiting 30 seconds before cleanup..."
    sleep 20
    echo "Executing cleanup.sh"
    ./cleanup.sh
    exit 0
}

# Trap the shutdown signal and call the handler function
trap 'shutdown_signal_handler' SIGTERM



cd /home/docker/actions-runner

#./config.sh --url https://github.com/${ORG} --token ${REG_TOKEN}
./config.sh --url https://github.com/satu-com-ge --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
