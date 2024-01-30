#!bin/bash

REPO=$ORG
TOKEN=$TOKEN

RUNNER_LIST=$(curl -H "Authorization: Bearer ${TOKEN}" -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/${REPO}/actions/runners | jq '[.runners[] | select(.status | contains("offline")) | {id: .id}]')

for id in $(echo "$RUNNER_LIST" | jq -r '.[] | @base64'); do
        _jq() {
                echo ${id} | base64 --decode | jq -r ${1}
        }
        echo $(_jq '.id')
        curl -X DELETE -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/orgs/${REPO}/actions/runners/$(_jq '.id')
done
