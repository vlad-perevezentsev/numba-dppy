#!/bin/bash

# THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

# . ${THEDIR}/0.env.sh

# DPCTL_TARGET_VERSION=0.6.1
# echo ++++++++++++++++++ Build DPCTL ${DPCTL_TARGET_VERSION} +++++++++++++++++++
# git clone https://github.com/IntelPython/dpctl.git 

# cd dpctl

# git checkout ${DPCTL_TARGET_VERSION}

# python setup.py develop

#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

DPCTL_TARGET_VERSION=0.5.0rc2
echo ++++++++++++++++++ Build DPCTL ${DPCTL_TARGET_VERSION} +++++++++++++++++++
git clone --branch ${DPCTL_TARGET_VERSION} https://github.com/IntelPython/dpctl.git 

cd dpctl

# didn't find better way to set required version
git tag -d $(git tag -l)
git tag ${DPCTL_TARGET_VERSION}

# python ./setup.py develop
# python ./setup.py install

conda build conda-recipe/ --no-test -c ${ONEAPI_ROOT}/conda_channel

# ls -lR /opt/intel/oneapi/intelpython/latest/conda-bld

conda install /opt/intel/oneapi/intelpython/latest/conda-bld/linux-64/dpctl*