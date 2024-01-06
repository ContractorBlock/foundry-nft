# 🙂 Mood NFT - a fully onchain NFT

A dynamic (fully onchain) SVG NFT that updates in real-time when a function on the smart contract is called.

You can see this smart contract deployed [on Sepolia](https://sepolia.etherscan.io/address/0x4381901C2Fd0B689cF02CbD6e7d88608D5FfD656).

## ⚒️ Built with Foundry

This project is built with [Foundry](https://github.com/foundry-rs/foundry) a portable and modular toolkit for Ethereum application development, which is required to build and deploy the project.

## 🏗️ Getting started

Create a `.env` file with the following entries:

```
SEPOLIA_RPC_URL=<sepolia_rpc_url>
PRIVATE_KEY=<private_key>
ETHERSCAN_API_KEY=<etherscan_api_key>
```

Install project dependencies

```
make install
```

Deploy the smart contract on Anvil

```
make anvil
make deploy
```

Deploy the smart contract on Sepolia

```
make deploy ARGS="--network sepolia"
```

## 🧪 Running tests

To run against a local Anvil Ethereum node:

```
forge test
```

To run against a forked environment (e.g. a forked Sepolia testnet):

```
forge test --fork-url <sepolia_rpc_url>

# Thank you!

If you appreciated this, feel free to follow me or donate!

ETH/Arbitrum/Optimism/BNB Smart chain/Avalanche/Polygon Address: 0xE25371455a8A1eEba4f16Bb17c4EBe91e0a64942
```
