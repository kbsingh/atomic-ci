#!/bin/bash


t_Log "$0 - Downloading Atomic Host image"

if [ $centos_ver -lt 6 ]; then
  t_Log "This test suite will only run on CentOS 6 or CentOS 7. Aborting!"
  t_CheckExitStatus 1
  exit $FAIL
fi

# make sure we have enough diskspace to make this work 
dspace=$(df . | awk '/[0-9]%/{print $(NF-2)}')
if [ $dspace -lt 8388608 ]; then
  echo 'We need atleast 4GB of disk space to make this work. Abort!'
  t_CheckExitStatus 1
  exit $FAIL
fi


t_InstallPackage curl unxz 
