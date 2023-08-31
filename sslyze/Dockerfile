FROM public.ecr.aws/lambda/python:3.7
MAINTAINER Shane Frasier <jeremy.frasier@gwe.cisa.dhs.gov>

# We need to install some basic packages so that the Docker container
# can run the build_sslyze.sh script.
RUN yum -q -y install \
    wget \
    zip

COPY build_sslyze.sh .

ENTRYPOINT ["./build_sslyze.sh"]
