class DefaultPersonalizationJson {
  static const jsonString = '''
{
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
    "blockchain": "ETH",
    "date": "",
    "product_id_card": false,
    "product_id_issuer": false,
    "product_note": true,
    "product_tag": false,
    "product_twin_card": false
  },
  "checkPIN3OnCard": false,
  "count": 0,
  "createWallet": 1,
  "walletsCount": 1,
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
  "skipCheckPIN2CVCIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByIssuer": true,
  "skipSecurityDelayIfValidatedByLinkedTerminal": true,
  "smartSecurityDelay": true,
  "startNumber": 300000000000,
  "useActivation": false,
  "useBlock": false,
  "useCvc": false,
  "useDynamicNDEF": true,
  "useNDEF": true,
  "useOneCommandAtTime": false
}
  ''';
}
