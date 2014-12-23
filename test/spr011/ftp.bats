#! /usr/bin/env bats
#
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Test a Vsftpd server

sut_ip=172.16.0.11     # IP of the System Under Test
admin_user=bertvv      # User with admin privileges
testfile="tst${RANDOM}"

# Preliminaries

@test 'VSFTPD service should be running' {
  sudo systemctl status vsftpd.service
}

@test 'The ’curl’ command should be installed' {
  which curl
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

#
# Black box, acceptance tests
#

# VSFTPD configuration

# {{{Useful return codes

# FTP
ftp_pathname_created=257

# curl
curl_ok=0
curl_err_access_denied=9
curl_err_retr_failed=9
curl_err_failed_to_log_in=67
curl_err_resource_doesnt_exist=78
# }}}

@test 'VSFTPD configuration should be syntactically correct' {
  #skip # slow test
  run sudo vsftpd -olisten=NO /etc/vsftpd/vsftpd.conf
  [ -z "${output}" ]
}

@test 'Anonymous user should not be able to see shares' {
  #skip #slow test
  run curl ftp://${sut_ip}/
  [ "${curl_err_failed_to_log_in}" -eq "${status}" ]
}

# Read / write access to shares

# {{{Helper functions
# Check that a user has read acces to a share
# Usage: read_access USER SHARE
read_access() {
  run curl "ftp://${sut_ip}/$2/" --user $1:$1
  [ "${curl_ok}" -eq "${status}" ]
}

# Check that a user has NO read access to a share
# Usage: no_read_access USER SHARE
no_read_access() {
  run curl "ftp://${sut_ip}/$2/" --user $1:$1
  [ "${curl_err_access_denied}" -eq "${status}" ]
}

# Check that a user has write access to a share.
# Usage: write_access USER SHARE
write_access() {
  run curl "ftp://${sut_ip}/$2/" --request "MKD ${testfile}" --user $1:$1
  echo "${output}" | grep "RETR response: ${ftp_pathname_created}"
  run curl "ftp://${sut_ip}/$2/" --request "RMD ${testfile}" --user $1:$1
}

# Check that a user has NO write access to a share.
# Writing can be blocked in (at least) two ways:
# - the USER has no read access => curl gives an "access denied" error
# - the USER has read acces, but can't write => curl gives a "RETR failed"
#   error with an FTP error code denoting "file unavailable"
# Usage: no_write_access USER SHARE
no_write_access() {
  run curl "ftp://${sut_ip}/$2/" --request "MKD ${testfile}" --user $1:$1
  if [ "${curl_err_access_denied}" -eq "${status}" ]; then
    # user has no read access
    return 0
  elif [ "${curl_err_retr_failed}" -eq "${status}" ]; then
    # user can read, but has no write access
    echo ${output} | grep "${ftp_file_unavailable}"
  fi
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
  read_access hansb directie
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
  read_access kimberlyvh directie
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
  read_access taniav directie
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
  read_access peterj directie
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
