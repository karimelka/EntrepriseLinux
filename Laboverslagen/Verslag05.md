Stubbe Gianni   
El Kaddouri Karim

#Entreprise Linux - Opdracht 5 - Samba & FTP Server

[TOC]

##Bronnen en bitbucket
###Bronnen
* Bron 1) n.v.t.

###Repositories
* Repo 1) [Bitbucket Repo](https://bitbucket.org/stoel/labo/src/)

##Samba
* In de host_vars voor pr011 variabelen voor de config file en users aanmaken voor samba.

###Variabelen definiëren
* Onder andere de shares:
* De shares bevatten de groepen die access hebben, de standaard aanmaak groep en de permissions.
* Voorbeeld groep: 
```
  - name: directie
    create_mode: 775
    force_group: directie
    write_list: "@directie"
    valid_users: "@staf"
    force_create_mode: 775
    directory_mask: 775
    force_directory_mode: 775
```
* Daarna maken we de users aan: deze krijgen een wachtwoord groepen waartoe ze behoren (voor de permissies) en hun gebruikersnaam.
* Voorbeeld User:
```
  - name: femkevdv
    given_name: Femke
    surname: Van De Vorst
    groups:
      - public     
      - staf         
    password: femkevdv
```
* LET OP: voor homedirs variabele moet yes gelijk zijn aan `'yes'` met quotes.[¹]


##smb.conf
hier worden de shares aangemaakt aan de hand van de host_vars die je gedefiniëerd hebt.

##FTP
De configuratie van ftp moest nog maar een klein beetje aangepast worden: sebooleans: ftp_home_dir,  ftpd_full_access instellen op yes.
Bij host vars moet je ftp_local_root definiëren als `/srv/shares/`.

##VagrantFile
Wij hebben ook onze vagrantfile aangepast op aanraden van Mr. Van Vreckem. Deze bevatte een loop die bij het provisionen een machine meerdere malen uitvoerde.


##Test
###Samba
```
[vagrant@pr011 ~]$ /tmp/test/runbats.sh
Running test /tmp/test/pr011/samba.bats
 ✓ NMB service should be running
 ✓ SMB service should be running
 ✓ The ’nmblookup’ command should be installed
 ✓ The ’smbclient’ command should be installed
 ✓ Check Samba root directory existence and permissions
 ✓ Check existence and permissions of share directory ‘beheer’
 ✓ Check existence and permissions of share directory ‘directie’
 ✓ Check existence and permissions of share directory ‘financieringen’
 ✓ Check existence and permissions of share directory ‘staf’
 ✓ Check existence and permissions of share directory ‘verzekeringen’
 ✓ Check existence of users
 ✓ Checks shell access of users
 ✓ Samba configuration should be syntactically correct
 ✓ NetBIOS name resolution should work
 ✓ Shares should exist
 ✓ Check read acces for user franka (directie)
 ✓ Check write access for user franka (directie)
 ✓ Check read acces for user femkevdv (staf)
 ✓ Check write access for user femkevdv (staf)
 ✓ Check read acces for user hansb (verzekeringen)
 ✓ Check write access for user hansb (verzekeringen)
 ✓ Check read acces for user kimberlyvh (verzekeringen)
 ✓ Check write access for user kimberlyvh (verzekeringen)
 ✓ Check read acces for user taniav (verzekeringen)
 ✓ Check write access for user taniav (verzekeringen)
 ✓ Check read acces for user peterj (financieringen)
 ✓ Check write access for user peterj (financieringen)
 ✓ Check read acces for user maaiked (beheer)
 ✓ Check write access for user maaiked (beheer)
 ✓ Check read acces for user bertvv (beheer)
 ✓ Check write access for user bertvv (beheer)
 ✓ Check read access on home directories
 ✓ Check write access on home directories
```
###FTP
```
 ✓ VSFTPD service should be running
 ✓ The ’curl’ command should be installed
 ✓ Check Samba root directory existence and permissions
 ✓ Check existence and permissions of share directory ‘beheer’
 ✓ Check existence and permissions of share directory ‘directie’
 ✓ Check existence and permissions of share directory ‘financieringen’
 ✓ Check existence and permissions of share directory ‘staf’
 ✓ Check existence and permissions of share directory ‘verzekeringen’
 ✓ VSFTPD configuration should be syntactically correct
 ✓ Anonymous user should not be able to see shares
 ✓ Check read acces for user franka (directie)
 ✓ Check write access for user franka (directie)
 ✓ Check read acces for user femkevdv (staf)
 ✓ Check write access for user femkevdv (staf)
 ✓ Check read acces for user hansb (verzekeringen)
 ✓ Check write access for user hansb (verzekeringen)
 ✓ Check read acces for user kimberlyvh (verzekeringen)
 ✓ Check write access for user kimberlyvh (verzekeringen)
 ✓ Check read acces for user taniav (verzekeringen)
 ✓ Check write access for user taniav (verzekeringen)
 ✓ Check read acces for user peterj (financieringen)
 ✓ Check write access for user peterj (financieringen)
 ✓ Check read acces for user maaiked (beheer)
 ✓ Check write access for user maaiked (beheer)
 ✓ Check read acces for user bertvv (beheer)
 ✓ Check write access for user bertvv (beheer)
```
[¹] Bij de smb.conf wordt gecontroleerd op `samba_enable_homes == 'yes'`