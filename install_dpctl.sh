#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

. ${THEDIR}/0.env.sh

DPCTL_TARGET_VERSION=0.5.0rc2
echo ++++++++++++++++++ Build DPCTL ${DPCTL_TARGET_VERSION} +++++++++++++++++++
git clone --branch ${DPCTL_TARGET_VERSION} https://github.com/IntelPython/dpctl.git 

ls

cd dpctl

# didn't find better way to set required version
git tag -d $(git tag -l)
git tag ${DPCTL_TARGET_VERSION}

conda build conda-recipe/ --no-test -c ${ONEAPI_ROOT}/conda_channel

conda install /usr/share/miniconda/envs/numba-dppy/conda-bld/linux-64/dpctl*