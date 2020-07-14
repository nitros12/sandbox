#!/usr/bin/env bash
#
# Copyright 2019 Comcast Cable Communications Management, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
#

## Minimal installs.
sudo apt-get update \
  && sudo apt-get install -y \
    build-essential \
    ca-certificates \
    clang \
    curl \
    git \
    kmod \
    libclang-dev \
    libnuma-dev \
    libpcap-dev \
    libssl-dev \
    linux-headers-$(uname -r) \
    llvm-dev \
    pkg-config \
    python-pyelftools \
    python3-setuptools \
    python3-pip \
    wget \
    pocl-opencl-icd \
    ocl-icd-opencl-dev \
    ocl-icd-libopencl1 \
    opencl-headers \
    clinfo \
  && sudo pip3 install --system \
    meson \
    ninja \
    wheel \
  && sudo rm -rf /var/lib/apt/lists /var/cache/apt/archives

mkdir /tmp/neo
pushd /tmp/neo

wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-gmmlib_20.2.2_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-igc-core_1.0.4241_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-igc-opencl_1.0.4241_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-opencl_20.27.17231_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-ocloc_20.27.17231_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/intel-level-zero-gpu_0.8.17231_amd64.deb

wget https://github.com/intel/compute-runtime/releases/download/20.27.17231/ww27.sum
sha256sum -c ww27.sum

sudo dpkg -i *.deb

popd
