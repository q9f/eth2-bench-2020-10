#!/usr/bin/env bash

while true
do
  lighthouse bn --http >& /root/gather/light.log
  sleep 10
done
