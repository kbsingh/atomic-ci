#!/bin/bash

ret_val=0
URL="http://buildlogs.centos.org/rolling/7/isos/x86_64/CentOS-7-x86_64-AtomicHost.qcow2.xz"
curl -O $URL
if [ $? -ne 0; then
  ret_val=1
  echo 'Failed to download image. Aborting!'
fi

fname=$(basename $URL)
fsize=$(du -k $fname | cut -f1 -d\  )

if [ $fsize -lt 200000 ]; then
  echo 'Downloaded filesize too small, Aborting!'
  ret_val=1
fi

if [ `file ${fname} | grep 'XZ compressed data' | wc -l ` -lt 1 ];then
  echo 'Downloaded file is not an XZ archieve, Aborting!'
  ret_val=1
fi


if [ $ret_val -ne 0; then
  ret_val=1
  echo 'Failed to download image. Aborting!'
  t_CheckExitStatus $FAIL
  exit $FAIL
fi
