// МНЕ ЗА ЭТУ РАЗРАБОТКУ ТАКУЮ ПРЕМИЮ ДАДУТ ООООООЙЙЙ
class ConfigForPersonalize{
  returnConfig(configName) async {

    Map mapper = {
      "config1": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": true,
        "allowSwapPIN": true,
        "allowSwapPIN2": true,
        "cardData": {
          "batch": "ffff",
          "blockchain": "BTC",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3onCard": true,
        "count": 0,
        "createWallet": 0,
        "curveID": "Secp256k1",
        "disablePrecomputedNDEF": true,
        "forbidDefaultPIN": true,
        "forbidPurgeWallet": true,
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
        "protocolAllowStaticEncryption": true,
        "protocolAllowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": true,
        "requireTerminalTxSignature": true,
        "restrictOverwriteIssuerDataEx": true,
        "series": "BB",
        "skipCheckPIN2andCVCIfValidatedByIssuer": true,
        "skipSecurityDelayIfValidatedByIssuer": true,
        "skipSecurityDelayIfValidatedByLinkedTerminal": true,
        "smartSecurityDelay": true,
        "startNumber": 03000000000004,
        "useActivation": true,
        "useBlock": true,
        "useCVC": true,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": true
    },

      "config2": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSwapPIN": false,
        "allowSwapPIN2": false,
        "cardData": {
          "batch": "FFFF",
          "blockchain": "XLM",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3onCard": false,
        "count": 0,
        "createWallet": 1,
        "curveID": "ed25519",
        "disablePrecomputedNDEF": false,
        "forbidDefaultPIN": false,
        "forbidPurgeWallet": false,
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
        "protocolAllowStaticEncryption": false,
        "protocolAllowUnencrypted": false,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerDataEx": false,
        "series": "BB",
        "skipCheckPIN2andCVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 300000000000,
        "useActivation": false,
        "useBlock": false,
        "useCVC": false,
        "useDynamicNDEF": false,
        "useNDEF": false,
        "useOneCommandAtTime": false
      },

      "config3": {
        "CVC": "000",
        "MaxSignatures": 999999,
        "PIN": "000000",
        "PIN2": "000",
        "PIN3": "",
        "SigningMethod": 0,
        "allowSelectBlockchain": false,
        "allowSwapPIN": false,
        "allowSwapPIN2": false,
        "cardData": {
          "batch": "ffff",
          "blockchain": "BTC",
          "date": "",
          "product_id_card": false,
          "product_id_issuer": false,
          "product_note": true,
          "product_tag": false
        },
        "checkPIN3onCard": false,
        "count": 0,
        "createWallet": 0,
        "curveID": "Secp256k1",
        "disablePrecomputedNDEF": false,
        "forbidDefaultPIN": false,
        "forbidPurgeWallet": false,
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
        "protocolAllowStaticEncryption": true,
        "protocolAllowUnencrypted": true,
        "releaseVersion": false,
        "requireTerminalCertSignature": false,
        "requireTerminalTxSignature": false,
        "restrictOverwriteIssuerDataEx": true,
        "series": "BB",
        "skipCheckPIN2andCVCIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByIssuer": false,
        "skipSecurityDelayIfValidatedByLinkedTerminal": false,
        "smartSecurityDelay": false,
        "startNumber": 03000000000004,
        "useActivation": false,
        "useBlock": false,
        "useCVC": false,
        "useDynamicNDEF": true,
        "useNDEF": true,
        "useOneCommandAtTime": false
      }
    };

    return mapper[configName];
  }
}