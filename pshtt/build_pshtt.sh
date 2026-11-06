#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

###
# Set up the Python virtual environment
###
VENV_DIR=/venv
python3 -m venv $VENV_DIR
# Note that we have to turn off nounset before running activate, since
# otherwise we can get an error that states "/venv/bin/activate: line
# 6: _OLD_VIRTUAL_PATH: unbound variable".  See
# cisagov/lambda_functions#29 for more details.
set +o nounset
# Note also that shellcheck complains because it can't follow the
# dynamic path.  The path doesn't even exist until runtime, so we must
# disable that check.
#
# shellcheck disable=1090
source $VENV_DIR/bin/activate
set -o nounset

###
# Update pip, setuptools, and wheel
###
pip3 install --upgrade pip setuptools wheel

##
# Install pshtt
##
pip3 install --upgrade pshtt==0.7.6

###
# Install domain-scan
###
[ -d domain-scan ] || mkdir domain-scan
wget --quiet --output-document - https://api.github.com/repos/cisagov/domain-scan/tarball | tar --extract --gzip --strip-components=1 --directory domain-scan
pip3 install --upgrade --requirement domain-scan/lambda/requirements-lambda.txt

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
mkdir --parents $BUILD_DIR/bin
mkdir --parents $BUILD_DIR/cache

###
# Copy all packages, including any hidden dotfiles.  Also copy the
# pshtt executable.
###
cp --recursive --no-target-directory $VENV_DIR/lib/python3.10/site-packages/ $BUILD_DIR
cp --recursive --no-target-directory $VENV_DIR/lib64/python3.10/site-packages/ $BUILD_DIR
cp $VENV_DIR/bin/pshtt $BUILD_DIR/bin

###
# Copy in a snapshot of the public suffix list in text form
###
wget --quiet --output-document $BUILD_DIR/cache/public-suffix-list.txt \
     https://publicsuffix.org/list/public_suffix_list.dat

###
# Zip it all up
###
OUTPUT_DIR=/output
if [ ! -d $OUTPUT_DIR ]
then
    mkdir $OUTPUT_DIR
fi

if [ -e $OUTPUT_DIR/pshtt.zip ]
then
    rm $OUTPUT_DIR/pshtt.zip
fi
cd $BUILD_DIR
zip --quiet --recurse-paths -9 $OUTPUT_DIR/pshtt.zip .

# Copy in the Lambda handler file, the utils directory, and the
# scanner file itself, then zip it all up again
cp --recursive /var/task/domain-scan/lambda/lambda_handler.py \
   /var/task/domain-scan/utils \
   $BUILD_DIR
mkdir $BUILD_DIR/scanners
cp /var/task/domain-scan/scanners/pshtt.py $BUILD_DIR/scanners

if [ -e $OUTPUT_DIR/pshtt_complete.zip ]
then
    rm $OUTPUT_DIR/pshtt_complete.zip
fi
cd $BUILD_DIR
zip --quiet --recurse-paths -9 $OUTPUT_DIR/pshtt_complete.zip .
