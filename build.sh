#!/bin/bash

SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    # Compile with C++11 not C++17 standard
    export CPPFLAGS="${CPPFLAGS//-std=c++17/-std=c++11}"
    export CXXFLAGS="${CXXFLAGS//-std=c++17/-std=c++11}"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    export MACOSX_DEPLOYMENT_TARGET=10.14
    export CXXFLAGS=-std=c++11
fi


export EIGEN3_INCLUDE_DIR=$CONDA_PREFIX/include/eigen3

# pip install pytest-bdd quantities f90nml

mkdir build
cd build

cmake \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DEIGEN3_INCLUDE_DIR=$CONDA_PREFIX/include/eigen3 \
..

make VERBOSE=1
ctest -V
make install


# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.


