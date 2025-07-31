# DepositRangeTrap (Drosera)

A custom Drosera Trap contract that:
- Accepts ETH deposits.
- Refunds users if the deposit is below min or above max thresholds.
- Uses Drosera’s collect/shouldRespond/respond interface.

## Deploy
```bash
forge script script/DeployDepositRangeTrap.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

## Test
```bash
forge test
```

## Run Trap via Drosera CLI
```bash
drosera apply
```

---

## 📦 .env Setup & Usage

### 1. Rename `.env.example` to `.env`

```bash
mv .env.example .env
```

### 2. Fill In Environment Variables

```env
PRIVATE_KEY=0xabc123...                          # Dev wallet private key
RPC_URL=https://mainnet.infura.io/v3/YOUR_ID     # RPC provider
ETHERSCAN_API_KEY=your_etherscan_api_key         # Optional
```

### 3. Foundry Automatically Uses It

The deploy script will automatically pull:

```solidity
uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
```

Run:

```bash
forge script script/DeployDepositRangeTrap.s.sol --rpc-url $RPC_URL --broadcast
```

### 4. Drosera CLI

Either set directly:

```bash
DROSERA_PRIVATE_KEY=0xabc123... drosera apply
```

Or use the same key in `drosera.toml`:

```toml
private_key = "0xabc123..."
rpc_url = "https://..."
```

> ⚠️ Never commit your `.env` to version control. Always add it to `.gitignore`.
