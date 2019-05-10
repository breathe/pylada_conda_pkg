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


# ensure appropriate linker flags for python environment
# export PYTHON_LDFLAGS=-undefined dynamic_lookup
# PYTHON_LDFLAGS=`python -c "import sysconfig; print(sysconfig.get_config_var('LDSHARED').split(' ',1)[1])"`
# export PYTHON_LDFLAGS=`python3-config --ldflags`

# export CXXFLAGS="${CXXFLAGS} ${PYTHON_LDFLAGS}"

echo "CXXFLAGS" ${CXXFLAGS}
# export CFLAGS="${CFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}"
# export CXXFLAGS="${CXXFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}"

# \DIRTY= EIGEN3_INCLUDE_DIR=$PREFIX/include/eigen3 PIP_NO_INDEX=True CPU_COUNT=8 pin_run_as_build=OrderedDict([('python', {'min_pin': 'x.x', 'max_pin': 'x.x'}), ('r-base', {'min_pin': 'x.x.x', 'max_pin': 'x.x.x'})]) CONDA_PERL=5.26 PYTHONNOUSERSITE=1 GIT_DESCRIBE_NUMBER=124 CONDA_SHLVL=2 c_compiler=clang CONDA_PROMPT_MODIFIER=($PREFIX) PIP_CACHE_DIR=/Users/ncohen/anaconda3/envs/conda-build-env/conda-bld/pylada_1557423820890/pip_cache ignore_build_only_deps={'python', 'numpy'} GIT_FULL_HASH=edc22942551ecd2a3612874114322e90f0b9643b PERL_VER=5.26 CMAKE_GENERATOR=Unix Makefiles GIT_DESCRIBE_HASH=gedc2294 PY_VER=3.6 CONDA_STACKED_2=true CONDA_EXE=/Users/ncohen/anaconda3/envs/conda-build-env/bin/conda cran_mirror=https://cran.r-project.org REQUESTS_CA_BUNDLE= NPY_VER=1.11 CONDA_BUILD_STATE=BUILD CONDA_R=3.5 PIP_NO_BUILD_ISOLATION=False CXXFLAGS=-std=c++11 PKG_BUILDNUM=124 GIT_DESCRIBE_TAG=v1.0 _CE_CONDA= CONDA_PREFIX_1=/Users/ncohen/anaconda3/envs/conda-build-env CONDA_BUILD=1 PATH=$PREFIX/bin:/Users/ncohen/anaconda3/envs/conda-build-env/bin:/Users/ncohen/anaconda3/envs/conda-build-env/condabin:$PREFIX:$PREFIX/bin:$PREFIX:$PREFIX/bin:/Users/ncohen/anaconda3/envs/conda-build-env/bin:/Users/ncohen/anaconda3/condabin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:.:/Applications/VMware Fusion.app/Contents/Public:/Library/TeX/texbin:node_modules/.bin fortran_compiler=gfortran SRC_DIR=$SRC_DIR CONDA_PREFIX=$PREFIX BUILD=x86_64-apple-darwin13.4.0 PWD=$SRC_DIR cpu_optimization_target=nocona target_platform=osx-64 PKG_VERSION=1.0 PY3K=1 LANG=en_US.UTF-8 LUA_VER=5 STDLIB_DIR=$PREFIX/lib/python3.6 PIP_NO_DEPENDENCIES=True CONDA_PY=36 SHLIB_EXT=.dylib extend_keys={'extend_keys', 'ignore_build_only_deps', 'ignore_version', 'pin_run_as_build'} ROOT=/Users/ncohen/anaconda3/envs/conda-build-env HTTPS_PROXY= _CE_M= BUILD_PREFIX=$PREFIX SHLVL=1 OSX_ARCH=x86_64 HOME=/Users/ncohen PKG_BUILD_STRING=placeholder PIP_IGNORE_INSTALLED=True cxx_compiler=clangxx SP_DIR=$PREFIX/lib/python3.6/site-packages HTTP_PROXY= r_base=3.5 SYS_PREFIX=/Users/ncohen/anaconda3/envs/conda-build-env MACOSX_DEPLOYMENT_TARGET=10.9 CONDA_NPY=111 SUBDIR=osx-64 R_VER=3.5 NPY_DISTUTILS_APPEND_FLAGS=1 PREFIX=$PREFIX RECIPE_DIR=/Users/ncohen/software/pylada-conda CONDA_LUA=5 PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig CONDA_DEFAULT_ENV=$PREFIX ARCH=64 GIT_BUILD_STR=124_gedc2294 PKG_NAME=pylada SYS_PYTHON=/Users/ncohen/anaconda3/envs/conda-build-env/bin/python PKG_HASH=1234567 PYTHON=$PREFIX/bin/python _=/usr/bin/env

# export PIP_NO_INDEX=False
# pip install -vvv -i https://pypi.org/simple quantities f90nml pytest_bdd
# export PIP_NO_INDEX=True

mkdir build
cd build

cmake \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DCOOKOFF_GITREPO="https://github.com/breathe/GreatCMakeCookOff.git" \
..

# (
#     cd external/src
#     rm -rf GreatCMakeCookOff
#     git clone https://github.com/breathe/GreatCMakeCookOff.git
# )

# # re-run the cmake step using patched PythonModule ...
# cmake \
# -DCMAKE_INSTALL_PREFIX=$PREFIX \
# ..


make VERBOSE=1
ctest -V
make install


# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.





