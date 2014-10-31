#Welke manier is de beste voor testen te schrijven?

BATS : Unix testing voor scriptiong

elke test begint met @test

voorbeelden van testen

@test 'DNS service shouwld be running'
{sudo systemctl status named.service}

@test 'the dig command should be installed'
{which dig}

@test 'it should return the NS records'
{
result="$(dig @$(ns_ip) $(domain) NS+ short"
[ -n "${result}" ]}
}
