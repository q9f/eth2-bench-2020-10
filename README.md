# Multi-client benchmark on Altona testnet 2020/07/16
Preliminary, high-level ETH2-client benchmarks.
- [x] Lighthouse
- [x] Prysm
- [x] Teku
- [x] Nimbus

_Work in progress..._

### Host systems (4x)
- Machine: Scaleway GP-BM1-S (bare metal)_
- OS: Ubuntu 20.04 LTS, kernel 5.4.0-40-generic #44-Ubuntu
- CPU: Intel Xeon E3-1240 v6, 8 cores
- RAM: 32 GB
- Disk: 250GB SSD

### Lighthouse
- `Lighthouse 0.1.2-fc5e6cbb(modified)`
- `master` @ fc5e6cbbb0f5c7ef139aeb76662ff21d995eeff5 (July/16, 2020)
- Rust `1.44.1`, Cargo `1.44.1`
- Built in `--release` mode
- Permalink: https://github.com/sigp/lighthouse/tree/fc5e6cbbb0f5c7ef139aeb76662ff21d995eeff5

### Prysm
- `Prysm/v1.0.0-alpha.15/df738517490fb7f21e434c1a47e706f774f45a4e. Built at: 2020-07-16 08:47:28+00:00`
- `master` @ df738517490fb7f21e434c1a47e706f774f45a4e (July/16, 2020)
- Go `1.13.8`, Bazel `3.4.1`
- Built in `--config=release` mode
- Permalink: https://github.com/prysmaticlabs/prysm/tree/df738517490fb7f21e434c1a47e706f774f45a4e

### Teku
- `teku/v0.12.2-dev-04b0a00a/linux-x86_64/-privatebuild-openjdk64bitservervm-java-14`
- `master` @ 04b0a00a27851e0ad154dc8f61103d89002120c9 (July/16, 2020)
- Java `14.0.1`, Gradle `6.5.1`
- Built in `installDist` mode
- Permalink: https://github.com/PegaSysEng/teku/tree/04b0a00a27851e0ad154dc8f61103d89002120c9

### Nimbus
- `Nimbus beacon node v0.5.0 (3dfbc31)`
- `devel` @ 3dfbc311ad7337c6a085e8328002cec5e9640394 (July/15, 2020)
- Nim `1.2.2`, Make `4.2.1`
- Built in `-d:release -d:insecure` mode
- Permalink: https://github.com/status-im/nim-beacon-chain/tree/3dfbc311ad7337c6a085e8328002cec5e9640394

### Altona testnet
- Spec version: `v0.12.1`
- Circa `120_000` slots filled with circa 90% blocks at start time
- 4 different clients known to validate the network
- 5 different clients known to connect and sync the network
- Permalink: https://github.com/goerli/altona/tree/a8f16766040710af30a03ce59d74bfca282ca78b

### Metrics collected
- `time`: Unix time in seconds
  - all: (Ruby) `Time.now.to_i`
- `db`: Database size in bytes
  - Lighthouse: (Shell) `du -bs $HOME/.lighthouse/beacon/chain_db/`
  - Prysm: (Shell) `du -bs $HOME/.eth2/beaconchaindata/`
  - Teku: (Shell) `du -bs $HOME/.local/share/teku/data/db/`
- `mem`: Resident memory in bytes
  - Lighthouse: (REST API) `/node/health`, `.pid_mem_resident_set_size`
  - Prysm: (Metrics) `process_resident_memory_bytes`
  - Teku: (Metrics) `process_resident_memory_bytes`
- `slot`: Head slot number in 1
  - Lighthouse: (REST API) `/beacon/head`, `.slot`
  - Prysm: (gRPC API) `/eth/v1alpha1/beacon/chainhead`, `.headSlot`
  - Teku: (REST API) `/beacon/head`, `.slot`
- `bps`: Slot sync each second in 1/second _(*)_
  - all: (Ruby) `(h.to_f - prev_h.to_f) / dt`
- `peers`: Peer count in 1
  - Lighthouse: (REST API) `/network/peer_count`
  - Prysm: (gRPC API) `/eth/v1alpha1/node/peers` _(counted)_
  - Teku: (REST API) `/network/peer_count`

_*) Note, due to different ways of processing incoming badges of blocks, this metric should be recomputed based on an average taken over 60 seconds._

### Metrics derived (TBD)
- Slot sync speed over time (moving average)
- Database size over sync time
- Database size over slot count (future projection: 1Y, 5Y)
- Resident memory usage over sync time
- Resident memory usage over time augmented with chain finality (external data)
