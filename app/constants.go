/*
 Copyright [2019] - [2021], ELYSIUM TECHNOLOGIES PTE. LTD. and the elysiumCore contributors
 SPDX-License-Identifier: Apache-2.0
*/

package app

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
)

const (
	Name             = "ElysiumCore"
	Bech32MainPrefix = "did:fury:e"
	CoinType         = 118
	Purpose          = 44

	Bech32PrefixAccAddr  = Bech32MainPrefix
	Bech32PrefixAccPub   = Bech32MainPrefix + sdk.PrefixPublic
	Bech32PrefixValAddr  = Bech32MainPrefix + sdk.PrefixValidator + sdk.PrefixOperator
	Bech32PrefixValPub   = Bech32MainPrefix + sdk.PrefixValidator + sdk.PrefixOperator + sdk.PrefixPublic
	Bech32PrefixConsAddr = Bech32MainPrefix + sdk.PrefixValidator + sdk.PrefixConsensus
	Bech32PrefixConsPub  = Bech32MainPrefix + sdk.PrefixValidator + sdk.PrefixConsensus + sdk.PrefixPublic
)
