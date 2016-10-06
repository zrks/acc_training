# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.hostname = "workstation"
  
  config.vm.box = "bento/debian-8.5"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 8080, host: 8088
  config.vm.network "forwarded_port", guest: 9000, host: 9000

  config.vm.provider "virtualbox" do |vb|
    vb.gui    = false
    vb.memory = "1024"
  end

  config.vm.provision "shell", path: "provision.sh"

  config.vm.provision "shell",
    inline: "mkdir /home/vagrant/jenkins && chown 1000 jenkins"

  config.vm.provision "docker" do |d|
    d.run "jenkins",
      image: "jenkins:alpine",
      args: "-p 8080:8080 -v /home/vagrant/jenkins/:/var/jenkins_home/"
  end

end
