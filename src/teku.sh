#!/usr/bin/env bash

while true
do
  teku --config-file="./teku.yaml" \
    --network="medalla" &> ../log/teku.log
  sleep 10
done
