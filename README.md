Name: Ewerton Barbosa
Student ID: 101233365

Final Assignment Advanced Smart Contracts

This is an project to simulate an Airdrop with Merkle Tree concept. This proccess was tested on Remix using Ropten Network to test it. At this moment the tests using Truffle are not completed yet.

To replicate the steps you should access Remix and deploy the ERC20.sol and transfer the minted tokens to your wallet. 
After that deploy the Airdrop.sol and send the Merkle Root hash to create the contract. The files to create the Merkle Root are included in this project.
After deployed it is necessary to transfer the tokens your wallet holds to the contract using transfer{} function
The goal is to transfer the tokens to the addresses included in the address.txt file.

Data Structure:
MerkleRoot: hash of the Merkle Root

_name: local variable with the name of the token
_symbol: name of the token
_decimals: how many decimals it is 
_totalSupply: How many tokens could be minted
The best way to use these variables is if you want to mint tokens without using another contract and transfer all tokens to a specific address or the contract.

Storage
mapping sent: Validate addresses that received tokens
mapping balances: Store the balance of an specific address

Events:
The events were created in an attempt to create an front end (Dapp) to sent the arguments and allow multiple users to use the airdrop.

Modifier:
onlyOwner: Change the owner of the contract

Functions:
transfer(): Transfer the balance to contract
leafHash and nodeHash: Hashes from Merkle Root to validade the node and the leaf
setRoot(): change the Merkle tree if needed it
getTokenBalance(): return the balance of a specific address
abortAirdrop(): Stop the Airdrop proccess
getTokens(): works as an redeem tokens, validate the Merkle Tree and transfer the tokens

To test: npm test