# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.define :restore do |node|

    env  = ENV['PUPPET_ENV'] || 'dev'
    node.vm.box = 'ubuntu-16.04.2_puppet-3.8.7'
    node.vm.hostname = 'restore.local'

    node.vm.provider :libvirt do |domain, o|
      domain.uri = 'qemu+unix:///system'
      domain.host = "restore.local"
      domain.memory = 2048
      domain.cpus = 2
      domain.storage :file, :size => '50G', :path => 'restore.qcow2'
      o.vm.synced_folder './', '/vagrant', type: 'nfs'
    end

    node.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file  = 'default.pp'
      puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env} "
    end
  end

end
