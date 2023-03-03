#!/bin/sh

mkdir -p /blobsaver/
cd /blobsaver/
if [ ! -e /opt/blobsaver/bin/blobsaver ]; then
  curl -L --output /blobsaver/blobsaver-${VERSION}-1.x86_64.rpm https://github.com/airsquared/blobsaver/releases/latest/download/blobsaver-${VERSION}-1.x86_64.rpm
  dnf install -y /blobsaver/blobsaver-${VERSION}-1.x86_64.rpm
  rm /blobsaver/blobsaver-${VERSION}-1.x86_64.rpm
fi

export BLOBSAVER_CLI_ONLY
echo "|| Manually saving blobs once. ||"
/opt/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}
echo "|| Done. Continuing with cronjob. ||"
(crontab -l 2>/dev/null; echo "${CRONTIME} /opt/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}") | crontab -
crond -f