#! /usr/bin/env bats
# vi: ft=bash
# Author: Stoel
#
# Test a DNS server

@test "DNS service should be running" { 
  sudo systemctl status named.service
}

@test 'Firewall rule is aangepast voor tcp 53' {
  result="$(sudo iptables --list-rules | grep 53)"
  [ -n "${result}" ] # The result should not be empty
}
