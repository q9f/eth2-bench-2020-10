#!/usr/bin/env bash

while true
do
  beacon-chain --altona --dev \
  --initial-sync-verify-all-signatures >& /root/gather/prysm.log
  sleep 10
done
