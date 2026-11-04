FROM public.ecr.aws/lambda/python:3.7

###
# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
###
# github@cisa.dhs.gov is a very generic email distribution, and it is
# unlikely that anyone on that distribution is familiar with the
# particulars of your repository.  It is therefore *strongly*
# suggested that you use an email address here that is specific to the
# person or group that maintains this repository; for example:
# LABEL org.opencontainers.image.authors="vm-dev@gwe.cisa.dhs.gov"
LABEL org.opencontainers.image.authors="vm-dev@gwe.cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

# We need to install some basic packages so that the Docker container
# can run the build_sslyze.sh script.
RUN yum -q -y install \
    wget \
    zip

COPY build_sslyze.sh .

ENTRYPOINT ["./build_sslyze.sh"]
