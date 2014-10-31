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

#Diversen
 <Opgelet : Bij het installeren zijn we erop gebotst dat je echt in de folder moet zitten om succes te hebben. Screenshot hiervan zal nog worden toegevoegd>
 |Wisselen van schijven in bash|``` /d/Users/... ```| -----

#Ansible
Als je iets wil installeren moet je dit toevoegen in een .yml bestand. Per rol wordt er in principe een folder aangemaakt. 

vb : installeren van bind : het scriptje wordt geplaats in de volgende folder : ```ansible/roles/bind/tasks/main.yml```

De code die je hierin zet is een beetje gelijkaardig bij andere dingen : 
```
- name: install bind packages
apt: pkg={{ item }} state={{ bind_pkg_state }}
with_items: bind_pkgs
tags: package
```
#Maria DB
In Centos 7 is MySQL niet meer beschikbaar
Je moet dit veranderen aan MariaDB.
Bij het maken van de .yml file hiermee rekening houden
Indien je het wachtwoord veranderd hebt in de dbpasswd mag het zeker geen vreemde tekens bevatten

 Wat het doet| Commando
 ----------| -------------------
 Installeren van MariaDB| ```sudo yum install mariadb-server mariadb```
 Opstarten van apache | ```sudo systemctl start mariadb```

rpm -lq

#Install Apache

Handige commando's bij het gebruik van Vagrant
 
 Wat het doet| Commando
 ----------| -------------------
 Installeren van apache| ```sudo yum install httpd```
 Opstarten van apache | ```sudo systemctl start httpd.service```
 Testen van de apache | ```http://ipadresvandeserver```
 Inschakelen apache via commando | ```sudo systemctl enable httpd.service```

#RDesktop
RDesktop is een tool die je onder fedora kan gebruiken om PC's vanop afstand over te nemen via het Microsoft RDP protocol. Deze zit normaal al geinstalleerd in uw machine.

Handige commando's hierbij 

 Wat het doet| Commando
 ----------| -------------------
Installeren van het pakket| ```sudo yum -y install rdesktop```
Connecie maken met een systeem| ```rdesktop -u gebruikersnaam hostname:poortnummer```

voorbeeld hiervan : ```rdesktop -u linuxgebruiker windowsisookleuk.dynamic-dns.com:3389```

#BATS
 Wat het doet| Commando
 ----------| -------------------
 Begin van testen| ```@test```
 Exit status : 0 | ```OK/true```
 Exit status : 1-255 | ```niet OK/FALSE```

#Fundamenten
 Wat het doet| Commando
 ----------| -------------------
 Begin van testen| ```$(cmd) wordt opgevangen in een andere variabele result=$()```
 Logische expressies [ -n =test (-n gaat kijken of het niet leeg is/-z kijken of het wel leeg is
 
