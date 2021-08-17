class Languages {
  static Map<String, String> map = {
    "en": en,
  };

  static final en = '''{
  "app_name": "Tangem DevKit",
  "stub": "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit",
  "screen_scan": "Read Card",
  "screen_sign": "Sign",
  "screen_personalize": "Personalize",
  "screen_depersonalize": "Depersonalize",
  "screen_wallet_create": "Create Wallet",
  "screen_wallet_purge": "Purge Wallet",
  "screen_issuer_read_data": "Read Issuer Data",
  "screen_issuer_write_data": "Write Issuer Data",
  "screen_issuer_read_ex_data": "Read Issuer Extra Data",
  "screen_issuer_write_ex_data": "Write Issuer Extra Data",
  "screen_user_read_data": "Read User Data",
  "screen_user_write_data": "Write User Data",
  "screen_user_write_protected_data": "Write Protected User Data",
  "screen_response": "Response",
  "screen_set_pin1": "Change Pin1",
  "screen_set_pin2": "Change Pin2",
  "menu_share": "Share",
  "menu_enable_description": "Description",
  "menu_pers_configs": "Presets",
  "menu_pers_config_reset": "Reset to default",
  "menu_pers_config_save": "Save preset",
  "menu_pers_config_load": "Load preset",
  "menu_pers_import": "Import",
  "menu_pers_export": "Export",

  "action_scan": "Read Card",
  "desc_action_scan": "This command returns all data about the card and the wallet, including unique card number (CID) that has to be submitted while calling all other commands",
  "action_sign": "Sign",
  "desc_action_sign": "Depending on Signing_Method parameter defined during personalization, this command signs data using Wallet_PrivateKey",
  "action_personalize": "Personalize",
  "desc_action_personalize": "Personalization is an initialization procedure, required before start using a card. During this procedure all card setting are performed. During this procedure all data exchange are encrypted because it's usually done at the third-party factory.",
  "action_depersonalize": "Depersonalize",
  "desc_action_depersonalize": "This command reset card to initial state - erase all data, writed during previous personalization and previous usage.\\nCommand available on SDK cards only",
  "action_create_wallet": "Create Wallet",
  "desc_action_create_wallet": "If the card has an ‘Empty’ state, this command will create a new wallet, changing a state to ‘Loaded’.",
  "action_purge_wallet": "Purge Wallet",
  "desc_action_purge_wallet": "This command deletes all wallet data. If ‘IsReusable‘ flag was enabled during personalization, the card changes state to ‘Empty’ and a new wallet can be created by Create Wallet Command.",
  "action_issuer_read_data": "Read Issuer Data",
  "desc_action_issuer_read_data": "This command returns 512-byte Issuer Data field and its issuer’s signature.",
  "action_issuer_write_data": "Write Issuer Data",
  "desc_action_issuer_write_data": "This command writes 512-byte Issuer Data field and its issuer’s signature to the card.",
  "action_issuer_read_ex_data": "Read Issuer Extra Data",
  "desc_action_issuer_read_ex_data": "This command retrieves Issuer Extra Data field and its issuer’s signature.",
  "action_issuer_write_ex_data": "Write Issuer Extra Data",
  "desc_action_issuer_write_ex_data": "This command writes Issuer Extra Data field and its issuer’s signature to the card.",
  "action_user_read_data": "Read User Data",
  "desc_action_user_read_data": "This command returns User Data and User Protected Data (up to 512-byte each) and two counters: User Counter and User Protected Counter.",
  "action_user_write_data": "Write User Data",
  "desc_action_user_write_data": "This command writes to the card User Data and User Counter fields.",
  "action_user_write_protected_data": "Write Protected User Data",
  "desc_action_user_write_protected_data": "This command writes to the card User Protected Data and User Protected Counter fields.",
  "action_set_pin1": "Change PIN1",
  "desc_action_set_pin1": "This 32-byte code restricts access to the whole card.",
  "action_set_pin2": "Change PIN2",
  "desc_action_set_pin2": "All cards will require submitting the correct 32-byte PIN2 code in order to sign a transaction or to perform other commands entailing a change of the card state",

  "pers_segment_card_number": "Card number",
  "desc_pers_segment_card_number": "Unique Tangem card ID number. It will be generated automatically with Series and Number.",
  "pers_segment_common": "Common",
  "desc_pers_segment_common": "",
  "pers_segment_signing_method": "Signing method",
  "desc_pers_segment_signing_method": "Depending on these parameters, SIGN command signs following data using Wallet_PrivateKey: array of transaction hashes, single raw transaction. In case the card issuer supports 2FA, the card will firstly verify issuer’s signature of transaction hash before signing transaction hash using Wallet_PrivateKey. In case the card issuer requires the card to store additional data (e.g. wallet balance, SPV proof, timestamps, etc. – see details in Security section), COS will verify issuer’s signature of hash of concatenated transaction hashes and Issuer_Data hash, and issuer’s signature of Issuer_Data hash, and then proceed to signing transaction hash using Wallet_PrivateKey.",
  "pers_segment_sign_hash_ex_prop": "Sign hash external properties",
  "desc_pers_segment_sign_hash_ex_prop": "",
  "pers_segment_denomination": "Denomination",
  "desc_pers_segment_denomination": "",
  "pers_segment_token": "Token",
  "desc_pers_segment_token": "These fields can be used by the host application to provide additional infromation about tokens stored within the wallet of the card.",
  "pers_segment_product_mask": "Product mask",
  "desc_pers_segment_product_mask": "These fields can be used by the host application to provide additional infromation about product type.",
  "pers_segment_settings_mask": "Settings mask",
  "desc_pers_segment_settings_mask": "",
  "pers_segment_settings_mask_protocol_enc": "Settings mask protocol encryption",
  "desc_pers_segment_settings_mask_protocol_enc": "Card Operation System supports three options of communication",
  "pers_segment_settings_mask_ndef": "Settings mask ndef",
  "desc_pers_segment_settings_mask_ndef": "",
  "pers_segment_pins": "Pins",
  "desc_pers_segment_pins": "",

  "pers_item_series": "Series",
  "desc_pers_item_series": "",
  "pers_item_number": "Number",
  "desc_pers_item_number": "",
  "pers_item_batch_id": "Batch ID",
  "desc_pers_item_batch_id": "",
  "pers_item_curve": "Curve",
  "desc_pers_item_curve": "Elliptic curve used for all wallet key operations. Supported curves: ‘secp256k1’, ‘secp256r1‘, ‘ed25519’.",
  "pers_item_blockchain": "Blockchain",
  "desc_pers_item_blockchain": "Name of the blockchain. It's just a textfield in the card. It's needed for host app to tell what blockchain should it use. ",
  "pers_item_custom_blockchain": "Custom blockchain",
  "desc_pers_item_custom_blockchain": "You can use this field, to create something special",
  "pers_item_max_signatures": "Max signatures",
  "desc_pers_item_max_signatures": "Total number of signatures allowed for the wallet when the card was personalized",
  "pers_item_create_wallet": "Create wallet",
  "desc_pers_item_create_wallet": "Off - don’t create wallet (user must be create wallet by himself with App)\\nOn - create wallet (after personalization wallet alredy will be created and card ready to use)",
  "pers_item_wallets_count": "Wallets count",
  "desc_pers_item_wallets_count": "Number of wallets supported by card",
  "pers_item_sign_tx_hashes": "Sign TX hashes (0)",
  "desc_pers_item_sign_tx_hashes": "Allow card to sign hashed transaction",
  "pers_item_sign_raw_tx": "Sign raw TX (1)",
  "desc_pers_item_sign_raw_tx": "Allow card to sign raw transaction. The raw transaction will be hashed by a hash function before signing.",
  "pers_item_sign_validated_tx_hashes": "Sign validated TX hashes (2)",
  "desc_pers_item_sign_validated_tx_hashes": "Allow card to sign hashed transaction, that was signed by issuer before",
  "pers_item_sign_validated_raw_tx": "Sign validated raw TX (3)",
  "desc_pers_item_sign_validated_raw_tx": "Allow card to sign raw transaction, that was signed by issuer before",
  "pers_item_sign_validated_tx_hashes_with_iss_data": "Sign validated TX hashes with issuer data (4)",
  "desc_pers_item_sign_validated_tx_hashes_with_iss_data": "Allow card to sign hashed transaction, that was signed by issuer before, and update issuer data at the same time",
  "pers_item_sign_validated_raw_tx_with_iss_data": "Sign validated raw TX with issuer data (5)",
  "desc_pers_item_sign_validated_raw_tx_with_iss_data": "Allow card to sign raw transaction, that was signed by issuer before, and update issuer data at the same time",
  "pers_item_sign_hash_ex": "Sign hash external (6)",
  "desc_pers_item_sign_hash_ex": "Allow card to sign POS transactions",
  "pers_item_pin_less_floor_limit": "Pin-less floor limit",
  "desc_pers_item_pin_less_floor_limit": "",
  "pers_item_cr_ex_key": "Cr(ypto)Ex(tract) key",
  "desc_pers_item_cr_ex_key": "Unique card secret key (shared with acquirers server)",
  "pers_item_require_terminal_cert_sig": "Require terminal Cert signature",
  "desc_pers_item_require_terminal_cert_sig": "",
  "pers_item_require_terminal_tx_sig": "Require terminal TX signature",
  "desc_pers_item_require_terminal_tx_sig": "",
  "pers_item_check_pin3_on_card": "Check PIN3 on card",
  "desc_pers_item_check_pin3_on_card": "",
  "pers_item_write_on_personalize": "Write on personalize",
  "desc_pers_item_write_on_personalize": "",
  "pers_item_denomination": "Denomination",
  "desc_pers_item_denomination": "",
  "pers_item_its_token": "It's token",
  "desc_pers_item_its_token": "",
  "pers_item_symbol": "Symbol",
  "desc_pers_item_symbol": "Symbol of the token",
  "pers_item_contract_address": "Contract address",
  "desc_pers_item_contract_address": "Token's Smart contract address",
  "pers_item_decimal": "Decimal",
  "desc_pers_item_decimal": "Number of decimals in token value",
  "pers_item_note": "Note",
  "desc_pers_item_note": "Self-custodial wallet or note",
  "pers_item_tag": "Tag",
  "desc_pers_item_tag": "Anti-counterfeit tag",
  "pers_item_id_card": "ID card",
  "desc_pers_item_id_card": "Personal ID card",
  "pers_item_id_issuer_card": "ID Issuer",
  "desc_pers_item_id_issuer_card": "",
  "pers_item_id_twin_card": "Twin card",
  "desc_pers_item_id_twin_card": "",
  "pers_item_is_reusable": "Is reusable",
  "desc_pers_item_is_reusable": "Defines what happens when user calls PURGE_WALLET command:\\nOff - Card will switch to Purged state\\nOn - Card will switch to Empty state and let create a new wallet again",
  "pers_item_use_activation": "Need activation",
  "desc_pers_item_use_activation": "",
  "pers_item_forbid_purge": "Forbid purge",
  "desc_pers_item_forbid_purge": "If this option is turned on, card will reject PURGE_WALLET command",
  "pers_item_allow_select_blockchain": "Allow select blockchain",
  "desc_pers_item_allow_select_blockchain": "If this option is turned on, wallet elliptic curve and blockchain information can be changed on CREATE_WALLET command",
  "pers_item_use_block": "Use block",
  "desc_pers_item_use_block": "",
  "pers_item_one_apdu_at_once": "One session – one command",
  "desc_pers_item_one_apdu_at_once": "Card will execute only one command during one communication session, thus requiring user to physically take the card away from the host after each action (all commands except for READ_CARD)",
  "pers_item_use_cvc": "Use CVC",
  "desc_pers_item_use_cvc": "All commands requiring PIN2 will also require additional CVC code printed on the card",
  "pers_item_allow_swap_pin": "Allow swap PIN",
  "desc_pers_item_allow_swap_pin": "Is user allowed to change PIN1 with SET_PIN command",
  "pers_item_allow_swap_pin2": "Allow swap PIN2",
  "desc_pers_item_allow_swap_pin2": "Is user allowed to change PIN2 with SET_PIN command",
  "pers_item_forbid_default_pin": "Forbid default PIN",
  "desc_pers_item_forbid_default_pin": "SET_PIN commands will not change PIN1 to default value (‘000000’)",
  "pers_item_smart_security_delay": "Smart Security Delay",
  "desc_pers_item_smart_security_delay": "Security delay Pause_Before_PIN2 will not be applied if PIN2 is not default",
  "pers_item_protect_issuer_data_against_replay": "Protect issuer data against replay",
  "desc_pers_item_protect_issuer_data_against_replay": "Off – No replay protection on write issuer data\\nOn – Enable replay protection on write issuer data (card will require additional Issuer_Data_Counter incremented on each write)",
  "pers_item_skip_security_delay_if_validated": "Skip security delay if validated",
  "desc_pers_item_skip_security_delay_if_validated": "Off – Enforce security delay in SIGN command if the issuer validates the transaction (for signing methods 2, 3, 4 and 5)\\nOn – Skip security delay in SIGN command if the issuer validates the transaction (for signing methods 2, 3, 4 and 5)",
  "pers_item_skip_pin2_and_cvc_if_validated": "Skip PIN2 and CVC if validated",
  "desc_pers_item_skip_pin2_and_cvc_if_validated": "Off – Require and check PIN2 and CVC in SIGN command if the issuer validates the transaction (for signing method 2, 3, 4 and 5)\\nOn – Skip checking PIN2 and CVC in SIGN command if the issuer validates the transaction (for signing method 2, 3, 4 and 5)",
  "pers_item_skip_security_delay_on_linked_terminal": "Skip security delay on linked terminal",
  "desc_pers_item_skip_security_delay_on_linked_terminal": "App can optionally generate ECDSA key pair Terminal_PrivateKey / Terminal_PublicKey. And then submit Terminal_PublicKey to the card in any SIGN command. Once SIGN is successfully executed by COS, including PIN2 verification and/or completion of security delay, the submitted Terminal_PublicKey key is stored by COS. After that, the App instance is deemed trusted by COS and COS will allow skipping security delay for subsequent SIGN operations thus improving convenience without sacrificing security.",
  "pers_item_restrict_overwrite_ex_issuer_data": "Restrict overwrite extra issuer data",
  "desc_pers_item_restrict_overwrite_ex_issuer_data": "Prohibit overwriting Issuer_Extra_Data",
  "pers_item_allow_unencrypted": "Allow unencrypted",
  "desc_pers_item_allow_unencrypted": "Allow plain data packets with non-encrypted Payload:\\nThis option is not recommended for large-scale commercial projects, because it potentially exposes the card to eavesdropping and replay attacks. ",
  "pers_item_allow_fast_encryption": "Allow 'FAST' encryption",
  "desc_pers_item_allow_fast_encryption": "Allow Fast symmetric encryption with mutual challenges",
  "pers_item_use_ndef": "Use NDEF",
  "desc_pers_item_use_ndef": "Whether the card should emulate NDEF. In default configuration, two NDEF records are loaded during personalization: (1) Tangem web site address, (2) name of Android App package in Google Play Store.",
  "pers_item_dynamic_ndef": "Dynamic NDEF",
  "desc_pers_item_dynamic_ndef": "Tangem card supports a special wallet validation mechanism for smartphones that can only read NDEF tags\\nOff – Disable dynamic generation of NDEF for iOS\\nOn – Enable dynamic NDEF for iOS",
  "pers_item_disable_precomputed_ndef": "Disable precomputed NDEF",
  "desc_pers_item_disable_precomputed_ndef": "Off – Enable precomputed dynamic NDEF to work around iPhone 7+ NFC bug\\nOn – Disable precomputed dynamic NDEF",
  "pers_item_aar": "AAR",
  "desc_pers_item_aar": "Android Application Record. Android Application ID, Package name of Android apllication. Android OS will open this app or send user to Google Play page if it's not installed. If this field is empty, Android OS will try to open URI from URI field.",
  "pers_item_custom_aar_package_name": "Custom AAR package name",
  "desc_pers_item_custom_aar_package_name": "",
  "pers_item_uri": "Url",
  "desc_pers_item_uri": "",
  "pers_item_pin": "PIN",
  "desc_pers_item_pin": "PIN1 code to access the card. Default unhashed value: ‘000000’.",
  "pers_item_pin2": "PIN2",
  "desc_pers_item_pin2": "PIN2 code to confirm transaction signatures and swap PIN operations. Default unhashed value: ‘000’.",
  "pers_item_pin3": "PIN3",
  "desc_pers_item_pin3": "PIN3 code to confirm POS transaction with amount that exceed pin-less floor limit.",
  "pers_item_cvc": "CVC",
  "desc_pers_item_cvc": "3-digit code, that can be printed on the card",
  "pers_item_pause_before_pin2": "Pause before PIN2",
  "desc_pers_item_pause_before_pin2": "Delay in seconds before COS executes commands protected by PIN2",

  "response_card_cid": "CID",
  "desc_response_card_cid": "Unique Tangem card ID number",
  "response_card_manufacturer_name": "Manufacturer_Name",
  "desc_response_card_manufacturer_name": "Name of Tangem card manufacturer",
  "response_card_status": "Status",
  "desc_response_card_status": "Current status of the card",
  "response_card_firmware_version": "Firmware_Version",
  "desc_response_card_firmware_version": "Version of Tangem COS",
  "response_card_public_key": "Card_PublicKey",
  "desc_response_card_public_key": "Public key that is used to authenticate the card against manufacturer’s database. It is generated one time during card manufacturing. See Security section for more details.",
  "response_card_settings_mask": "Settings_Mask",
  "desc_response_card_settings_mask": "Card settings defined by personalization.",
  "response_card_is_reusable": "Is_Reusable",
  "desc_response_card_is_reusable": "Defines what happens when user calls PURGE_WALLET command:\\n0 - Card will switch to Purged state\\n1 - Card will switch to Empty state and let create a new wallet again",
  "response_card_use_activation": "Use_Activation",
  "desc_response_card_use_activation": "",
  "response_card_purge_wallet": "Prohibit_Purge_Wallet",
  "desc_response_card_purge_wallet": "0 – Card will accept PURGE_WALLET command\\n1 – Card will reject PURGE_WALLET command",
  "response_card_use_block": "Use_Block",
  "desc_response_card_use_block": "",
  "response_card_allow_pin": "Allow_SET_PIN1",
  "desc_response_card_allow_pin": "Is user allowed to change PIN1 with SET_PIN command",
  "response_card_allow_pin2": "Allow_SET_PIN2",
  "desc_response_card_allow_pin2": "Is user allowed to change PIN2 with SET_PIN command",
  "response_card_use_cvc": "Use_CVC",
  "desc_response_card_use_cvc": "All commands requiring PIN2 will also require additional CVC code printed on the card",
  "response_card_default_pin": "Prohibit_Default_PIN1",
  "desc_response_card_default_pin": "SET_PIN commands will not change PIN1 to default value (‘000000’).",
  "response_card_one_apdu_at_time": "Use_One_CommandAtTime",
  "desc_response_card_one_apdu_at_time": "Card will execute only one command during one communication session, thus requiring user to physically take the card away from the host after each action (all commands except for READ_CARD).",
  "response_card_use_ndef": "Use_NDEF",
  "desc_response_card_use_ndef": "Whether the card should emulate NDEF. In default configuration, two NDEF records are loaded during personalization: (1) Tangem web site address, (2) name of Android App package in Google Play Store.",
  "response_card_use_dynamic_ndef": "Use_Dynamic_NDEF",
  "desc_response_card_use_dynamic_ndef": "0 – Disable dynamic generation of NDEF for iOS. See Dynamic NDEF section for more details.\\n1 – Enable dynamic NDEF for iOS.",
  "response_card_smart_security_delay": "Smart_Security_Delay",
  "desc_response_card_smart_security_delay": "Security delay Pause_Before_PIN2 will not be applied if PIN2 is not default.",
  "response_card_allow_unencrypted": "Allow_Unencrypted",
  "desc_response_card_allow_unencrypted": "Whether the card supports unencrypted NFC communication. See NFC communication section for more details.",
  "response_card_allow_fast_encryption": "Allow_Fast_Encryption",
  "desc_response_card_allow_fast_encryption": "Whether the card supports fast encrypted NFC communication. See NFC communication section for more details.",
  "response_card_protect_issuer_data_against_replay": "Protect_Issuer_Data_Against_Replay",
  "desc_response_card_protect_issuer_data_against_replay": "0 – No replay protection on write issuer data\\n1 – Enable replay protection on write issuer data (card will require additional Issuer_Data_Counter incremented on each write)",
  "response_card_allow_select_blockchain": "Allow_Select_Blockchain",
  "desc_response_card_allow_select_blockchain": "0 – Wallet elliptic curve and blockchain information stored during PERSONALIZE command and never change\\n1 – Wallet elliptic curve and blockchain information can be changed on CREATE_WALLET command",
  "response_card_disable_precomputed_ndef": "Disable_Precomputed_NDEF",
  "desc_response_card_disable_precomputed_ndef": "0 – Enable  precomputed dynamic NDEF to work around iPhone 7+ NFC bug.\\n1 – Disable precomputed dynamic NDEF. See Dynamic NDEF section for more details.",
  "response_card_security_delay_if_validated": "Skip_Security_Delay_If_Validated_By_Issuer",
  "desc_response_card_security_delay_if_validated": "0 – Enforce security delay in SIGN command if the issuer validates the transaction (for signing methods 2, 3, 4 and 5).\\n1 – Skip security delay in SIGN command if the issuer validates the transaction (for signing methods 2, 3, 4 and 5).",
  "response_card_skip_pin2_cvc_if_validated_by_issuer": "Skip_Check_PIN2_and_CVC_If_Validated_By_Issuer",
  "desc_response_card_skip_pin2_cvc_if_validated_by_issuer": "0 – Require and check PIN2 and CVC in SIGN command if the issuer validates the transaction (for signing method 2, 3, 4 and 5).\\n1 – Skip checking PIN2 and CVC in SIGN command if the issuer validates the transaction (for signing method 2, 3, 4 and 5).",
  "response_card_skip_security_delay_if_validated_by_linked_terminal": "Skip_Security_Delay_If_Validated_By_Linked_Terminal",
  "desc_response_card_skip_security_delay_if_validated_by_linked_terminal": "1 - Store Terminal_PublicKey public key of linked terminal no each SIGN command, skip security delay if valid signature of transaction is made with Terminal_PrivateKey is provided in SIGN command",
  "response_card_restrict_overwrite_issuer_ex_data": "Restrict_Overwrite_Issuer_Extra_Data",
  "desc_response_card_restrict_overwrite_issuer_ex_data": "",
  "response_card_prohibit_overwriting_issuer_ex_data": "1 – prohibit overwriting Issuer_Extra_Data",
  "desc_response_card_prohibit_overwriting_issuer_ex_data": "",
  "response_card_require_terminal_tx_sig": "Require_Term_Tx_Signature",
  "desc_response_card_require_terminal_tx_sig": "0 – Skip checking terminal’s signature when signing POS transaction\\n1 – Check terminal’s signature when signing POS transaction",
  "response_card_require_terminal_cert_sig": "Require_Term_Cert_Signature",
  "desc_response_card_require_terminal_cert_sig": "0 – Skip checking acquirer’s signature of terminal certificate when signing POS transaction\\n1 – Check acquirer’s signature of terminal certificate when signing POS transaction",
  "response_card_check_pin3": "Check_PIN3_on_Card",
  "desc_response_card_check_pin3": "0 – Additionally encrypt POS transaction signature with key derived from PIN3 when the transaction amount exceeds PIN3 floor limit    \\n1 – Require terminal to send PIN3 to card when the POS transaction amount exceeds PIN3_Floor_Limit",
  "response_card_card_data": "Card_Data",
  "desc_response_card_card_data": "Detailed information about card contents. Format is defined by the card issuer. Cards complaint with Tangem Wallet application should have TLV format described in Personalization section.",
  "response_card_issuer_data_public_key": "Issuer_Data_PublicKey",
  "desc_response_card_issuer_data_public_key": "Public key that is used by the card issuer to sign Issuer_Data field. See Security section for more details.",
  "response_card_curve": "Curve_ID",
  "desc_response_card_curve": "Explicit text name of the elliptic curve used for all wallet key operations.",
  "response_card_max_signatures": "Max_Signatures",
  "desc_response_card_max_signatures": "Total number of signatures allowed for the wallet when the card was personalized.",
  "response_card_signing_method": "Signing_Method",
  "desc_response_card_signing_method": "Defines what data should be submitted to SIGN command.",
  "response_card_pause_before_pin2": "Pause_Before_PIN2",
  "desc_response_card_pause_before_pin2": "Delay in seconds before COS executes commands protected by PIN2.",
  "response_card_wallet_public_key": "Wallet_PublicKey",
  "desc_response_card_wallet_public_key": "Public key of the blockchain wallet. Value returned only if the wallet has already been created by CREATE_WALLET command. See Security section for more details.",
  "response_card_wallet_remaining_signatures": "Wallet_Remaining_Signatures",
  "desc_response_card_wallet_remaining_signatures": "Remaining number of SIGN operations before the wallet will stop signing transactions. Value returned only if the wallet has already been created by CREATE_WALLET command.",
  "response_card_wallet_signed_hashes": "Wallet_Signed_Hashes",
  "desc_response_card_wallet_signed_hashes": "Total number of signed single hashes returned by the card in SIGN command responses since card personalization. Sums up array elements within all SIGN commands.",
  "response_card_health": "Health",
  "desc_response_card_health": "Any non-zero value indicates that the card experiences some hardware problems. User should withdraw the value to other blockchain wallet as soon as possible.  Non-zero Health tag will also appear in responses of all other commands.",
  "response_card_is_activated": "Is_Activated",
  "desc_response_card_is_activated": "Whether the card requires issuer’s confirmation of activation.\\n0 – card will require issuer’s confirmation of activation,\\notherwise this field will not be returned (card is activated and operational).",
  "response_card_activation_seed": "Activation_Seed",
  "desc_response_card_activation_seed": "A random challenge generated by PERSONALIZE command that should be signed and returned to COS by the issuer to confirm the card has been activated. See ACTIVATE_CARD command for more details.\\nThis field will not be returned if the card is activated.",
  "response_card_payment_flow_version": "Payment_Flow_Version",
  "desc_response_card_payment_flow_version": "Version of POS payment scheme supported by COS ([0x02,0x01] for version 2.30)\\nReturned only if SigningMethod ‘6’ enabling POS transactions is supported by card.",
  "response_card_user_counter": "User_Counter",
  "desc_response_card_user_counter": "This value can be initialized by App and will be increased by COS with the execution of each SIGN command. For example, this field can store blockchain “nonce” for a quick one-touch transaction on POS terminals. Returned only if SigningMethod =6.",
  "response_card_user_protected_counter": "User_Protected_Counter",
  "desc_response_card_user_protected_counter": "This value can be initialized by App (with PIN2 confirmation) and will be increased by COS with the execution of each SIGN command. For example, this field can store blockchain “nonce” for a quick one-touch transaction on POS terminals. Returned only if SigningMethod =6.",

  "response_card_card_data_batch_id": "Batch_ID",
  "desc_response_card_card_data_batch_id": "Tangem internal manufacturing batch ID, should correspond with the data in Tangem’s card list (see Card attestation and UID and CID sections)",
  "response_card_card_data_manufacture_date_time": "Manufacture_Date_Time",
  "desc_response_card_card_data_manufacture_date_time": "Timestamp of manufacturing should correspond with the data in Tangem’s card list (see Card attestation section).",
  "response_card_card_data_issuer_name": "Issuer_Name",
  "desc_response_card_card_data_issuer_name": "Name of the issuer",
  "response_card_card_data_blockchain_name": "Blockchain_Name",
  "desc_response_card_card_data_blockchain_name": "Name of the blockchain (once personalized, the target blockchain is fixed for the whole life cycle)",
  "response_card_card_data_manufacturer_signature": "Manufacturer_Signature",
  "desc_response_card_card_data_manufacturer_signature": "Signature of CID with the MANUFACTURER_PRIVATE_KEY",
  "response_card_card_data_product_mask": "ProductMask",
  "desc_response_card_card_data_product_mask": "Mask of products enabled on card",
  "response_card_card_data_token_symbol": "tokenSymbol",
  "desc_response_card_card_data_token_symbol": "",
  "response_card_card_data_token_contract_address": "tokenContractAddress",
  "desc_response_card_card_data_token_contract_address": "",
  "response_card_card_data_token_decimal": "tokenDecimal",
  "desc_response_card_card_data_token_decimal": "",

  "response_sign_cid": "CID",
  "desc_response_sign_cid": "CID",
  "response_sign_wallet_signed_hashes": "Wallet signed hashes",
  "desc_response_sign_wallet_signed_hashes": "Total number of signed single hashes returned by the card in SIGN command responses since card personalization. Sums up array elements within all SIGN commands.",
  "response_sign_wallet_remaining_signatures": "Wallet remaining signatures",
  "desc_response_sign_wallet_remaining_signatures": "Remaining number of SIGN operations before the wallet will stop signing transactions.",
  "response_sign_signature": "Signature",
  "desc_response_sign_signature": "Array of resulting signatures that App should embed into a raw transaction according to a transaction format of an appropriate blockchain.",

  "response_depersonalize_is_success": "Success",
  "desc_response_depersonalize_is_success": "Success",

  "response_issuer_data_size": "Size of Issuer Data",
  "desc_response_issuer_data_size": "A size of issuer data written on a card.",
  "response_issuer_data": "Issuer Data",
  "desc_response_issuer_data": "Data defined by the issuer.",
  "response_issuer_data_signature": "Issuer Data Signature",
  "desc_response_issuer_data_signature": "Issuer data, signed by the issuer with issuer data private key.",
  "response_issuer_data_counter": "Issuer Data Counter",
  "desc_response_issuer_data_counter": "An optional counter that protects issuer data against replay attack.",
  
  "response_issuer_ex_data_size": "Size of Issuer Extra Data",
  "desc_response_issuer_ex_data_size": "A size of issuer extra data written on a card.",
  "response_issuer_ex_data": "Issuer Extra Data",
  "desc_response_issuer_ex_data": "Extra data defined by the issuer.",
  "response_issuer_ex_data_signature": "Issuer Extra Data Signature",
  "desc_response_issuer_ex_data_signature": "Issuer extra data, signed by the issuer with issuer data private key.",
  "response_issuer_ex_data_counter": "Issuer Extra Data Counter",
  "desc_response_issuer_ex_data_counter": "An optional counter that protects issuer extra data against replay attack.",

  "response_user_data": "User Data",
  "desc_response_user_data": "Data defined by user's App",
  "response_user_protected_data": "Protected User Data",
  "desc_response_user_protected_data": "Data defined by user’s App (confirmed by PIN2)",
  "response_user_data_counter": "User Data Counter",
  "desc_response_user_data_counter": "Counter initialized by user’s App and increased on every signing of new transaction",
  "response_user_data_protected_counter": "Protected User Data Counter",
  "desc_response_user_data_protected_counter": "Counter initialized by user’s App (confirmed by PIN2) and increased on every signing of new transaction",
  "response_set_pin_status": "Status",
  "desc_response_set_pin_status": "Status",

  "card_id": "Card Id (CID)",
  "desc_card_id": "Unique Tangem card ID number",
  "transaction_out_hash": "Hash to sign",
  "desc_transaction_out_hash": "Hashed transaction you want to be signed. Can be split by ','",
  "issuer_data": "Issuer Data",
  "desc_issuer_data": "Issuer Data to be written by this command",
  "user_data": "User Data",
  "desc_user_data": "User Data to be written by this command",
  "user_protected_data": "Protected User Data",
  "desc_protected_user_data": "Protected User Data to be written by this command",
  "counter": "Counter",
  "desc_counter": "Counter that protects this type of data against replay attack.",
  "pin1": "Pin 1",
  "desc_pin1": "Hashed user’s PIN1 code to access the card",
  "pin2": "Pin2",
  "desc_pin2": "Hashed user’s PIN2 code for signing and state-changing operations. See Security section for more details.",

  "hint_enter_config_name": "Enter a name for the current preset",
  "hint_paste": "Paste",
  "show_rare_fields": "Show all fields",
  "hide_rare_fields": "Hide fields",
  "copy_to_clipboard": "Copy to clipboard",
  "btn_delete": "Delete",
  "btn_ok": "OK",
  "btn_cancel": "Cancel",
  "btn_save": "Save",
  "btn_load": "Load",
  "error_nothing_to_import": "Nothing to import",
  "error_not_saved": "Not saved",
  "error_nothing_to_load": "Nothing to load",
  "card_error_not_personalized": "Your card hasn't been personalized yet. You need to run personalize command first.",
  "card_error_bad_series": "Wrong Series",
  "card_error_bad_series_number": "Wrong Series and Number",
  "how_to_scan": "To read the card, press the button at the right bottom corner of the screen",
  "how_to_depersonalize": "To depersonalize the card, press the button at the right bottom corner of the screen",
  
  "screen_files_write": "Write files",
  "action_files_write": "Write files",
  "desc_action_files_write": "This command allows to write data up to [MAX_SIZE] to a card. There are two secure ways to write files. Data can be signed by Issuer and Data can be protected by Passcode (PIN2).",
  "files_data_protection": "Protection type",
  "desc_files_data_protection": "Files can be signed by Issuer (specified on card during personalization) or files can be written using PIN2 (Passcode)",
  "response_files_write_indices": "File indices",
  "desc_response_files_write_indices": "Indices of files stored in the file system",
  
  "screen_files_read": "Read files",
  "action_files_read": "Read files",
  "desc_action_files_read": "This command allows to read multiple files written to the card. If the files are private, then Passcode (PIN2) is required to read the files.",
  "files_read_indices": "File indices",
  "desc_files_read_indices": "Indices of files to be read. If not provided, the task will read and return all files from a card that satisfy the access level condition (either only public or private and public). Can be split by ','",
  "read_private_files": "Read private files",
  "desc_read_private_files": "If set to true, then the task will read private files, for which it requires PIN2. Otherwise only public files can be read",
  "response_file_index":"Index of file",
  "desc_response_file_index":"Index of file in storage",
  "response_file_settings":"File settings",
  "desc_response_file_settings":"Access level of the file",
  "response_file_data":"File data",
  "desc_response_file_data":"Data stored on the card",
  
  "screen_files_delete": "Delete files",
  "action_files_delete": "Delete files",
  "desc_action_files_delete": "This command allows to delete multiple or all files written to the card. Passcode (PIN2) is required to delete the files.",
  "files_delete_indices": "File indices",
  "desc_files_delete_indices": "Indices of files to be deleted. If indices are not provided, then all files will be deleted. Can be split by ','",

  "screen_files_change_settings": "Change files settings",
  "action_files_change_settings": "Change files settings",
  "desc_action_files_change_settings": "This command allows to change settings of multiple files written to the card. Passcode (PIN2) is required for this operation.",
  "files_file_settings": "File settings",
  "desc_files_file_settings": "Access level to a file - it can be [Private], accessible only with PIN2, or [Public], accessible without PIN2",
  
  "unknown": "unknown"
}''';
}
