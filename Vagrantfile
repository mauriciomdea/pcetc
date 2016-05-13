# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "ubuntu/trusty64"
  # Use Ubuntu 16.04 LTS 64-bit as our operating system
  # config.vm.box = 'ubuntu/xenial64'

  # config.vm.hostname = 'vagrant'

  # Configurate the virtual machine to use 2GB of RAM and 1 CPU core
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Use the shell to provision our virtual machine
  # config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "vim"

    chef.json = {
      # Install Ruby 2.2.1 and Bundler
      "rbenv": {
        "user_installs": [{
          "user": "vagrant",
          "rubies": ["2.2.1"],
          "global": "2.2.1",
          "gems": {
            "2.2.1" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      # Install PostgreSQL 9.2+
      "postgresql": {
        "password": {
          "postgres": "vagrant"
        }
      },
      "run_list": ["recipe[postgresql::server]"]
    }

  end

  # Cleanup
  config.vm.provision 'shell', inline: "echo 'yes' | sudo apt-get autoremove"

end
