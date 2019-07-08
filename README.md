# Conda package wrapping pylada-light project

To use -- with current working directory containing meta.yaml:

1. `conda create -n conda-build-env python=3.6 conda-build anaconda-client conda-verify`
2. `conda activate conda-build-env`
3. `conda-build . -c conda-forge`

## Build Environment setup requirements (macOS)

Ensure tree command is present in path and install the [macOS 10.9 sdk](https://github.com/phracker/MacOSX-SDKs/releases).

(you can use this script but check what it does first to confirm you are happy with the modifications it will perform)
bash -x macos_ci_setup.sh

## Build Environment setup requirements (linux)

Ensure `tree` command is installed in PATH.
