# Ethernaut CTF Challenges with Foundry

This repository provides a minimal environment to solve the [Ethernaut CTF challenges](https://ethernaut.openzeppelin.com/) using [Foundry](https://book.getfoundry.sh/). It includes the original smart contracts and prepared tests for each challenge.

## Project Structure

The repository comprises two primary branches:

- **main**: Contains the base environment for attempting the challenges.
- **solutions**: Houses my completed solutions for the challenges.

## Installation and Setup

To begin, install Foundry by executing:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

After installation, initialize Foundry with:

```bash
foundryup
```

For comprehensive installation instructions, refer to the [Foundry installation guide](https://book.getfoundry.sh/getting-started/installation).

## Engaging with the Challenges

1. **Create a new branch from `main`**:

   ```bash
   git checkout -b my-solution-branch main
   ```

2. **Develop your solution**:

   - Navigate to the test file for the specific challenge in `test/<challenge-name>.t.sol`.
   - Implement your solution within the `testSolution` function.

3. **Execute the test**:

   Run the following command to test your solution:

   ```bash
   forge test --match-contract <SolutionContractName>
   ```

   For instance, to test the "Fallback" challenge:

   ```bash
   forge test --match-contract TestFallback
   ```

## Challenges

Below is a list of challenges included in this repository. Challenges with solutions in the `solutions` branch are linked accordingly.
| [Fallback](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/01_Fallback.t.sol) ✅ | [Fallout](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/02_Fallout.t.sol) ✅ | [Coin Flip](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/03_CoinFlip.t.sol) ✅ | [Telephone](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/04_Telephone.t.sol) ✅ | [Token](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/05_Token.t.sol) ✅ |
| :--- | :--- | :--- | :--- | :--- |
| [Delegation](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/06_Delegation.t.sol) ✅ | [Force](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/07_Force.t.sol) ✅ | [Vault](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/08_Vault.t.sol) ✅ | [King](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/09_King.t.sol) ✅ | [Re-entrancy](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/10_Reentrance.t.sol) ✅ |
| [Elevator](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/11_Elevator.t.sol) ✅ | [Privacy](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/12_Privacy.t.sol) ✅ | [Gatekeeper One](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/13_GatekeeperOne.t.sol) ✅ | [Gatekeeper Two](https://github.com/vesla0x1/ethernaut-foundry/tree/solutions/test/14_GatekeeperTwo.t.sol) ✅ | [Naught Coin](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/15_NaughtCoin.sol) ✅ |
| [Preservation](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/16_Preservation.sol) ✅ | [Recovery](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/17_Recovery.sol) ✅ | [MagicNumber](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/18_MagicNumber.sol) ✅ | [Alien Codex](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/19_AlienCodex.sol) ✅ | [Denial](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/20_Denial.sol) ✅  |
| [Shop](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/21_Shop.sol) ✅ | [Dex](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/22_Dex.sol) ✅  | [Dex Two](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/23_DexTwo.sol) ✅  | [Puzzle Wallet](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/24_PuzzleWallet.sol) ✅ | [Motorbike](https://github.com/vesla0x1/ethernaut-foundry/blob/solutions/test/25_Motorbike.sol) ✅ |
| DoubleEntryPoint | Good Samaritan | Gatekeeper Three | Switch | HigherOrder |
| Stake | Impersonator | Magic Animal Carousel | | |

Feel free to explore and contribute to the solutions. Happy hacking! 
