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

# -*- mode: ruby -*-

VAGRANTFILE_API_VERSION = "2"

# Default Vagrant vars.
$devbind_img = "getcapsule/dpdk-devbind:19.11.1"
$dpdkmod_img = "getcapsule/dpdk-mod:19.11.1-`uname -r`"
$sandbox_img = "getcapsule/sandbox:19.11.1-1.43"

$dpdk_driver = "uio_pci_generic"
$dpdk_devices = "0000:00:08.0 0000:00:09.0"
$vhome = "/home/vagrant"

# All Vagrant configuration is done here. The most common configuration
# options are documented and commented below. For a complete reference,
# please see the online documentation at https://docs.vagrantup.com.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/buster64"
  config.vm.box_check_update = false
  config.vm.post_up_message = "hello Capsule!"

  config.disksize.size = "45GB"

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"

  # Specific IPs. These is needed because DPDK takes over the NIC.
  # config.vm.network "private_network", ip: "10.100.1.10"
  # config.vm.network "private_network", ip: "10.100.1.11"

  config.vm.define "vm", primary: true do |v|
    # VirtualBox-specific default configuration
    v.vm.provider "libvirt" do |v|
#       v.management_network_name = "vagrant-libvirt-dpdk"
#       v.management_network_address = "192.168.124.0/24"
      v.memory = 8192
      v.cpus = 8
    end

    v.vm.provision "shell", path: "scripts/setup.sh"
    # Install DPDK.
    v.vm.provision "shell", path: "scripts/dpdk.sh"
    # Install for Vagrant user.
    v.vm.provision "shell", privileged: false, path: "scripts/rustup.sh"
    # Install for root user, as DPDK apps require sudo, e.g. `cargo run`.
    v.vm.provision "shell", path: "scripts/rustup.sh"
    # Setup specific to this vm.
    v.vm.provision "shell", path: "scripts/vm-vagrant.sh", :args => [$dpdk_driver, $dpdk_devices, $vhome]
  end
end
