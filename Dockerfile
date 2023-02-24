FROM fedora:latest

RUN dnf upgrade -y &&\
    dnf install -y curl cronie

COPY entrypoint.sh /blobsaver/

RUN chmod +x /blobsaver/entrypoint.sh

ENV VERSION="3.5.0"
ENV CRONTIME="*/5 * * * *"
ENV BLOBARG="--include-betas --background-autosave"

ENTRYPOINT ["/blobsaver/entrypoint.sh"]
