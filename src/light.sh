#!/usr/bin/env bash

while true
do
  lighthouse bn --http \
  --testnet medalla >& ../log/light.log
  sleep 10
done
