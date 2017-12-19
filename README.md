# lambda_functions :cloud: :penguin: #

`lambda_functions` is a tool for building environment zip files for
scan types to be run in [AWS Lambda](https://aws.amazon.com/lambda/)
via 18F's [`domain-scan`](https://github.com/18F/domain-scan).

## Example ##

Building the `pshtt` environment zip file and deploying it to AWS
Lambda using `domain-scan`:
1. `cd ~/dhs-ncats/lambda_functions`
2. `docker-compose up build_pshtt`
3. `cp pshtt.zip ~/18F/domain-scan/lambda/envs/`
4. `cd ~/18F/domain-scan`
5. `./lambda/deploy pshtt --create`

## License ##

This project is in the worldwide [public domain](LICENSE.md).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
