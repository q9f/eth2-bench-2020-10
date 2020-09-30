#!/usr/bin/env bash

while true
do
  beacon-chain --medalla \
  --http-web3provider http://127.0.0.1:8545 >& ../log/prysm.log
  sleep 10
done
