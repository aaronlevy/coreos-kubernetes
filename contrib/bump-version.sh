#!/bin/bash
#
# This script will go through each of the tracked files in this repo and update
# the CURRENT_VERSION to the TARGET_VERSION. This is meant as a helper - but
# probably should still double-check the changes are correct

CURRENT_VERSION="v1.2.4_coreos.1"
TARGET_VERSION="v1.3.0-alpha.5_coreos.0"

GIT_ROOT=$(git rev-parse --show-toplevel)
SED_CMD="sed -i"
[ "$(uname -s)" == "Darwin" ] && {
    SED_CMD='sed -i ""'
}

cd $GIT_ROOT
TRACKED=($(git grep -F "${CURRENT_VERSION}"| awk -F : '{print $1}' | sort -u))
for i in "${TRACKED[@]}"; do
    echo Updating $i
    ${SED_CMD} s/${CURRENT_VERSION}/${TARGET_VERSION}/g $i
done
