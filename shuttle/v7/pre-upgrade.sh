#!/bin/bash
set -o errexit -o nounset -o pipefail -eu

DIRNAME="$(dirname $(realpath ${BASH_SOURCE[0]}))"

if [ ! -f "$DIRNAME/../../build/elysiumCoreV6" ]; then
  echo "could not find build/elysiumCoreV6 binary"
  exit 1
fi

echo "Replacing local elysiumCore binary with v6 binary"
cp $DIRNAME/../../build/elysiumCoreV6 ~/go/bin/elysiumCore

ELYSIUM_KEY="elysiumCore keys -a --keyring-backend=test show"
ELYSIUM_BALANCE="elysiumCore q bank balances"
GAIA_KEY="gaiad keys -a --keyring-backend=test show"
GAIA_BALANCE="gaiad q bank balances"

echo "=> Getting IBC channel info"
CHANNEL_INFO=$(elysiumCore q ibc channel channels -o json | jq 'first(.channels[] | select(.state == "STATE_OPEN") | select(.port_id == "transfer"))')

echo "=> Channel info:"
echo $CHANNEL_INFO | jq

if [[ -z $CHANNEL_INFO ]]; then
    echo "No open transfer port and connection... exiting";
    exit 1;
fi

ELYSIUM_PORT="$(echo $CHANNEL_INFO | jq -r '.port_id')"
ELYSIUM_CHANNEL="$(echo $CHANNEL_INFO | jq -r '.channel_id')"

check_balance() {
  echo "elysium val1: $($ELYSIUM_BALANCE $($ELYSIUM_KEY val1) | jq -r '.balances')"
  echo "elysium val2: $($ELYSIUM_BALANCE $($ELYSIUM_KEY val2) | jq -r '.balances')"
  echo "gaia val1: $($GAIA_BALANCE $($GAIA_KEY val1) | jq -r '.balances')"
  echo "gaia val2: $($GAIA_BALANCE $($GAIA_KEY val2) | jq -r '.balances')"
}

gaia_transfer() {
  let "uatoms=$1 * 1000000"
  echo "=> Transfer $1 atom from gaia:$2 to elysium:$3"
  gaiad tx ibc-transfer transfer "$ELYSIUM_PORT" "$ELYSIUM_CHANNEL" \
    $($ELYSIUM_KEY $3) --fees 5000uatom "$uatoms"uatom \
    --from "$2" --gas auto --gas-adjustment 1.2 -y --keyring-backend test \
    -b block -o json | jq -r '{height, txhash, code, raw_log}'
}

echo "=> Balances before transfer"
check_balance

echo "=> IBC Transfer atom from gaia to elysium"
gaia_transfer 1 val1 val1
gaia_transfer 15 val1 val2
gaia_transfer 150 val2 val2

echo "=> Wait for a bit to let ibc-transfer happen"
sleep 4

echo "=> Balances after transfer"
check_balance

echo "=> Testing wasm contract"
bash -e $DIRNAME/contract.sh
