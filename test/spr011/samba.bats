#! /usr/bin/env bats
#
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Test a Samba server


sut_ip=172.16.0.11     # IP of the system under test
sut_wins_name=FILESRV  # NetBIOS name
workgroup=LINUXLAB     # Workgroup
admin_user=bertvv      # User with admin privileges

# Preliminaries

@test 'NMB service should be running' {
  sudo systemctl status nmb.service
}

@test 'SMB service should be running' {
  sudo systemctl status smb.service
}

@test 'The ’nmblookup’ command should be installed' {
  which nmblookup
}

@test 'The ’smbclient’ command should be installed' {
  which smbclient
}

#
# 'White box' tests
#

# Directories

@test 'Check Samba root directory existence and permissions' {
  local samba_root_dir=/srv/shares
  [ -d "${samba_root_dir}" ]
  [ "755/root/root" = $(stat --format="%a/%U/%G" ${samba_root_dir}) ]
}

@test 'Check existence and permissions of share directory ‘beheer’' {
  local share=/srv/shares/beheer
  local stat=$(stat --format="%a/%U/%G/%C" ${share})
  [ -d "${share}" ]
  [ "770/root/beheer/unconfined_u:object_r:public_content_rw_t:s0" = ${stat} ]
}

@test 'Check existence and permissions of share directory ‘directie’' {
  local share=/srv/shares/directie
  local stat=$(stat --format="%a/%U/%G/%C" ${share})
  [ -d "${share}" ]
  [ "775/root/directie/unconfined_u:object_r:public_content_rw_t:s0" = ${stat} ]
}

@test 'Check existence and permissions of share directory ‘financieringen’' {
  local share=/srv/shares/financieringen
  local stat=$(stat --format="%a/%U/%G/%C" ${share})
  [ -d "${share}" ]
  [ "775/root/financieringen/unconfined_u:object_r:public_content_rw_t:s0" = ${stat} ]
}

@test 'Check existence and permissions of share directory ‘staf’' {
  local share=/srv/shares/staf
  local stat=$(stat --format="%a/%U/%G/%C" ${share})
  [ -d "${share}" ]
  [ "775/root/staf/unconfined_u:object_r:public_content_rw_t:s0" = ${stat} ]
}

@test 'Check existence and permissions of share directory ‘verzekeringen’' {
  local share=/srv/shares/verzekeringen
  local stat=$(stat --format="%a/%U/%G/%C" ${share})
  [ -d "${share}" ]
  [ "775/root/verzekeringen/unconfined_u:object_r:public_content_rw_t:s0" = ${stat} ]
}

# Users

@test 'Check existence of users' {
  id -u franka
  id -u femkevdv
  id -u hansb
  id -u peterj
  id -u kimberlyvh
  id -u taniav
  id -u maaiked
  id -u ${admin_user}
}

#{{{ Helper functions

# Checks if a user has shell access to the system
# Usage: can_login USER PASSWD
can_login() {
  echo $2 | su -c 'ls ${HOME}' - $1
}

# Checks that a user has NO shell access to the system
# Usage: cannot_login USER
cannot_login() {
  run sudo su -c 'ls' - $1
  [ "0" -ne "${status}" ]
}
#}}}

@test 'Checks shell access of users' {
  cannot_login franka
  cannot_login femkevdv
  cannot_login hansb
  cannot_login peterj
  cannot_login kimberlyvh
  cannot_login taniav

  can_login maaiked maaiked
  can_login ${admin_user} ${admin_user}
}

#
# Black box, acceptance tests
#

# Samba configuration

@test 'Samba configuration should be syntactically correct' {
  testparm -s
}

@test 'NetBIOS name resolution should work' {
  # Look up the Samba server’s NetBIOS name under the specified workgroup
  # The result should contain the IP followed by NetBIOS name
  nmblookup -U ${sut_ip} --workgroup ${workgroup} ${sut_wins_name} \
    | grep "^${sut_ip} ${sut_wins_name}"
}

@test 'Shares should exist' {
  # This test takes a long time. To skip, uncomment the following line
  #skip

  result=$(smbclient --list "//${sut_wins_name}/" --grepable --user %)
  echo ${result} | grep beheer
  echo ${result} | grep directie
  echo ${result} | grep financieringen
  echo ${result} | grep staf
  echo ${result} | grep verzekeringen
  echo ${result} | grep public
}

# Read / write access to shares

# {{{Helper functions
# Check that a user has read acces to a share
# Usage: read_access USER SHARE
read_access() {
  run smbclient "//${sut_wins_name}/$2" --user=$1%$1 --command='ls'
  [ "${status}" -eq "0" ]
}

# Check that a user has NO read access to a share
# Usage: no_read_access USER SHARE
no_read_access() {
  run smbclient "//${sut_wins_name}/$2" --user=$1%$1 --command='ls'
  [ "${status}" -eq "1" ]
}

# Check that a user has write access to a share
# Usage: write_access USER SHARE
write_access() {
  smbclient "//${sut_wins_name}/$2" --user=$1%$1 --command='mkdir test;rmdir test'
}

