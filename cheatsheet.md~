#Vagrant
El Kaddouri Karim
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
 Moet je doen telkens je iets veranderd in je vagrantfile |  ```vagrant reload```
 Als je een box wilt gaan toevoegen |  ```vagrant box add```

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
 |Aanmaken van verschillende subfolders onder een folder|``` mkdir -p ftp/{handlers,tasks,templates} ```| -----

Opletten voor dubbele quotes die niet kunnen werken
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

De naam van de rol nog bijzetten bij ```ansible/host_vars/site.yml```
Als je dan  ```vagrant provision ``` doet moet hij het runnen

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
 Runnen van bats | ```./bats/bin/bats srv001/testDNS.bats```
 Bestand uitvoeren | ``` ./vagrant/test/runbats.sh```
#SAMBA
 Wat het doet| Commando
 ----------| -------------------
 indien share parameters staan op public_content_rw_t| ``````
 public_content_rw_t aanpassen | ```sudo chcon -R -t public_content_rw_t /srv/shares/alpha```
 Browsable controleren | ```aanpassen in template```
 kijken naar de rechten voor read| ```valid users```
 write access controleren | ```write list = @foxtrot```
 herstarten van server | ```sudo systemctl restart smb / nmb```

#SELINUX
###SELinux ###

| Wat het doet                                  | Commando                                    |
| :---                                    | :---                                       |
| Status controleren                | `sestatus` |
| Starten setroubleshoot (daemon)| `setroubleshootd` |
| Herstellen initiële SELinux-settings| `restorecon -R -v [target-folder]`(bijv. /var/www) |
| In de logs controleren op output van setroubleshoot | `grep setroubleshoot /var/log/messages` |
| Config files SELinux | `/etc/selinux/config `                         |
| Labeling controleren (optie -Z) | `ls -lZ [/usr/sbin/httpd]`                       |
| Change context | `chcon` |
| Ingestelde booleans opvragen | `getsebool -a` (en evt. `| grep samba/smbd/nmbd`) |
| Een boolean instellen| `setsebool [boolean] [0|1]` (-P toevoegen om permanent te maken) |
| (na install setroubleshoot) | `sealert -l [de opgegeven code]` |
| Grafische tool| `system-config-selinux` |
| SELinux-Alerts vinden in de logs | `sealert -a /var/log/audit/audit.log | less` |

#Terminator

| Wat het doet                                  | Commando                                    |
| :---                                    | :---                                       |
| Status controleren                | `sestatus` |

  |   Move to the Above Terminal |  `Alt+Up_Arrow_Key` | 
   |  Move to the Below Terminal |  `Alt+Down_Arrow_Key`| 
   |  Move to the Left Terminal |  `Alt+Left_Arrow_Key`| 
    | Move to the Right Terminal | ` Alt+Right_Arrow_Key`| 
    | Copy a text to clipboard | `Ctrl+Shift+c`| 
    | Paste a text from Clipboard | ` Ctrl+Shift+v`| 
    | Close the Current Terminal |  `Ctrl+Shift+w`| 
    | Quit the Terminator |  `Ctrl+Shift+q`| 
    | Toggle Between Terminals |  `Ctrl+Shift+x`| 
    | Open New Tab|  `Ctrl+Shift+t`| 
    | Move to Next Tab| `Ctrl+page_Down`| 
    | Move to Previous Tab |  `Ctrl+Page_up`| 
    | Increase Font size| `Ctrl+(+)`| 
    | Decrease Font Size| `Ctrl+(­)`| 
    | Reset Font Size to Original|` Ctrl+0`| 
    | Toggle Full Screen Mode| `F11`| 
    | Reset Terminal| `Ctrl+Shift+R`| 
    | Reset Terminal and Clear Window| `Ctrl+Shift+G`| 
    | Remove all the terminal grouping| `Super+Shift+t`| 
    | Group all Terminal into one| `Super+g`| 


#Fundamenten
Gaan kijken in  ```man-tests ```


Wat het doet| Commando
----------| -------------------
Begin van testen| ```$(cmd) wordt opgevangen in een andere variabele result=$()```
Logische expressies | ```[  -n =test  ```
Getallen gaan vergelijken |  ```-eq ```
Kijken of string leeg is |  ```-z ```
Kijken of string niet leeg is | ``` -n ```
Runnen van een bash scirpt | ``` ./scriptnaam.sh ```
Package vinden op commando | ```yum provides *bin/dig```
Logfiles opvragen van een bepaalde service | ```sudo journal ctl -f -u named.service```
Ipconfig | ```ifconfig -a```
