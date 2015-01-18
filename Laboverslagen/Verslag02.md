Laboverslag 02 : Webserver

####Stubbe Gianni
####El Kaddouri Karim

# Installatie ansible
##Roles

Algemene kennis over ansible en meer werd opgedaan via de presentatie van Meneer Van Vreckem. [Link](https://bertvv.github.io/vagrant-presentation/)

###Common
We hebben voor de lampstack 4 roles toegevoegd: de common role die zaken als de firewall inschakelt en selinux-python installeert.
Ook wordt hier selinux geactiveerd op enforcing met policy targeted.

###Database
Voor de db role gebruiken we mariadb en MySQL-python. Daar wordt de gebruiker, de databank en het wachtwoord gecreëerd.

###Web
Als derde is er de webrole die services als Apache installeert, deze hierna activeert en als laatste de firewall regels aanpast
voor http en https verkeer. 

###Mediawiki
Als CMS systeem waren we eerst vertrokken bij de mediawiki server maar omdat niet enkel de LocalSettings.php file aangemaakt wordt,
maar ook database tabellen (wat we over het hoofd gezien hadden ) lukte het niet om deze te kopieren.


###Wordpress
Hierna zijn we voor Wordpress gegaan. We hebben een voorbeeld van github gebruikt en hierna naar onze hand gezet
voor onze installatie. Er is een template gebruikt als config file en onder taken horen het toevoegen van een groep voor wordpress,
een gebruiker toevoegen, wordpress database aanmaken enz. 

Voor dit onderdeel hebben we ons gebasseerd op : [Link](https://github.com/ansible/ansible-examples/tree/master/wordpress-nginx)

##Testen
Testen zouden nog besproken worden in de les dus deze zijn nog niet aanwezig in ons project.