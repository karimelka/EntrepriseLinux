Stubbe Gianni
El Kaddouri Karim

Dec 5 2014

Verslag Troubleshooting opdracht Samba

* NetBIOS name die niet klopte
==> De service herstart en dit was in orde

* public_content_rw_t aanpassen
sudo chcon -R -t public_content_rw_t /srv/shares/alpha
sudo chcon -R -t public_content_rw_t /srv/shares/echo
sudo chcon -R -t public_content_rw_t /srv/shares/charlie
sudo chcon -R -t public_content_rw_t /srv/shares/delta
sudo chcon -R -t public_content_rw_t /srv/shares/foxstrot

==> Hierdoor zijn de permissies voor charlie al in orde

* Test shares should exists
==> fails want charlie bestaat niet onder de shares en moet nog aangemaakt worden
browsable bij charlie moest op default waarde staan in plaats van NO

* Bravo Read Access (een deel van een foutboodschap)
==> valid users stond op bravo terwijl iedereen het moet kunnen lezen

*Write access for alice and brovo and echo
==> setsebool -P allow_smbd_anon_write
jemag schrijfrechten geven op shares die niet de normale content
*Write acces for delta
==> writelist stond er niet in
write list = @delta

*Write access for foxtrot
==> writelist stond er niet in
write list = @foxtrot

