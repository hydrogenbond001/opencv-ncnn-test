#!/usr/bin/env bash
mkdir -p build
pushd build
cmake -DCMAKE_INSTALL_PREFIX=../install ..
make -j4
make install
popd