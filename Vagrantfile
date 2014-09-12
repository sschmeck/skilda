# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # setup project
  config.vm.synced_folder ".", "/home/vagrant/skilda"
  config.vm.network "forwarded_port", guest: 7474, host: 10074
  config.vm.network "forwarded_port", guest: 9292, host: 10092

  # ensure prerequisites
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug    

    chef.add_recipe 'apt'
    chef.add_recipe 'java'
    chef.add_recipe 'neo4j-server::tarball'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'rbenv::user'
    chef.add_recipe 'rbenv::vagrant'
    chef.add_recipe 'vim'

    chef.json = { java: { 'install_flavor' => 'oracle',
                          'jdk_version' => 7,
                          'oracle' => { 'accept_oracle_download_terms' => true } },
                  rbenv: { user_installs: [{ user: 'vagrant',
                                             rubies: ['2.1.2'],
                                             global: '2.1.2',
                                             gems: { '2.1.2' => [{ name: 'bundler' }] } }] } }
  end

end