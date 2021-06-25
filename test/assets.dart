final json = '''
{
  "setup": {
    "name": "Twins",
    "description": "Two test iterations with two steps iterations",
    "personalizationConfig": {
      "config": {
        "issuerName": "TANGEM SDK",
        "acquirerName": "Smart Cash",
        "series": "BB",
        "startNumber": 300000000000,
        "count": 0,
        "pin": "000000",
        "pin2": "000",
        "pin3": "",
        "hexCrExKey": "00112233445566778899AABBCCDDEEFFFFEEDDCCBBAA998877665544332211000000111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFF",
        "cvc": "000",
        "pauseBeforePin2": 5000,
        "smartSecurityDelay": true,
        "curveID": "Secp256k1",
        "signingMethods": [
          "SignHash"
        ],
        "maxSignatures": 999999,
        "isReusable": true,
        "allowSetPIN1": true,
        "allowSetPIN2": true,
        "useActivation": false,
        "useCvc": false,
        "useNDEF": true,
        "useDynamicNDEF": true,
        "useOneCommandAtTime": false,
        "useBlock": false,
        "allowSelectBlockchain": true,
        "prohibitPurgeWallet": false,
        "allowUnencrypted": true,
        "allowFastEncryption": true,
        "protectIssuerDataAgainstReplay": false,
        "prohibitDefaultPIN1": false,
        "disablePrecomputedNDEF": false,
        "skipSecurityDelayIfValidatedByIssuer": true,
        "skipCheckPIN2CVCIfValidatedByIssuer": true,
        "skipSecurityDelayIfValidatedByLinkedTerminal": true,
        "restrictOverwriteIssuerExtraData": false,
        "requireTerminalTxSignature": false,
        "requireTerminalCertSignature": false,
        "checkPIN3OnCard": false,
        "createWallet": true,
        "walletsCount": 1,
        "cardData": {
          "batchId": "FFFF",
          "blockchainName": "ETH",
          "issuerName": "TANGEM SDK",
          "manufacturerSignature": null,
          "manufactureDateTime": "2021-06-22",
          "productMask": [
            "Note"
          ]
        },
        "ndefRecords": [
          {
            "type": "AAR",
            "value": "com.tangem.wallet"
          },
          {
            "type": "URI",
            "value": "https://tangem.com"
          }
        ]
      },
      "issuer": {
        "name": "TANGEM SDK",
        "id": "TANGEM SDK",
        "dataKeyPair": {
          "publicKey": "045f16bd1d2eafe463e62a335a09e6b2bbcbd04452526885cb679fc4d27af1bd22f553c7deefb54fd3d4f361d14e6dc3f11b7d4ea183250a60720ebdf9e110cd26",
          "privateKey": "11121314151617184771ED81F2BACF57479E4735EB1405083927372D40DA9E92"
        },
        "transactionKeyPair": {
          "publicKey": "0484c5192e9bfa6c528a344f442137a92b89ea835bfef1d04cb4362eb906b508c5889846cfea71ba6dc7b3120c2208df9c46127d3d85cb5cfbd1479e97133a39d8",
          "privateKey": "11121314151617184771ED81F2BACF57479E4735EB1405081918171615141312"
        }
      },
      "acquirer": {
        "name": "Smart Cash",
        "id": "Smart Cash",
        "keyPair": {
          "publicKey": "0456ad1a82b22bcb40c38fd08939f87e6b80e40dec5b3bdb351c55fcd709e47f9fb2ed00c2304d3a986f79c5ae0ac3c84e88da46dc8f513b7542c716af8c9a2daf",
          "privateKey": "21222324252627284771ED81F2BACF57479E4735EB1405083927372D40DA9E92"
        }
      },
      "manufacturer": {
        "name": "Tangem",
        "keyPair": {
          "publicKey": "04bab86d56298c996f564a84fc88e28aed38184b12f07e519113bef48c76f3df3adc303599b08ac05b55ec3df98d9338573a6242f76f5d28f4f0f364e87e8fca2f",
          "privateKey": "1b48cfd24bbb5b394771ed81f2bacf57479e4735eb1405083927372d40da9e92"
        }
      }
    },
    "sdkConfig": {},
    "minimalFirmware": null,
    "platform": null,
    "iterations": 2,
    "creationDateMs": 1624407062610
  },
  "steps": [
    {
      "name": "Scan card 1",
      "method": "SCAN_TASK",
      "parameters": {},
      "expectedResult": {
        "cardId": "BB03000000000004",
        "manufacturerName": "TANGEM",
        "status": "Loaded",
        "firmwareVersion": {
          "version": "3.37d SDK"
        },
        "cardPublicKey": "0497C0424AF7BF8CE9920CB90EDAC2010FDED904937BC6D1D6E82E9254E0EFE4D4FDF355BB16BD0E9550D8BE5AB741B897FBC70360E99A86B97BA7DCC2FBF77D7E",
        "defaultCurve": "Secp256k1",
        "settingsMask": [
          "IsReusable",
          "AllowSetPIN1",
          "AllowSetPIN2",
          "UseNDEF",
          "UseDynamicNDEF",
          "SmartSecurityDelay",
          "AllowUnencrypted",
          "AllowFastEncryption",
          "AllowSelectBlockchain",
          "SkipSecurityDelayIfValidatedByLinkedTerminal",
          "SkipCheckPIN2CVCIfValidatedByIssuer",
          "SkipSecurityDelayIfValidatedByIssuer"
        ],
        "issuerPublicKey": "045F16BD1D2EAFE463E62A335A09E6B2BBCBD04452526885CB679FC4D27AF1BD22F553C7DEEFB54FD3D4F361D14E6DC3F11B7D4EA183250A60720EBDF9E110CD26",
        "signingMethods": [
          "SignHash"
        ],
        "pauseBeforePin2": 500,
        "walletsCount": null,
        "walletIndex": null,
        "health": 0,
        "isActivated": false,
        "activationSeed": null,
        "paymentFlowVersion": null,
        "userCounter": null,
        "userProtectedCounter": null,
        "terminalIsLinked": false,
        "cardData": {
          "batchId": "FFFF",
          "blockchainName": "ETH",
          "issuerName": "TANGEM SDK",
          "manufacturerSignature": "7CBEABA11F9D564A244260AC15CE0A26AB885811322C38B9FCA9E55EC7654C2027219ABB1BEAD190C2C370F48635129F76E8423FA8003DB6A08D2F64B1574004",
          "manufactureDateTime": "2021-06-23",
          "productMask": [
            "Note"
          ]
        },
        "isPin1Default": true,
        "isPin2Default": true,
        "wallets": [
          {
            "index": 0,
            "status": "Loaded",
            "curve": "Secp256k1",
            "settingsMask": [
              "IsReusable",
              "AllowSetPIN1",
              "AllowSetPIN2",
              "UseNDEF",
              "UseDynamicNDEF",
              "SmartSecurityDelay",
              "AllowUnencrypted",
              "AllowFastEncryption",
              "AllowSelectBlockchain",
              "SkipSecurityDelayIfValidatedByLinkedTerminal",
              "SkipCheckPIN2CVCIfValidatedByIssuer",
              "SkipSecurityDelayIfValidatedByIssuer"
            ],
            "publicKey": "0408C8EF8DEC3B9C910B44D8A5C72138A333365ED2DC34E91FACA8B9A1B37EB5010CB0080E8144807998F50F6BE4B1CA4BF140ADFCEF34124D1417DD116535FB2D",
            "signedHashes": 0,
            "remainingSignatures": 999999
          }
        ]
      },
      "asserts": [],
      "actionType": "NFC_SESSION_RUNNABLE",
      "iterations": 2
    },
    {
      "name": "Scan card 2",
      "method": "SCAN_TASK",
      "parameters": {},
      "expectedResult": {
        "cardId": "BB03000000000005",
        "manufacturerName": "TANGEM",
        "status": "Loaded",
        "firmwareVersion": {
          "version": "3.37d SDK"
        },
        "cardPublicKey": "0497C0424AF7BF8CE9920CB90EDAC2010FDED904937BC6D1D6E82E9254E0EFE4D4FDF355BB16BD0E9550D8BE5AB741B897FBC70360E99A86B97BA7DCC2FBF77D7E",
        "defaultCurve": "Secp256k1",
        "settingsMask": [
          "IsReusable",
          "AllowSetPIN1",
          "AllowSetPIN2",
          "UseNDEF",
          "UseDynamicNDEF",
          "SmartSecurityDelay",
          "AllowUnencrypted",
          "AllowFastEncryption",
          "AllowSelectBlockchain",
          "SkipSecurityDelayIfValidatedByLinkedTerminal",
          "SkipCheckPIN2CVCIfValidatedByIssuer",
          "SkipSecurityDelayIfValidatedByIssuer"
        ],
        "issuerPublicKey": "045F16BD1D2EAFE463E62A335A09E6B2BBCBD04452526885CB679FC4D27AF1BD22F553C7DEEFB54FD3D4F361D14E6DC3F11B7D4EA183250A60720EBDF9E110CD26",
        "signingMethods": [
          "SignHash"
        ],
        "pauseBeforePin2": 500,
        "walletsCount": null,
        "walletIndex": null,
        "health": 0,
        "isActivated": false,
        "activationSeed": null,
        "paymentFlowVersion": null,
        "userCounter": null,
        "userProtectedCounter": null,
        "terminalIsLinked": false,
        "cardData": {
          "batchId": "FFFF",
          "blockchainName": "ETH",
          "issuerName": "TANGEM SDK",
          "manufacturerSignature": "7CBEABA11F9D564A244260AC15CE0A26AB885811322C38B9FCA9E55EC7654C2027219ABB1BEAD190C2C370F48635129F76E8423FA8003DB6A08D2F64B1574004",
          "manufactureDateTime": "2021-06-23",
          "productMask": [
            "Note"
          ]
        },
        "isPin1Default": true,
        "isPin2Default": true,
        "wallets": [
          {
            "index": 0,
            "status": "Loaded",
            "curve": "Secp256k1",
            "settingsMask": [
              "IsReusable",
              "AllowSetPIN1",
              "AllowSetPIN2",
              "UseNDEF",
              "UseDynamicNDEF",
              "SmartSecurityDelay",
              "AllowUnencrypted",
              "AllowFastEncryption",
              "AllowSelectBlockchain",
              "SkipSecurityDelayIfValidatedByLinkedTerminal",
              "SkipCheckPIN2CVCIfValidatedByIssuer",
              "SkipSecurityDelayIfValidatedByIssuer"
            ],
            "publicKey": "0408C8EF8DEC3B9C910B44D8A5C72138A333365ED2DC34E91FACA8B9A1B37EB5010CB0080E8144807998F50F6BE4B1CA4BF140ADFCEF34124D1417DD116535FB2D",
            "signedHashes": 0,
            "remainingSignatures": 999999
          }
        ]
      },
      "asserts": [],
      "actionType": "NFC_SESSION_RUNNABLE",
      "iterations": 2
    }
  ]
}
''';