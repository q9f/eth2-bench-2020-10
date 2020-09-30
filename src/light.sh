#!/usr/bin/env bash

while true
do
  lighthouse bn --http --eth1 \
  --datadir /data/lighthouse \
  --testnet medalla \
  --eth1-endpoint http://127.0.0.1:8545 >& ../log/light.log
  sleep 10
done
