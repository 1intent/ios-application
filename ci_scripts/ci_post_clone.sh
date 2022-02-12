#!/bin/sh

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e

if [[ $CI_WORKFLOW == "delivery_internal" ]];
then
    ./internal/update_technical_version.sh
fi

if [[ $CI_WORKFLOW == "delivery_internal" &&  -n $CI_TAG ]];
then
    ./internal/update_marketing_version.sh
fi