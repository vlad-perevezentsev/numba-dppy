#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

echo ++++++++++++++++++ Build NUMBA +++++++++++++++++++
git clone https://github.com/IntelPython/numba.git

cd numba

python setup.py develop