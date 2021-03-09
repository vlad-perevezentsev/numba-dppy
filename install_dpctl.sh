#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

DPCTL_TARGET_VERSION=0.6.1
echo ++++++++++++++++++ Build DPCTL ${DPCTL_TARGET_VERSION} +++++++++++++++++++
git clone https://github.com/IntelPython/dpctl.git 

cd dpctl

git checkout ${DPCTL_TARGET_VERSION}

python setup.py develop
