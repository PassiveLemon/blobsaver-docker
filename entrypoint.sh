#!/usr/bin/env bash

mkdir /blobsaver/
cd /blobsaver/
curl -L --output /blobsaver/blobsaver-${VERSION}-1.x86_64.rpm https://github.com/airsquared/blobsaver/releases/latest/download/blobsaver-${VERSION}-1.x86_64.rpm
dnf install -y ./blobsaver-${VERSION}-1.x86_64.rpm

bash