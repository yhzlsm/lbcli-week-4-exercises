# Create a raw transaction and add this message in it: "btrust builder 2025"

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below

transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

recipient=2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP

amount=0.2

utxo_txid_1=$(bitcoin-cli -regtest decoderawtransaction $transaction | jq -r '.txid')
utxo_vout_1=$(bitcoin-cli -regtest decoderawtransaction $transaction | jq -r '.vout[0].n')
utxo_txid_2=$(bitcoin-cli -regtest decoderawtransaction $transaction | jq -r '.txid')
utxo_vout_2=$(bitcoin-cli -regtest decoderawtransaction $transaction | jq -r '.vout[1].n')

op_return_data=$(echo -n "btrust builder 2025" | xxd -p)

inputs='[{"txid":"'$utxo_txid_1'","vout":'$utxo_vout_1'},{"txid":"'$utxo_txid_2'","vout":'$utxo_vout_2'}]'

outputs='[{"data":"'$op_return_data'"}, {"'$recipient'":'$amount'}]'

rawtransaction=$(bitcoin-cli -regtest createrawtransaction "$inputs" "$outputs")

echo "$rawtransaction"