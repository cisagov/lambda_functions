FROM public.ecr.aws/lambda/python:3.7

###
# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
###
LABEL org.opencontainers.image.authors="vm-dev@gwe.cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

# We need to install some basic packages so that the Docker container
# can run the build_sslyze.sh script.
RUN yum --assumeyes --quiet install \
    wget \
    zip

COPY build_sslyze.sh .

ENTRYPOINT ["./build_sslyze.sh"]
