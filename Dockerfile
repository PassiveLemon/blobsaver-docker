FROM docker.io/frolvlad/alpine-glibc:latest
# VERSION comes from the main.yml workflow --build-arg
ARG VERSION

RUN apk add --no-cache curl tar busybox-openrc

RUN mkdir -p /blobsaver/source/

RUN curl -Lo /blobsaver/source/blobsaver.tar.gz https://github.com/airsquared/blobsaver/releases/download/v${VERSION}/blobsaver-${VERSION}.tar.gz
WORKDIR /blobsaver/source/
RUN tar -xzvf blobsaver.tar.gz &&\
    rm blobsaver.tar.gz

COPY entrypoint.sh /blobsaver/

RUN chmod +x /blobsaver/entrypoint.sh

ENV STARTTRIGGER="1"
ENV CRONTIME="*/5 * * * *"
ENV BLOBARG="--include-betas --background-autosave"

ENTRYPOINT ["/blobsaver/entrypoint.sh"]
