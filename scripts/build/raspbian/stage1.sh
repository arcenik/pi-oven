#!/bin/bash

set -e
cd $(dirname $0)/../../..

echo XXXXXXXXXX stage1 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
docker image build \
        -t raspbian:stage1 \
        -f docker/raspbian/stage1/Dockerfile $@ docker/raspbian/stage1
