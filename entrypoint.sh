#!/bin/sh
echo "Blobsaver version: $VERSION"

export BLOBSAVER_CLI_ONLY
if [ "$STARTTRIGGER" = "1" ]; then
  echo "|| Manually saving blobs once. ||"
  blobsaver --import=/opt/blobsaver/blobs/blobsaver.xml --save-path=/opt/blobsaver/blobs ${BLOBARG}
fi
echo "|| Done. Continuing with cronjob. ||"
(crontab -l 2>/dev/null; echo "${CRONTIME} blobsaver --import=/opt/blobsaver/blobs/blobsaver.xml --save-path=/opt/blobsaver/blobs ${BLOBARG}") | crontab -
crond -f
