#!/usr/bin/env bash
# In The Name of God
# ========================================
# [] File Name : build.sh
#
# [] Creation Date : 01-01-2021
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

build() {

  # helm latest
  helm=$(curl -s https://github.com/helm/helm/releases)
  helm=$(echo $helm\" |grep -oP '(?<=tag\/v)[0-9][^"]*'|grep -v \-|sort -Vr|head -1)
  echo $helm

  docker build --no-cache --build-arg OC_VERSION=${tag} --build-arg HELM_VERSION=${helm} \
          --build-arg VCS_REF=${TRAVIS_COMMIT} --build-arg BUILD_DATE="$(date)" -t ${image}:${tag} .

  # run test
  version=$(docker run -ti --rm ${image}:${tag} helm version --client)
  echo $version
  # Client: &version.Version{SemVer:"v2.9.0-rc2", GitCommit:"08db2d0181f4ce394513c32ba1aee7ffc6bc3326", GitTreeState:"clean"}
  if [[ "${version}" == *"Error: unknown flag: --client"* ]]; then
    echo "Detected Helm3+"
    version=$(docker run -ti --rm ${image}:${tag} helm version)
    #version.BuildInfo{Version:"v3.0.0-beta.2", GitCommit:"26c7338408f8db593f93cd7c963ad56f67f662d4", GitTreeState:"clean", GoVersion:"go1.12.9"}
  fi
  version=$(echo ${version}| awk -F \" '{print $2}')
  if [ "${version}" == "v${helm}" ]; then
    echo "matched"
  else
    echo "unmatched"
    exit
  fi

  # run test
  version=$(docker run -ti --rm ${image}:${tag} oc version --client)
  echo $version
  version=$(echo ${version}| awk -F \" '{print $2}')
  if [ "${version}" == "v${helm}" ]; then
    echo "matched"
  else
    echo "unmatched"
    exit
  fi

  if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker push ${image}:${tag}
  fi
}

image="1995parham/ubuntu-okd"

status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tag})
echo $status
if [[ ( "${status}" =~ "not found" ) || ( ${REBUILD} == "true" ) ]]; then
   build
fi
