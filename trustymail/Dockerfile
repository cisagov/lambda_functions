FROM public.ecr.aws/lambda/python:3.14

###
# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
###
LABEL org.opencontainers.image.authors="vm-dev@gwe.cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

# We need to install some basic packages so that the Docker container
# can run the build_trustymail.sh script.
RUN dnf --assumeyes install \
    gzip \
    tar \
    wget \
    zip

COPY build_trustymail.sh .

ENTRYPOINT ["./build_trustymail.sh"]
