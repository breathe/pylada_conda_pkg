#!/bin/bash -x

# needed for some tests
brew install tree

# install MacOS 10.9 sdk to /opt/MacOSX10.9.sdk
(
    sudo mkdir -p /opt
    cd /opt
    curl -O https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.9.sdk.tar.xz
    tar -zxvf MacOSX10.9.sdk.tar.xz
    rm MacOSX10.9.sdk.tar.xz
)

