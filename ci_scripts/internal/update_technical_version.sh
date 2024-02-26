#!/bin/bash

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e

TECH_VERSION=`/bin/date "+%y%j%H%M"`
(cd $CI_PRIMARY_REPOSITORY_PATH && agvtool new-version -all $TECH_VERSION) 