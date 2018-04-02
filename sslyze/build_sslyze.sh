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

###
# Install sslyze
###
pip install --upgrade "sslyze>=1.3.4,<1.4.0"

###
# Install domain-scan
###
git clone --branch improvement/psl_now_stored_in_same_cache_location_in_lambda_and_local https://github.com/18F/domain-scan
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
