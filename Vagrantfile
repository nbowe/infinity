# -*- mode: ruby -*-
# vi: set ft=ruby :

class String
  def unindent 
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
    # Enable USB. Requires extension pack to be installed on host.
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
    # Add a USB filter so that Infinity Keyboard bootloader auto attaches.
    vb.customize ["usbfilter", "add", "0", 
      "--target", :id, 
      "--name", "Kiibohd DFU Bootloader", 
      "--vendorid", "0x1c11", "--productid", "0xb007"]
  end
  
  # vagrant plugin install vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine
  end

  config.vm.provision "shell", inline: <<-SHELL.unindent
    sudo apt-get update
    # Sync time with host, to avoid 'Clock skew detected' when building.
    /usr/sbin/VBoxService --timesync-set-start --timesync-set-on-restore 1 --timesync-set-threshold 500
    sudo apt-get -y install git cmake ctags libusb-1.0-0-dev
    # For Teensy 1, Teensy 2, or other AVR based chip
    sudo apt-get -y install binutils-avr gcc-avr avr-libc
    # For Teensy 3, Infinity Keyboard, or another ARM based chip
    sudo apt-get -y install binutils-arm-none-eabi gcc-arm-none-eabi dfu-util
    # For building bootloader
    sudo apt-get -y install ruby ruby-dev
    sudo gem install serialport
    # For debug
    sudo apt-get -y install screen
    # Clone the kiibohd repo
    sudo -Hn -u vagrant git clone https://github.com/kiibohd/controller.git
    # Link layouts for convenience.
    sudo -Hn -u vagrant ln -s /vagrant/layouts layouts
    # Build default firmware.
    pushd layouts/default
    sudo -Hn -u vagrant ./build.sh
    popd
    # Modify motd.
    cat >/etc/motd <<MOTD
     Layouts are in the "layouts" directory.
     Build via './build.sh' in one of the layout directories.
     Then flash via 'sudo ./load' after pressing the flash button on the bottom of your keyboard.
     The default Infinity firmware is built already, and can be found in 'layouts/default'.
    MOTD
  SHELL

  # vagrant plugin install vagrant-triggers
  if Vagrant.has_plugin?("vagrant-triggers")
    config.trigger.before :destroy do
      info "Cleaning build artifacts from layouts."
      run_remote  "cd /home/vagrant/layouts && git clean -fXd"
    end
  end
end
