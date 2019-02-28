# lambda_functions :cloud: :penguin: #

[![Build Status](https://travis-ci.org/cisagov/lambda_functions.svg?branch=master)](https://travis-ci.org/cisagov/lambda_functions)

`lambda_functions` is a tool for building environment zip files for
scan types to be run in [AWS Lambda](https://aws.amazon.com/lambda/)
via 18F's [`domain-scan`](https://github.com/18F/domain-scan).

## Examples ##

### All scanners ###

Building the environment zip files for all scanners and deploying them
to AWS Lambda using `domain-scan`:
1. `cd ~/cisagov/lambda_functions`
2. `docker-compose build`
3. `docker-compose up`
4. `cp *.zip ~/18F/domain-scan/lambda/envs/`
5. `cd ~/18F/domain-scan`
6. `./lambda/deploy pshtt --create`
7. `./lambda/deploy sslyze --create`
8. `./lambda/deploy trustymail --create`

### One scanner ###

Building the `pshtt` environment zip file and deploying it to AWS
Lambda using `domain-scan`:
1. `cd ~/cisagov/lambda_functions`
2. `docker-compose build build_pshtt`
3. `docker-compose up build_pshtt`
4. `cp pshtt.zip ~/18F/domain-scan/lambda/envs/`
5. `cd ~/18F/domain-scan`
6. `./lambda/deploy pshtt --create`

## Note ##

Please note that the corresponding Docker image _must_ be rebuilt
locally if the script `<scanner>/build_<scanner>.sh` changes.  Given
that rebuilding the Docker image is very fast (due to Docker's
caching) if the script has not changed, it is a very good idea to
_always_ run the `docker-compose build` step when using this tool.

## License ##

This project is in the worldwide [public domain](LICENSE.md).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
