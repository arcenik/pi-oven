# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.synced_folder ".", "/data"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "8192"
  end

  config.vm.provision "shell", path: "scripts/environment/provision.sh"
end

