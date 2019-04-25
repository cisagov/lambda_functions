#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

aws s3 cp pshtt_complete.zip s3://ncats-bod-18-01-lambdas-us-east-1
aws s3 cp sslyze_complete.zip s3://ncats-bod-18-01-lambdas-us-east-1
aws s3 cp trustymail_complete.zip s3://ncats-bod-18-01-lambdas-us-east-1

aws s3 cp s3://ncats-bod-18-01-lambdas-us-east-1 s3://ncats-bod-18-01-lambdas-us-east-2 --recursive
aws s3 cp s3://ncats-bod-18-01-lambdas-us-east-1 s3://ncats-bod-18-01-lambdas-us-west-1 --recursive
aws s3 cp s3://ncats-bod-18-01-lambdas-us-east-1 s3://ncats-bod-18-01-lambdas-us-west-2 --recursive
