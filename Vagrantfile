# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"
  config.disksize.size = '40GB'

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/data", automount: true

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "8192"
  end

  config.vm.provision "shell", path: "scripts/environment/provision.sh"
end
