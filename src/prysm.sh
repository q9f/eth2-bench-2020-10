#!/usr/bin/env bash

while true
do
  beacon-chain --altona --dev >& /root/gather/prysm.log
  sleep 10
done
