#!/bin/sh

export BLOBSAVER_CLI_ONLY
if [ "$STARTTRIGGER" = "1" ]; then
  echo "|| Manually saving blobs once. ||"
  /blobsaver/source/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}
fi
echo "|| Done. Continuing with cronjob. ||"
(crontab -l 2>/dev/null; echo "${CRONTIME} /blobsaver/source/blobsaver/bin/blobsaver --import=/blobsaver/blobs/blobsaver.xml --save-path=/blobsaver/blobs ${BLOBARG}") | crontab -
crond -f
