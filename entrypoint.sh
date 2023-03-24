#!/bin/sh

mkdir -p /blobsaver/
cd /blobsaver/
if [ ! -e /blobsaver/bin/blobsaver ]; then
  curl -L --output /blobsaver/blobsaver-${VERSION}.tar.gz https://github.com/airsquared/blobsaver/releases/latest/download/blobsaver-${VERSION}.tar.gz
  tar -xvzf blobsaver-${VERSION}.tar.gz
  rm /blobsaver/blobsaver-${VERSION}.tar.gz
fi

export BLOBSAVER_CLI_ONLY
echo "|| Manually saving blobs once. ||"
/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}
echo "|| Done. Continuing with cronjob. ||"
(crontab -l 2>/dev/null; echo "${CRONTIME} /blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}") | crontab -
crond -f