# Check that a user has NO write access to a share
# Usage: no_write_access USER SHARE
no_write_access() {
  run smbclient "//${sut_wins_name}/$2" --user=$1%$1 --command='mkdir test;rmdir test'
  echo ${output} | grep NT_STATUS_
}
# }}}

@test 'Check read acces for user franka (directie)' {
  no_read_access franka beheer
  read_access franka directie
  read_access franka staf
  read_access franka financieringen
  read_access franka verzekeringen
  read_access franka public
}

@test 'Check write access for user franka (directie)' {
  no_write_access franka beheer
  write_access franka directie
  write_access franka staf
  write_access franka financieringen
  write_access franka verzekeringen
  write_access franka public
}

@test 'Check read acces for user femkevdv (staf)' {
  no_read_access femkevdv beheer
  read_access femkevdv directie
  read_access femkevdv staf
  read_access femkevdv financieringen
  read_access femkevdv verzekeringen
  read_access femkevdv public
}

@test 'Check write access for user femkevdv (staf)' {
  no_write_access femkevdv beheer
  no_write_access femkevdv directie
  write_access femkevdv staf
  no_write_access femkevdv financieringen
  no_write_access femkevdv verzekeringen
  write_access femkevdv public
}

@test 'Check read acces for user hansb (verzekeringen)' {
  no_read_access hansb beheer
  no_read_access hansb directie
  read_access hansb staf
  read_access hansb financieringen
  read_access hansb verzekeringen
  read_access hansb public
}

@test 'Check write access for user hansb (verzekeringen)' {
  no_write_access hansb beheer
  no_write_access hansb directie
  no_write_access hansb staf
  no_write_access hansb financieringen
  write_access hansb verzekeringen
  write_access hansb public
}

@test 'Check read acces for user kimberlyvh (verzekeringen)' {
  no_read_access kimberlyvh beheer
  no_read_access kimberlyvh directie
  read_access kimberlyvh staf
  read_access kimberlyvh financieringen
  read_access kimberlyvh verzekeringen
  read_access kimberlyvh public
}

@test 'Check write access for user kimberlyvh (verzekeringen)' {
  no_write_access kimberlyvh beheer
  no_write_access kimberlyvh directie
  no_write_access kimberlyvh staf
  no_write_access kimberlyvh financieringen
  write_access kimberlyvh verzekeringen
  write_access hansb public
}

@test 'Check read acces for user taniav (verzekeringen)' {
  no_read_access taniav beheer
  no_read_access taniav directie
  read_access taniav staf
  read_access taniav financieringen
  read_access taniav verzekeringen
  read_access taniav public
}

@test 'Check write access for user taniav (verzekeringen)' {
  no_write_access taniav beheer
  no_write_access taniav directie
  no_write_access taniav staf
  no_write_access taniav financieringen
  write_access taniav verzekeringen
  write_access taniav public
}

@test 'Check read acces for user peterj (financieringen)' {
  no_read_access peterj beheer
  no_read_access peterj directie
  read_access peterj staf
  read_access peterj financieringen
  read_access peterj verzekeringen
  read_access peterj public
}

@test 'Check write access for user peterj (financieringen)' {
  no_write_access peterj beheer
  no_write_access peterj directie
  no_write_access peterj staf
  write_access peterj financieringen
  no_write_access peterj verzekeringen
  write_access peterj public
}

@test 'Check read acces for user maaiked (beheer)' {
  read_access maaiked beheer
  read_access maaiked directie
  read_access maaiked staf
  read_access maaiked financieringen
  read_access maaiked verzekeringen
  read_access maaiked public
}

@test 'Check write access for user maaiked (beheer)' {
  write_access maaiked beheer
  write_access maaiked directie
  write_access maaiked staf
  write_access maaiked financieringen
  write_access maaiked verzekeringen
  write_access maaiked public
}

@test "Check read acces for user ${admin_user} (beheer)" {
  read_access ${admin_user} beheer
  read_access ${admin_user} directie
  read_access ${admin_user} staf
  read_access ${admin_user} financieringen
  read_access ${admin_user} verzekeringen
  read_access ${admin_user} public
}

@test "Check write access for user ${admin_user} (beheer)" {
  write_access ${admin_user} beheer
  write_access ${admin_user} directie
  write_access ${admin_user} staf
  write_access ${admin_user} financieringen
  write_access ${admin_user} verzekeringen
  write_access ${admin_user} public
}

@test "Check read access on home directories" {
  read_access franka        franka
  read_access femkevdv      femkevdv
  read_access hansb         hansb
  read_access peterj        peterj
  read_access kimberlyvh    kimberlyvh
  read_access taniav        taniav
  read_access maaiked       maaiked
  read_access ${admin_user} ${admin_user}
}

@test "Check write access on home directories" {
  write_access franka        franka
  write_access femkevdv      femkevdv
  write_access hansb         hansb
  write_access peterj        peterj
  write_access kimberlyvh    kimberlyvh
  write_access taniav        taniav
  write_access maaiked       maaiked
  write_access ${admin_user} ${admin_user}
}
