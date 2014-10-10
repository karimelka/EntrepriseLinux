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
