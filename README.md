nix-shell

empty_contract: 0x0404502076d61b58697bb1f2d7f9a1e5f0b3b45b2b3da76fd589662da42c7edf

empyt_public: 0x008bb40fa629fb353886822b922fde3e8bf0ce6ad5936f079f9e8a657f918251

installation

export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount



compile contract
starknet-compile contract.cairo --output contract_compiled.json --abi contract_abi.json

deploy contract
starknet deploy --contract contract_compiled.json

interact with write function
starknet invoke --address ${CONTRACT_ADDRESS} --abi contract_abi.json --function increase_balance --inputs 1234

interact with read function
starknet call  --address ${CONTRACT_ADDRESS} --abi contract_abi.json  --function get_balance

checking tx status
starknet tx_status --hash TRANSACTION_HASH

get tx information
starknet get_transaction --hash TRANSACTION_HASH

get tx information more
starknet get_transaction_receipt --hash TRANSACTION_HASH

estimate fee
starknet estimate_fee --address CONTRACT_ADDRESS --abi contract_abi.json --function increase_balance --inputs 1234

get code
starknet get_code --contract_address CONTRACT_ADDRESS

get block
starknet get_block --number BLOCK_NUMBER

get storage at
​​from starkware.starknet.public.abi import get_storage_var_address
balance_key = get_storage_var_address('balance')
print(f'Balance key: {balance_key}')
starknet get_storage_at --contract_address CONTRACT_ADDRESS --key KEY