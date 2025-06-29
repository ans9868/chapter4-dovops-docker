#!/bin/bash

# crash if any line doens't return 0 ie doesn't execute correctly
set -e

# if there wasn't 2 user inputs then display this message
if [ $# -ne 2 ]; then
  echo "Usage: $0 <github-repo> <dockerhub-repo>"
  echo "Example: $0 ans9868/chapter4-dovops-docker nour333/chapter4-express-app"
  exit 1
fi

GITHUB_REPO=$1
DOCKERHUB_REPO=$2

#attemting to login to docker if possible
echo "Attempting Docker login..."
if echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" -- password-stdin; then
  echo "Docker login succeeded."
else
  echo "Docker login failed. Continuing without login..."
fi

# clone the github and go in the folder so we can build it
git clone https://github.com/$GITHUB_REPO temp-repo
cd temp-repo

#build the docker image which we can then push
docker build -t $DOCKERHUB_REPO .

#now we can clone the repo
docker push $DOCKERHUB_REPO

#finally clean up cloned repo
cd ..
rm -rf temp-repo

echo "Successfully built and pushed $DOCKERHUB_REPO"
