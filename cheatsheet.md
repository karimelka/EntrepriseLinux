#Vagrant
Handige commando's bij het gebruik van Vagrant
 
 Wat het doet| Commando
 ----------| -------------------
 Toevoegen van een bestand aan vagrant| ```vagrant box add```
 Toevoegen vagrant toestel aan in virtualbox directory| ```vagrant init (naam)```
 Toevoegen machine aan virtualbox | ```vagrant up```
 Overzicht over de vm's die aanstaan | ```vagrant status```
 Inloggen via vagrant op uw machine ssh | ```vagrant ssh```
 nieuwe ifconfig | ```ip -a```
 Vagrant file wegdoen (je kan ze ook zo proper houden) | ```vagrant destroy```
 Machine opslaan maar niet afsluiten |```vagrant suspend```
 Machine volledig uitschakelen | ```vagrant halt```
 Weten hoe je uw virtuele machine hebt genoemt |  ```vagrant boxlist```

#Git
Als je een bestand will pushen via de terminal (als er een SSH is opgesteld)

```git add Week01.md```

Status : git status

git init

ga naar de folder en doe dan git add

en dan voor de code naar de remote te sturen : git push -u origin master

##Diversen
 <Opgelet : Bij het installeren zijn we erop gebotst dat je echt in de folder moet zitten om succes te hebben. Screenshot hiervan zal nog worden toegevoegd>
 |Wisselen van schijven in bash|``` /d/Users/... ```| -----
 
###Maria DB
In Centos 7 is MySQL niet meer beschikbaar
Je moet dit veranderen aan MariaDB.
Bij het maken van de .yml file hiermee rekening houden
Indien je het wachtwoord veranderd hebt in de dbpasswd mag het zeker geen vreemde tekens bevatten

 Wat het doet| Commando
 ----------| -------------------
 Installeren van MariaDB| ```sudo yum install mariadb-server mariadb```
 Opstarten van apache | ```sudo systemctl start mariadb```

rpm -lq

####Install Apache

Handige commando's bij het gebruik van Vagrant
 
 Wat het doet| Commando
 ----------| -------------------
 Installeren van apache| ```sudo yum install httpd```
 Opstarten van apache | ```sudo systemctl start httpd.service```
 Testen van de apache | ```http://ipadresvandeserver```
 Inschakelen apache via commando | ```sudo systemctl enable httpd.service```

#.gitignore

Ignore hidden Vagrant-directory
.vagrant

Ignore backup files
*~

#VagrantFile
------------------
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'
require 'yaml'

VAGRANTFILE_API_VERSION = '2'

hosts = YAML.load_file('vagrant_hosts.yml')

# {{{ Helper functions

def is_windows
  RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
end

def provision_ansible(config, node)
  if is_windows
    # Provisioning configuration for shell script.
    config.vm.provision "shell" do |sh|
      sh.path = "ansible_win.sh"
    end
  else
    # Provisioning configuration for Ansible (for Mac/Linux hosts).
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/site.yml"
      ansible.sudo = true
    end
  end
end

# }}}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'CentOS70'
  hosts.each do |host|
    config.vm.define host['name'] do |node|
      node.vm.hostname = host['name']
      node.vm.network :private_network,
        ip: host['ip'],
        netmask: '255.255.255.0'
      node.vm.synced_folder 'ansible/', '/etc/ansible', mount_options: ["fmode=666"] 

      node.vm.provider :virtualbox do |vb|
        vb.name = host['name']
      end

      provision_ansible(config, node)
    end
  end
end

#Ansible/host_vars/srv001
---------------------------

---
# file group_vars/all

# Application database
dbname: MijnWikiDatabase
dbuser: gebruiker_stoel
dbpasswd: ABC123

# Disable All Updates
# By default automatic updates are enabled, set this value to true to disable all automatic updates
auto_up_disable: false

#Define Core Update Level
#true  = Development, minor, and major updates are all enabled
#false = Development, minor, and major updates are all disabled
#minor = Minor updates are enabled, development, and major updates are disabled
core_update_level: true
