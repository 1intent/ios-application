#!/bin/sh

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e

(cd $CI_PRIMARY_REPOSITORY_PATH && agvtool new-marketing-version "$CI_TAG") 