FROM fedora:latest

RUN dnf upgrade -y &&\
    dnf install -y curl cronie

COPY entrypoint.sh /blobsaver/

RUN chmod +x /blobsaver/entrypoint.sh

ENV VERSION=""

ENTRYPOINT ["/blobsaver/entrypoint.sh"]
