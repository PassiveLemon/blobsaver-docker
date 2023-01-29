#!/usr/bin/env bash

mkdir -p /blobsaver/
cd /blobsaver/
if [ ! -e /opt/blobsaver/bin/blobsaver ]; then
  curl -L --output ./blobsaver-${VERSION}-1.x86_64.rpm https://github.com/airsquared/blobsaver/releases/latest/download/blobsaver-${VERSION}-1.x86_64.rpm
  dnf install -y ./blobsaver-${VERSION}-1.x86_64.rpm
  rm ./blobsaver-${VERSION}-1.x86_64.rpm
fi

export BLOBSAVER_CLI_ONLY
(crontab -l 2>/dev/null; echo "*/5 * * * * /opt/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs --include-betas --background-autosave") | crontab -
crond -f
echo "done"