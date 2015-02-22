#!/bin/bash
# this is the framework bash scripts used for the CentOS t_functional suite
#
# Description: this script sources our library functions and starts a test run.

echo -e "\n[+] `date` -> CentOS QA $0 starting."

# need to make sure we have functional dns
yum -d0 -y install bind-utils 

host repo.centos.qa > /dev/null
export SKIP_QA_HARNESS=$?

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

# Human friendly symbols
export readonly PASS=0
export readonly FAIL=1
# set debug level of yum install in t_InstallPackage
export YUMDEBUG=0

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

# exit on undefined variables
set -u

# process our test scripts
if [ $# -gt 0 ]; then
  t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/$1/ -type f|sort -t'/' )
else
  t_Process <(/usr/bin/find ./tests/0_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/p_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/r_*/ -type f|sort -t'/' )
  t_Process <(/usr/bin/find ./tests/z_*/ -type f|sort -t'/' )
fi

# and, we're done.
t_Log "Tests finished."
exit 0
