# github-runner-dockerfile
Dockerfile for the creation of a GitHub Actions runner image to be deployed dynamically.

When running the docker image, or when executing docker compose, environment variables for repo-owner/repo-name and github-token must be included. 


Credit to testdriven.io for the original start.sh script, which I slightly modified to make it work with a regular repository rather than with an enterprise. 

(https://testdriven.io/blog/github-actions-docker/)


