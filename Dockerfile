FROM docker.io/frolvlad/alpine-glibc:latest
# VERSION comes from the main.yml workflow --build-arg
ARG VERSION

RUN apk add --no-cache curl tar busybox-openrc

RUN mkdir -p /opt/blobsaver/source/ &&\
    mkdir -p /usr/local/bin/

COPY entrypoint.sh /opt/blobsaver/

RUN chmod -R 755 /opt/blobsaver/ &&\
    chmod +x /opt/blobsaver/entrypoint.sh

WORKDIR /opt/blobsaver/source/

RUN curl -Lo ./blobsaver.tgz https://github.com/airsquared/blobsaver/releases/download/v${VERSION}/blobsaver-${VERSION}.tgz

RUN tar -xzvf ./blobsaver.tgz &&\
    ln -s /opt/blobsaver/source/blobsaver/bin/blobsaver /usr/local/bin/blobsaver &&\
    rm ./blobsaver.tgz

RUN chmod +x /opt/blobsaver/source/blobsaver/bin/blobsaver

WORKDIR /opt/blobsaver/source/blobsaver/bin/

ENV VERSION=$VERSION

ENV STARTTRIGGER="1"
ENV CRONTIME="*/5 * * * *"
ENV BLOBARG="--background-autosave"

ENTRYPOINT ["/opt/blobsaver/entrypoint.sh"]
