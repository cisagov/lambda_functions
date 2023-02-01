FROM public.ecr.aws/lambda/python:3.7
MAINTAINER Shane Frasier <jeremy.frasier@trio.dhs.gov>

# We need wget to download the public suffix list
RUN yum -q -y install wget

COPY build_sslyze.sh .

ENTRYPOINT ["./build_sslyze.sh"]
