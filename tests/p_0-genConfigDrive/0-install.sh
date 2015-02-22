#!/bin/bash

# make sure we have all the things needed to build the iso

t_Log "$0 - installing GenConfigDrive componnets"


if [ $centos_ver -lt 6 ]; then
  t_Log "This test suite will only run on CentOS 6 or CentOS 7. Aborting!"
  t_CheckExitStatus 0
  exit $PASS
fi

t_InstallPackage openssh genisoimage
