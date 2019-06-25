# DynSC: Dynamic Smart Contract

## Goal

Proof of Concept using **Hyperledger Fabric** and **Hyperledger Composer** to illustrate a research paper about dynamic smart-contracts for permissioned blockchains.

## Code snippet

The code available in this repository is developped and tested with *composer-playground*. It is composed of two main files: one model file *'dynsc.cto'* and one script file *'dynsc.js'*. These files are defining a small chaincode based on a simple use-case as a proof of concept. The *'dynsc.bna'* file is including the previous files, this is the smart contract exported by *composer* in a Business Archive Network.

## Usage

About the installation procedures of the tools you should refer to the official documentations:

 - [Hyperledger Fabric](https://hyperledger-fabric.readthedocs.io/en/release-1.4/index.html)
 - [Hyperledger Composer](https://hyperledger.github.io/composer/v0.19/introduction/introduction.html)
 - [Hyperledger Composer-Playground](https://hyperledger.github.io/composer/v0.19/playground/playground-index)

### Hyperledger Composer Playground

The first possibility, in a development purpose, is to use the *composer-playground* tool to directly import the BNA (or copy-paste the .cto and .js files). Then, you will be able to play and test the smart contract without dependencies.

```bash
$ composer-playground -p 8080
$ firefox http://localhost:8080
```

### Hyperledger Fabric and Composer

The second possibility, in a full test purpose, is to use the *composer* tool to deploy the chaincode from the *BNA* over a existing network instance of *Fabric* blockchain.

```bash
[Fabric] Starts network nodes...
$ docker-compose -f network.yaml up

[Composer] Deploys smart contract over nodes...
$ composer network install --card <card> --archiveFile dyn-sc.bna
$ composer network start --card <card> --networkName dyn-sc --networkVersion 0.1.0 -A <Admin> -S <AdminPassword>
```

*Note: It still possible to reimplement the smart contract / proof of concept directly over Hyperledger Fabric to avoid using Hyperledger Composer. It was just a choice in order to save our time.*

## Paper

To submit...


