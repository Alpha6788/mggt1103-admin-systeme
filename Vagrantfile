# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Definition de l'image de base (Ubuntu 22.04 LTS Server)
  config.vm.box = "ubuntu/jammy64"

  # Configuration Reseau : IP privee statique pour notre serveur d'infrastructure
  # Cette IP permettra d'acceder aux futurs services (DNS, Web) de notre VM
  config.vm.network "private_network", ip: "192.168.56.50"

  # Personnalisation des ressources de l'hyperviseur VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.name = "VM-Ubuntu-Mggt1103"
    vb.memory = "1024" # 1 Go de RAM alloue (economie d'energie sur vos laptops)
    vb.cpus = 1        # 1 seul coeur CPU virtuel
  end
end
