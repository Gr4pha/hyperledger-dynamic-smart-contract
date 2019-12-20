# Dynamic Parameterization pattern over Hyperledger Fabric with Convector and Hurley

---


## Installation

```bash
# apt install nodejs npm docker docker-compose
$ npm install -g @worldsibu/convector
$ npm install -g @worldsibu/hurley
$ npm install -g npx
```


---


## Testing the install and config

### 0. Project generated by Convector

	$ conv new <project-name> -c <smart-contract-name>

### 1. Runs Hurley: development blockchain

	$ cd <project-path>
	$ npm run env:restart

### 2. Deploys the Smart Contracts with Hurley

	$ npm run cc:start dynsc

### 3. Processes a transaction with Hurley

	$ hurl invoke <smart-contrac> <smart-contract>_<transaction> [<json-arguments>] [-u <user>] [-o <organization>]


---


## Launching the benchmarks

```bash
$ cd <project-path>
$ time -p ./scripts/all_bench.sh 2>logs/err.log >> logs/bench.log
```

No console output, just wait the end of it. Logs can be seen during or after the end of the bench.

See _'scripts/*'_ to adapt the bench as defined into _'bench.js'_ and _'all_bench.sh'_.

Refer to files in _'logs/*'_ to get our results.


---

