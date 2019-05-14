#!/bin/bash

SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    # Compile with C++11 not C++17 standard
    export CPPFLAGS="${CPPFLAGS//-std=c++17/-std=c++11}"
    export CXXFLAGS="${CXXFLAGS//-std=c++17/-std=c++11}"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    # export CXXFLAGS=-std=c++11
    # export CXXFLAGS="-stdlib=libstdc++ -isysroot ${CONDA_BUILD_SYSROOT}"
    # export CXXFLAGS="-stdlib=libstdc++"
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++ -lc++"
    export LDFLAGS="-headerpad_max_install_names -undefined dynamic_lookup -bundle -Wl,-search_paths_first -lc++"
    export CMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}
fi


export EIGEN3_INCLUDE_DIR=$CONDA_PREFIX/include/eigen3

echo `ls /opt/*`
echo "mpirun version" `mpirun --version : Open MPI 3.1.0`

# test mpiexec functionality
mpiexec -n 5 python -m mpi4py.bench helloworld

mkdir build
cd build

cmake \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DCOOKOFF_GITREPO="https://github.com/breathe/GreatCMakeCookOff.git" \
..

make VERBOSE=1
ctest -V
make install


# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.





