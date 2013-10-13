# -*- mode: ruby -*-
# vi: set ft=ruby :

$SYSTEM_INIT_SCRIPT = <<SCRIPT
echo "this is a hello world..."
SCRIPT

Vagrant.configure("2") do |config|

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.define :sbc_env do |sbc_env|

    # Using Ubuntu 12.04 64-bits
    sbc_env.vm.box = "precise64"

    # Setup the hostname as "sbc_env"
    sbc_env.vm.hostname = "sbc_env"

    # Customize the Virtualbox with defined 2G RAM and 4 CPU cores
    #
    # Note, this setting isn't portable for other providers such as VMWare or Amazon EC2
    # 
    sbc_env.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
        vb.customize ["modifyvm", :id, "--usb", "on"]
        vb.customize ["modifyvm", :id, "--usbehci", "on"]
        vb.customize ["usbfilter", "add", "0", 
            "--target", :id, 
            "--name", "Any mass storage", 
            "--manufacturer", "Generic",
            "--product", "Mass Storage Device"]
    end

    # Execute the system initialization script inlined in the Vagrantfile
    sbc_env.vm.provision :shell, :inline => $SYSTEM_INIT_SCRIPT

    # Enable Berkshelf plugin to load `Berksfile` file from root directory
    sbc_env.berkshelf.enabled = true

    sbc_env.vm.provision :chef_solo do |chef|

      # Must add the `apt` to force `apt-get update` before install other
      # softwares on Ubuntu
      chef.add_recipe "apt"

      chef.json = {
      }
    end # end of "sbc_env" chef_solo provisioning
  end # end of "sbc_env" vm instance
end
