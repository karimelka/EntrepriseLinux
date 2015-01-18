Stubbe Gianni   
El Kaddouri Karim

#Entreprise Linux - Opdracht 3 - Linux Troubleshooting

##Opstarten van de virutele machine
Login: admin   
Password: fixit

##IP instellingen
Een IT'er gaat altijd gaan kijken in de netwerkinstellingen, want meestal ligt daar ergens de oorzaak
Installeren net-tools

De netwerkkaart staat down.(```ip addr ```) enp0s8 krijgt geen gegevens door, dus er is geen mogelijkheid om te kunnen verbinden met het lokale netwerk.

De NAT en Loopback adres worden wel getoond

Ook voor het ons zelf makkelijker te maken hebben we de toetsenbordlayot veranderd naar belgisch azerty
[link](https://www.centos.org/forums/viewtopic.php?t=32377)

Toetsenbord veranderen met system-config-keyboard commando  
[link2](http://lintut.com/how-to-configure-static-ip-address-on-centos-6-5-minimal/),
[link3](http://www.tecmint.com/ifconfig-command-examples/)

Uiteindelijke de netwerkkaart die in VirtualBox wel ingeschakeld stond maar de kabel was niet aangesloten. Dan gaan we van Status DOWN naar Status UP
via ```sudo vi etc/sysconfig/network-scripts/ifcfg-enp0s8```   
IP adress veranderen naar 192.168.56.24   
Geen Default Gateway nodig   
En deze moet onboot aanstaan (yes)   
```sudo service network restart``` 

nu bij ```ip addr``` moet state up zijn en een ip adres hebben : 192.168.56.24/24

##Firewall

Het lukte ons hierna nog niet om connectie te maken via ons hostsysteem.
Ons volgende idee was de firewall, aangezien de https niet zichtbaar stond

Opstarten httpd service : ```sudo systemctl status httpd```

Eerst controleren of deze aanstaat : ```firewall-cmd --status
deze staat op running```

doe dan : ```firewall-cmd --zone=public --add-service=https --permanent```

uiteindelijk doen we een : ```firewall-cmd --reload```

Uiteindelijk zou het moeten werken

Veel informatie gevonden op de website van RedHat en Fedora
[Firewalls Redhat](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Using_Firewalls.html)   

Gianni had al een vermoeden dat er iets zou zijn met de firewall, dus hebben we er oreo's op gewed. Hij heeft de weddenschap gewonnen en heeft zijn prijs ook in eer en geweten in ontvangst mogen nemen.