# -*- mode: ruby -*-
# vi: set ft=ruby :
MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define :restore do |node|
    device = ENV['VAGRANT_BRIDGE'] || 'eth0'
    env  = ENV['PUPPET_ENV'] || 'dev'

    node.vm.box = 'ubuntu-15.04_puppet-3.8.2' 
    node.vm.network :public_network, :bridge => device , :dev => device
    node.vm.hostname = 'restore.local'

    node.vm.provider :libvirt do |domain, o|
	domain.uri = 'qemu+unix:///system'
	domain.host = "restore.local"
	domain.memory = 2048
	domain.cpus = 2
	domain.storage_pool_name = 'restore'
	domain.storage :file, :size => '500G', :path => 'restore.qcow2'
	o.vm.synced_folder './', '/vagrant', type: 'nfs'
    end

    node.vm.provision :shell, :inline => update
    node.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end
  end

end
