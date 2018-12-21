#!/bin/bash

###
# Set up the Python virtual environment
###
VENV_DIR=/venv
python -m venv $VENV_DIR
source $VENV_DIR/bin/activate

###
# Update pip and setuptools
###
pip install --upgrade pip setuptools

##
# Install pshtt
##
pip install --upgrade pshtt==0.5.2

###
# Install domain-scan
###
mkdir domain-scan
wget -q -O - https://api.github.com/repos/18F/domain-scan/tarball | tar xz --strip-components=1 -C domain-scan
pip install --upgrade -r domain-scan/lambda/requirements-lambda.txt

###
# Leave the Python virtual environment
###
deactivate

###
# Set up the build directory
###
BUILD_DIR=/build
mkdir -p $BUILD_DIR/bin
mkdir -p $BUILD_DIR/cache

###
# Copy all packages, including any hidden dotfiles.  Also copy the
# pshtt executable.
###
cp -rT $VENV_DIR/lib/python3.6/site-packages/ $BUILD_DIR
cp -rT $VENV_DIR/lib64/python3.6/site-packages/ $BUILD_DIR
cp $VENV_DIR/bin/pshtt $BUILD_DIR/bin

###
# Copy in a snapshot of the public suffix list in text form
###
wget -q -O $BUILD_DIR/cache/public-suffix-list.txt \
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
zip -rq9 $OUTPUT_DIR/pshtt.zip .

# Pull in the Lambda handler file, then zip it all up again under a
# different name
wget -q -O $BUILD_DIR/lambda_handler.py \
     https://raw.githubusercontent.com/18F/domain-scan/master/lambda/lambda_handler.py

if [ -e $OUTPUT_DIR/pshtt_complete.zip ]
then
    rm $OUTPUT_DIR/pshtt_complete.zip
fi
cd $BUILD_DIR
zip -rq9 $OUTPUT_DIR/pshtt_complete.zip .
