# elysiumCore

[![LoC](https://tokei.rs/b1/github/merlin-network/elysiumCore)](https://github.com/merlin-network/elysiumCore)

This project implements an application for the Elysium Core chain that all the other chains in the ecosystem connect
to as a raised and open moderator for interoperability, shared security, and as a gateway to other ecosystems and
chains.

## Talk to us!

* [Twitter](https://twitter.com/ElysiumOne)
* [Telegram](https://t.me/ElysiumOneChat)
* [Discord](https://discord.com/channels/796174129077813248)

## Hardware Requirements

* **Minimal**
    * 1 GB RAM
    * 25 GB HDD
    * 1.4 GHz CPU
* **Recommended**
    * 2 GB RAM
    * 100 GB HDD
    * 2.0 GHz x2 CPU

> NOTE: SSDs have limited TBW before non-catastrophic data errors. Running a full node requires a TB+ writes per day,
> causing rapid deterioration of SSDs over HDDs of comparable quality.

## Operating System

* Linux/Windows/MacOS(x86)
* **Recommended**
    * Linux(x86_64)

## Installation Steps

> Prerequisite: go1.19.3+ required. [ref](https://golang.org/doc/install)

> Prerequisite: git. [ref](https://github.com/git/git)

> Optional requirement: GNU make. [ref](https://www.gnu.org/software/make/manual/html_node/index.html)

* Clone git repository

```shell
git clone https://github.com/merlin-network/elysiumCore.git
```

* Checkout release tag

```shell
git fetch --tags
git checkout [vX.X.X]
```

* Install

```shell
cd elysiumCore
make all
```

### Generate keys

`elysiumCore keys add [key_name]`

or

`elysiumCore keys add [key_name] --recover` to regenerate keys with
your [BIP39](https://github.com/bitcoin/bips/tree/master/bip-0039) mnemonic

### Connect to a chain and start node

* [Install](#installation-steps) elysiumCore application
* Initialize node

```shell
elysiumCore init [NODE_NAME]
```

* Replace `${HOME}/.elysiumCore/config/genesis.json` with the genesis file of the chain.
* Add `persistent_peers` or `seeds` in `${HOME}/.elysiumCore/config/config.toml`
* Start node

```shell
elysiumCore start
```

### Initialize a new chain and start node

* Initialize: `elysiumCore init [node_name] --chain-id [chain_name]`
* Add key for genesis account `elysiumCore keys add [genesis_key_name]`
* Add genesis account `elysiumCore add-genesis-account [genesis_key_name] 10000000000000000000stake`
* Create a validator at genesis `elysiumCore gentx [genesis_key_name] 10000000stake --chain-id [chain_name]`
* Collect genesis transactions `elysiumCore collect-gentxs`
* Start node `elysiumCore start`
* To start rest server set `enable=true` in `config/app.toml` under `[api]` and restart the chain

### Ledger Support

> NOTE: *If you are using Cosmos Ledger app*: Elysium uses coin-type 750; generating keys through this method below
> will create keys with coin-type 118(cosmos) and will only be supported by CLI and not by current or future wallets.

* Install the Elysium application on the Ledger
  device. [ref](https://github.com/merlin-network/elysiumCore/blob/main/docs/resources/Ledger.md#install-the-elysium-ledger-application)
* Connect the Ledger device to a system with elysiumCore binary and open the Elysium application on it.
* Add key

```shell
elysiumCore keys add [key_name] --ledger
```

* Sign transaction

```shell
elysiumCore tx [transaction parameters] --ledger
```

### Reset chain

```shell
rm -rf ~/.elysiumCore
```

### Shutdown node

```shell
killall elysiumCore
```

### Check version

```shell
elysiumCore version
```

## Test-nets

* [test-core-1](https://github.com/merlin-network/genesisTransactions/tree/master/test-core-1)

## Main-net

* [core-1](https://github.com/merlin-network/genesisTransactions/tree/master/core-1)
