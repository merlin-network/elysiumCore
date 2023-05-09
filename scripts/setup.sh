#!/bin/bash
scripts/reset.sh

test_mnemonic="wage thunder live sense resemble foil apple course spin horse glass mansion midnight laundry acoustic rhythm loan scale talent push green direct brick please"

elysiumCore init test --chain-id test
echo $test_mnemonic | elysiumCore keys add test --recover --keyring-backend test
elysiumCore add-genesis-account test 100000000000000ufury,100000000000000stake --keyring-backend test
elysiumCore gentx test 10000000stake --chain-id test --keyring-backend test
elysiumCore collect-gentxs