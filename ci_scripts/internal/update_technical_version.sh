#!/bin/bash

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e

TECH_VERSION=`/bin/date "+%y%j%H%M"`
/usr/libexec/PlistBuddy -c "set CFBundleVersion $TECH_VERSION" OpenActions/Info.plist