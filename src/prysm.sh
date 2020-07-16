#!/usr/bin/env bash

while true
do
  beacon-chain --altona --dev \
  --http-web3provider http://127.0.0.1:8545 >& /root/gather/prysm.log
  sleep 10
done
