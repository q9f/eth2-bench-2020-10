# Multi-client benchmark on Medalla testnet 2020/10/01
Preliminary, high-level ETH2-client benchmarks.
- [x] Lighthouse
- [x] Prysm
- [x] Teku
- [x] Nimbus
- [ ] Lodestar

PDF: no

no preview

### Host systems (4x)
- Machine: Scaleway HC-BM1-S (bare metal)
- OS: Ubuntu 20.04 LTS, kernel 5.4.0-48-generic #52-Ubuntu
- CPU: Intel Xeon Silver 4114, 20 cores
- RAM: 128 GB
- Disk: 1TB NMVe

### Lighthouse
- `Lighthouse v0.2.13-c0e76d2c`
- https://github.com/sigp/lighthouse/releases/tag/v0.2.13
- Rust `1.46.0`, Cargo `1.46.0`
- Built in `--release` mode

### Prysm
- `Prysm/v1.0.0-alpha.27/eb3e4944e9ee4c69bbec0866c3ecdf6cd44cfcc3. Built at: 2020-09-30 10:28:14+00:00`
- https://github.com/prysmaticlabs/prysm/releases/tag/v1.0.0-alpha.27
- Go `1.13.8`, Bazel `3.5.0`
- Built in `--config=release` mode

### Teku
- `teku/v0.12.8/linux-x86_64/-privatebuild-openjdk64bitservervm-java-14`
- https://github.com/PegaSysEng/teku/releases/tag/0.12.8
- Java `14.0.1`, Gradle `6.5.1`
- Built in `installDist` mode

### Nimbus
- `Nimbus beacon node v0.5.0 (78ceeed8)`
- `master` @ 78ceeed8042d6b70d9c1aae09688d43ff79db6e2 (Sept/29, 2020)
- Nim `1.2.6`, Make `4.2.1`
- Built in `-d:release -d:insecure` mode
- Permalink: https://github.com/status-im/nim-beacon-chain/tree/78ceeed8042d6b70d9c1aae09688d43ff79db6e2

### Medalla testnet
- Spec version: `v0.12.2`
- Circa `410_000` slots start time
- 4 different clients known to validate the network
- 5 different clients known to connect and sync the network
- Permalink: https://github.com/goerli/medalla/tree/6e600540833523b3f411386e5c5d51a7ecfd7a5a

### Metrics collected
- `time`: Unix time in seconds
  - all: (Ruby) `Time.now.to_i`
- `db`: Database size in bytes
  - Lighthouse: (Shell) `du -bs /data/lighthouse/beacon/chain_db/`
  - Prysm: (Shell) `du -bs /data/prysm/beaconchaindata/`
  - Teku: (Shell) `du -bs /data/teku/data/db/`
  - Nimbus: (Shell) `du -bs /data/nimbus/db/`
- `mem`: Resident memory in bytes
  - Lighthouse: (REST API) `/node/health`, `.pid_mem_resident_set_size`
  - Prysm: (Metrics) `process_resident_memory_bytes`
  - Teku: (Metrics) `process_resident_memory_bytes`
  - Nimbus: (Metrics) `process_resident_memory_bytes`
- `slot`: Head slot number in 1
  - Lighthouse: (REST API) `/beacon/head`, `.slot`
  - Prysm: (gRPC API) `/eth/v1alpha1/beacon/chainhead`, `.headSlot`
  - Teku: (REST API) `/beacon/head`, `.slot`
  - Nimbus: (RPC) `getBeaconHead`, `.result`
- `peers`: Peer count in 1
  - Lighthouse: (REST API) `/network/peer_count`
  - Prysm: (gRPC API) `/eth/v1alpha1/node/peers` _(counted)_
  - Teku: (REST API) `/network/peer_count`
  - Nimbus: (RPC) `getNetworkPeers`

_All other metrics are derived._
