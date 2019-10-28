# Satellite Design Pattern over Ethereum with Truffle and Ganache

---


## Installation

```bash
# apt install nodejs npm
$ npm install -g truffle
$ npm install -g ganache-cli
$ npm install web3 && npm install truffle-contract
```


---


## Configuration

```bash
$ cd <project-path>
$ nano truffle-config.js
[...]
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
[...]
```


---


## Testing the install and config

### 1. Runs Ganache: development blockchain

Block time mining each 15 seconds.

	$ ganache-cli -b 15 --defaultBalanceEther 100000 --gas0x2FEFD800000 > ganache.log

### 2. Deploys the Smart Contracts with Truffle over Ganache

	$ truffle deploy --reset

### 3. Runs NodeJS script within Truffle

	$ truffle exec <script-filepath.js>


---


## Launching the benchmarks

```bash
$ cd <project-path>
$ time -p ./scripts/all_bench.sh 2>logs/err.log >> logs/bench.log
```

No console output, just wait the end of it. Logs can be seen during or after the end of the bench.

See _'scripts/*'_ to adapt the bench as defined into *'bench.js'* and *'all_bench.sh'*.

Refer to files in _'logs/*'_ to get our results.


---


