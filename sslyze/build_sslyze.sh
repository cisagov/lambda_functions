#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

###
# Set up the Python virtual environment
###
VENV_DIR=/venv
python -m venv $VENV_DIR
# Here shellcheck complains because it can't follow the dynamic path.
# The path doesn't even exist until runtime, so we must disable that
# check.
# shellcheck disable=1090
source $VENV_DIR/bin/activate

###
# Update pip and setuptools
###
pip install --upgrade pip setuptools

###
# Install sslyze
###
pip install --upgrade sslyze==2.0.1

###
# Install domain-scan
###
mkdir domain-scan
wget -q -O - https://api.github.com/repos/18F/domain-scan/tarball | tar xz --strip-components=1 -C domain-scan
pip install --upgrade -r domain-scan/lambda/requirements-lambda.txt

###
# Leave the Python virtual environment
#
# Note that we have to turn off nounset before running deactivate,
# since otherwise we get an error that states "/venv/bin/activate:
# line 31: $1: unbound variable".
###
set +o nounset
deactivate
set -o nounset

###
# Set up the build directory
###
BUILD_DIR=/build
mkdir -p $BUILD_DIR/bin

###
# Copy all packages, including any hidden dotfiles.  Also copy the
# sslyze executable.
###
cp -rT $VENV_DIR/lib/python3.6/site-packages/ $BUILD_DIR
cp -rT $VENV_DIR/lib64/python3.6/site-packages/ $BUILD_DIR
cp $VENV_DIR/bin/sslyze $BUILD_DIR/bin

###
# Zip it all up
###
OUTPUT_DIR=/output
if [ ! -d $OUTPUT_DIR ]
then
    mkdir $OUTPUT_DIR
fi

if [ -e $OUTPUT_DIR/sslyze.zip ]
then
    rm $OUTPUT_DIR/sslyze.zip
fi
cd $BUILD_DIR
zip -rq9 $OUTPUT_DIR/sslyze.zip .

# Copy in the Lambda handler file, the utils directory, and the
# scanner file itself, then zip it all up again
cp -r /var/task/domain-scan/lambda/lambda_handler.py \
   /var/task/domain-scan/utils \
   $BUILD_DIR
mkdir $BUILD_DIR/scanners
cp /var/task/domain-scan/scanners/sslyze.py $BUILD_DIR/scanners

if [ -e $OUTPUT_DIR/sslyze_complete.zip ]
then
    rm $OUTPUT_DIR/sslyze_complete.zip
fi
cd $BUILD_DIR
zip -rq9 $OUTPUT_DIR/sslyze_complete.zip .
