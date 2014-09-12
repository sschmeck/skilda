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
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

end
