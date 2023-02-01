FROM public.ecr.aws/lambda/python:3.7
MAINTAINER Shane Frasier <jeremy.frasier@trio.dhs.gov>

# We need to install some basic packages so that the Docker container
# can run the build_pshtt.sh script.
RUN yum -q -y install \
    wget \
    zip

COPY build_pshtt.sh .

ENTRYPOINT ["./build_pshtt.sh"]
