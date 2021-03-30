#!/bin/bash

THEDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

. ${THEDIR}/0.env.sh

conda install numpy cython cmake dpctl numba=0.52 llvmdev llvmlite recommonmark sphinx sphinx_rtd_theme wheel -c /opt/intel/oneapi/conda_channel