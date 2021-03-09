#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

DPCTL_TARGET_VERSION=0.52.0
echo ++++++++++++++++++ Build NUMBA ${DPCTL_TARGET_VERSION} +++++++++++++++++++
git clone https://github.com/IntelPython/numba.git

cd numba

git checkout ${DPCTL_TARGET_VERSION}

python setup.py develop