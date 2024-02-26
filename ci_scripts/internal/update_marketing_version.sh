#!/bin/sh

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e

(cd $CI_WORKSPACE_PATH && agvtool new-marketing-version "$CI_TAG") 