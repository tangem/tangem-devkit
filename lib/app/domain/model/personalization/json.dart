class DefaultPersonalizationJson {
  static const jsonString = '''
{
  "CVC": "000",
  "MaxSignatures": 999999,
  "PIN": "000000",
  "PIN2": "000",
  "PIN3": "",
  "SigningMethod": 0,
  "allowSelectBlockchain": false,
  "allowSwapPIN": true,
  "allowSwapPIN2": true,
  "cardData": {
    "batch": "FFFF",
    "blockchain": "ETH",
    "date": "",
    "product_id_card": false,
    "product_id_issuer": false,
    "product_note": true,
    "product_tag": false
  },
  "checkPIN3onCard": true,
  "count": 0,
  "createWallet": 1,
  "curveID": "secp256k1",
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
  "protectIssuerDataAgainstReplay": false,
  "protocolAllowStaticEncryption": true,
  "protocolAllowUnencrypted": true,
  "releaseVersion": false,
  "requireTerminalCertSignature": false,
  "requireTerminalTxSignature": false,
  "restrictOverwriteIssuerDataEx": false,
  "series": "BB",
  "skipCheckPIN2andCVCIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByLinkedTerminal": true,
  "smartSecurityDelay": true,
  "startNumber": 300000000000,
  "useActivation": false,
  "useBlock": false,
  "useCVC": false,
  "useDynamicNDEF": true,
  "useNDEF": true,
  "useOneCommandAtTime": false
}
  ''';

  static const jsonStringWithToken = '''
{
  "CVC": "000",
  "MaxSignatures": 999999,
  "PIN": "000000",
  "PIN2": "000",
  "PIN3": "",
  "SigningMethod": 0,
  "allowSelectBlockchain": false,
  "allowSwapPIN": true,
  "allowSwapPIN2": true,
  "cardData": {
    "batch": "FFFF",
    "blockchain": "ETH",
    "date": "",
    "product_id_card": false,
    "product_id_issuer": false,
    "product_note": true,
    "product_tag": false,
    "token_contract_address": "BUSD-BD1",
    "token_decimal": 8,
    "token_symbol": "BUSD"
  },
  "checkPIN3onCard": false,
  "count": 0,
  "createWallet": 1,
  "curveID": "secp256k1",
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
  "restrictOverwriteIssuerDataEx": false,
  "series": "BB",
  "skipCheckPIN2andCVCIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByLinkedTerminal": true,
  "smartSecurityDelay": true,
  "startNumber": 300000000000,
  "useActivation": false,
  "useBlock": false,
  "useCVC": false,
  "useDynamicNDEF": true,
  "useNDEF": true,
  "useOneCommandAtTime": false
}
  ''';
}
