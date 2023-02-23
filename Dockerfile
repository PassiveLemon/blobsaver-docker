FROM fedora:latest

RUN dnf upgrade -y &&\
    dnf install -y curl cronie

COPY entrypoint.sh /blobsaver/

RUN chmod +x /blobsaver/entrypoint.sh

ENV VERSION="" \
    CRON_SCHEDULE="*/5 * * * *"

ENTRYPOINT ["/blobsaver/entrypoint.sh"]
