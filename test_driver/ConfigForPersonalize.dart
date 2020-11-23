// МНЕ ЗА ЭТУ РАЗРАБОТКУ ТАКУЮ ПРЕМИЮ ДАДУТ ООООООЙЙЙ
class ConfigForPersonalize{
  returnConfig(configName) async {

    Map mapper = {
      //Personalize (all settingMask =true, Note)
      //Read card (all settingMask =true, Note)
      "config1": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": true,
        "allowSetPIN1": true,
        "allowSetPIN2": true,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "BTC",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3OnCard": true,
        "count": 0,
        "createWallet": 0,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": true,
        "prohibitDefaultPIN1": true,
        "prohibitPurgeWallet": true,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": true,
        "allowFastEncryption": true,
        "allowUnencrypted ": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": true,
        "requireTerminalTxSignature": true,
        "restrictOverwriteIssuerExtraData": true,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": true,
        "skipSecurityDelayIfValidatedByIssuer": true,
        "skipSecurityDelayIfValidatedByLinkedTerminal": true,
        "smartSecurityDelay": true,
        "startNumber": 03000000000004,
        "useActivation": true,
        "useBlock": true,
        "useCvc": true,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": true
    },

      //Personalize(all settingMask =false)
      //Read card (all settingMask =false)
      //Read card (status=Purged)
      //PurgeWallet (createWallet=1, isReusable=false)
      //Read UserData
      //Sign carf
      "config2": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "XLM",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "ed25519",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": false,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 0,
        "protectIssuerDataAgainstReplay": false,
        "allowFastEncryption": false,
        "allowUnencrypted": false,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": false,
        "useNDEF": false,
        "useOneCommandAtTime": false
      },

      //Personalize (Token)
      //Read card (Token)
      //PurgeWallet (createWallet=1, isReusable=true)
      "config3": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "BINANCE",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false,
          "token_contract_address": "BUSD-BD1",
          "token_decimal": 8,
          "token_symbol": "BUSD"
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": false,
        "allowFastEncryption": true,
        "allowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": true,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": false
      },

      //Create wallet (createWallet= 0)
      //Depersonalize
      "config4": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "XLM",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 0,
        "curveID": "ed25519",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": false,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 0,
        "protectIssuerDataAgainstReplay": false,
        "allowFastEncryption": false,
        "allowUnencrypted": false,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": false,
        "useNDEF": false,
        "useOneCommandAtTime": false
      },

      //Personalize (ID-card)
      //Read card (ID-card)
      "config5": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "ETH",
          "date": "",
          "product_id_card": true,
          "product_id_issuer": false,
          "product_note": false,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": true,
        "allowFastEncryption": true,
        "allowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": true,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": false
      },

      //Personalize (ID-Issuer card)
      //Read (ID-Issuer card)
      "config6": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "ETH",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": true,
          "product_note": false,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": false,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 0,
        "protectIssuerDataAgainstReplay": false,
        "allowFastEncryption": false,
        "allowUnencrypted": false,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": false,
        "useNDEF": false,
        "useOneCommandAtTime": false
      },

      //Write and Read UserData
      //Write and Read ProtectedUserData
      "config7": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "BTC",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": true,
        "allowFastEncryption": true,
        "allowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": false,
        "useNDEF": false,
        "useOneCommandAtTime": false
      },

      //Personalize (Tangem TAG)
      //Read (Tangem TAG)
      "config8": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "ETH",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": false,
          "product_tag": true,
          "token_contract_address": "0x4E7Bd88E3996f48E2a24D15E37cA4C02B4D134d2",
          "token_decimal": 18,
          "token_symbol": "NFT: Tangem TAG"
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": false,
        "allowFastEncryption": true,
        "allowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": false,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": true,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": false
      },

      //you can edit
      "config9": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSetPIN1": false,
        "allowSetPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "BTC",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3OnCard": false,
        "count": 0,
        "createWallet": 0,
        "curveID": "secp256k1",
        "disablePrecomputedNDEF": false,
        "prohibitDefaultPIN1": false,
        "prohibitPurgeWallet": false,
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "isReusable": true,
        "issuerName": "",
        "ndef": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ],
        "numberFormat": "",
        "pauseBeforePIN2": 5000,
        "protectIssuerDataAgainstReplay": true,
        "allowFastEncryption": true,
        "allowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerExtraData": true,
        "series": "BB",
        "skipCheckPIN2CVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCvc": false,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": false
      },

      //IssuerTangem
      "issuerConfig1": {
          "name": "TANGEM SDK",
          "id": "TANGEM SDK"+"\u0000",
          "dataKeyPair": {
            "publicKey": "045F16BD1D2EAFE463E62A335A09E6B2BBCBD04452526885CB679FC4D27AF1BD22F553C7DEEFB54FD3D4F361D14E6DC3F11B7D4EA183250A60720EBDF9E110CD26",
            "privateKey": "11121314151617184771ED81F2BACF57479E4735EB1405083927372D40DA9E92"
          },
          "transactionKeyPair": {
            "publicKey": "0484c5192e9bfa6c528a344f442137a92b89ea835bfef1d04cb4362eb906b508c5889846cfea71ba6dc7b3120c2208df9c46127d3d85cb5cfbd1479e97133a39d8",
            "privateKey": "11121314151617184771ED81F2BACF57479E4735EB1405081918171615141312"
          }
        }


    };

    return mapper[configName];
  }
}