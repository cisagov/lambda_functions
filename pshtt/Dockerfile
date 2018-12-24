FROM lambci/lambda:build-python3.6
MAINTAINER Shane Frasier <jeremy.frasier@trio.dhs.gov>

# We need wget to download the public suffix list
RUN yum -q -y install wget

COPY build_pshtt.sh .

ENTRYPOINT ["./build_pshtt.sh"]
