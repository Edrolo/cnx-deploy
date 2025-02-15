#!/bin/bash

set -x
set -e
set -o pipefail

PYTHON_MAJOR_VERSION="$(python -c 'import sys; print(sys.version_info.major)')"
if [[ "${PYTHON_MAJOR_VERSION}" == "2" ]]
then
    out=$(pip install -r environments/__prod_envs/files/archive-requirements.txt 2>&1)
    if echo "$out" | grep -q incompatible
    then
        exit 1
    fi
    pip uninstall -y -r environments/__prod_envs/files/archive-requirements.txt
    out=$(pip install -r environments/__prod_envs/files/publishing-requirements.txt 2>&1)
    if echo "$out" | grep -q incompatible
    then
        exit 1
    fi
elif [[ "${PYTHON_MAJOR_VERSION}" == "3" ]]
then
    out=$(pip install -r environments/__prod_envs/files/press-requirements.txt 2>&1)
    if echo "$out" | grep -q incompatible
    then
        exit 1
    fi
fi
