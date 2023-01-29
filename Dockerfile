FROM fedora:latest

RUN dnf upgrade -y &&\
    dnf install -y curl cronie

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENV VERSION=""

ENTRYPOINT ["/entrypoint.sh"]
