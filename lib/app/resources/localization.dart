import 'dart:convert';
import 'dart:core';

import 'package:devkit/app/resources/lang/languages.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalization {
  static const LocalizationsDelegate<Transl> delegate = _LocalizationDelegate();

  static Locale resolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
    final supportedLocale = supportedLocales.firstWhere(
      (item) => item.languageCode == locale.languageCode && item.countryCode == locale.countryCode,
      orElse: () => null,
    );
    return supportedLocale ?? supportedLocales.first;
  }
}

class _LocalizationDelegate extends LocalizationsDelegate<Transl> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ["en"].contains(locale.languageCode);

  @override
  Future<Transl> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    Transl localizations = new Transl(locale);
//    await localizations.loadFromAsset();
    localizations.loadFromStaticField();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}

class Transl {
  static Map<String, String> _localizedStrings = {};

  final Locale locale;

  Transl(this.locale);

  Future loadFromAsset() async {
    final jsonString = await rootBundle.loadString("lang/${locale.languageCode}.json");
    _load(jsonString);
  }

  loadFromStaticField() {
    _load(Languages.map[locale.languageCode]);
  }

  _load(String jsonString) {
    try {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, stringOf(value)));
    } catch (ex) {
      logD(this, stringOf(ex));
    }
  }

  static Transl of(BuildContext context) => Localizations.of<Transl>(context, Transl);

  String get(String key) => _localizedStrings[key] ?? key;

  String getDesc(String key) => _localizedStrings["desc_$key"] ?? "desc_$key";

  String get app_name => get("app_name");

  String get stub => get("stub");

  String get screen_scan => get("screen_scan");

  String get screen_sign => get("screen_sign");

  String get screen_personalize => get("screen_personalize");

  String get screen_depersonalize => get("screen_depersonalize");

  String get screen_wallet_create => get("screen_wallet_create");

  String get screen_wallet_purge => get("screen_wallet_purge");

  String get screen_issuer_read_data => get("screen_issuer_read_data");

  String get screen_issuer_write_data => get("screen_issuer_write_data");

  String get screen_issuer_read_ex_data => get("screen_issuer_read_ex_data");

  String get screen_issuer_write_ex_data => get("screen_issuer_write_ex_data");

  String get screen_user_read_data => get("screen_user_read_data");

  String get screen_user_write_data => get("screen_user_write_data");

  String get screen_user_write_protected_data => get("screen_user_write_protected_data");

  String get screen_response => get("screen_response");

  String get screen_response_scan => get("screen_response_scan");

  String get screen_response_sign => get("screen_response_sign");

  String get screen_response_personalization => get("screen_response_personalization");

  String get screen_response_depersonalization => get("screen_response_depersonalization");

  String get screen_response_create_wallet => get("screen_response_create_wallet");

  String get screen_response_purge_wallet => get("screen_response_purge_wallet");

  String get screen_response_read_issuer_data => get("screen_response_read_issuer_data");

  String get screen_response_write_issuer_data => get("screen_response_write_issuer_data");

  String get screen_response_read_issuer_extra_data => get("screen_response_read_issuer_extra_data");

  String get screen_response_read_user_data => get("screen_response_read_user_data");

  String get screen_response_write_user_data => get("screen_response_write_user_data");

  String get screen_set_pin1 => get("screen_set_pin1");

  String get screen_set_pin2 => get("screen_set_pin2");

  String get menu_share => get("menu_share");

  String get menu_enable_description => get("menu_enable_description");

  String get menu_pers_configs => get("menu_pers_configs");

  String get menu_pers_config_reset => get("menu_pers_config_reset");

  String get menu_pers_config_save => get("menu_pers_config_save");

  String get menu_pers_config_load => get("menu_pers_config_load");

  String get menu_pers_import => get("menu_pers_import");

  String get menu_pers_export => get("menu_pers_export");

  String get action_scan => get("action_scan");

  String get desc_action_scan => get("desc_action_scan");

  String get action_sign => get("action_sign");

  String get desc_action_sign => get("desc_action_sign");

  String get action_personalize => get("action_personalize");

  String get desc_action_personalize => get("desc_action_personalize");

  String get action_depersonalize => get("action_depersonalize");

  String get desc_action_depersonalize => get("desc_action_depersonalize");

  String get action_create_wallet => get("action_create_wallet");

  String get desc_action_create_wallet => get("desc_action_create_wallet");

  String get action_purge_wallet => get("action_purge_wallet");

  String get desc_action_purge_wallet => get("desc_action_purge_wallet");

  String get action_issuer_read_data => get("action_issuer_read_data");

  String get desc_action_issuer_read_data => get("desc_action_issuer_read_data");

  String get action_issuer_write_data => get("action_issuer_write_data");

  String get desc_action_issuer_write_data => get("desc_action_issuer_write_data");

  String get action_issuer_read_ex_data => get("action_issuer_read_ex_data");

  String get desc_action_issuer_read_ex_data => get("desc_action_issuer_read_ex_data");

  String get action_issuer_write_ex_data => get("action_issuer_write_ex_data");

  String get desc_action_issuer_write_ex_data => get("desc_action_issuer_write_ex_data");

  String get action_user_read_data => get("action_user_read_data");

  String get desc_action_user_read_data => get("desc_action_user_read_data");

  String get action_user_write_data => get("action_user_write_data");

  String get desc_action_user_write_data => get("desc_action_user_write_data");

  String get action_user_write_protected_data => get("action_user_write_protected_data");

  String get desc_action_user_write_protected_data => get("desc_action_user_write_protected_data");

  String get pers_segment_card_number => get("pers_segment_card_number");

  String get desc_pers_segment_card_number => get("desc_pers_segment_card_number");

  String get pers_segment_common => get("pers_segment_common");

  String get desc_pers_segment_common => get("desc_pers_segment_common");

  String get pers_segment_signing_method => get("pers_segment_signing_method");

  String get desc_pers_segment_signing_method => get("desc_pers_segment_signing_method");

  String get pers_segment_sign_hash_ex_prop => get("pers_segment_sign_hash_ex_prop");

  String get desc_pers_segment_sign_hash_ex_prop => get("desc_pers_segment_sign_hash_ex_prop");

  String get pers_segment_denomination => get("pers_segment_denomination");

  String get desc_pers_segment_denomination => get("desc_pers_segment_denomination");

  String get pers_segment_token => get("pers_segment_token");

  String get desc_pers_segment_token => get("desc_pers_segment_token");

  String get pers_segment_product_mask => get("pers_segment_product_mask");

  String get desc_pers_segment_product_mask => get("desc_pers_segment_product_mask");

  String get pers_segment_settings_mask => get("pers_segment_settings_mask");

  String get desc_pers_segment_settings_mask => get("desc_pers_segment_settings_mask");

  String get pers_segment_settings_mask_protocol_enc => get("pers_segment_settings_mask_protocol_enc");

  String get desc_pers_segment_settings_mask_protocol_enc => get("desc_pers_segment_settings_mask_protocol_enc");

  String get pers_segment_settings_mask_ndef => get("pers_segment_settings_mask_ndef");

  String get desc_pers_segment_settings_mask_ndef => get("desc_pers_segment_settings_mask_ndef");

  String get pers_segment_pins => get("pers_segment_pins");

  String get desc_pers_segment_pins => get("desc_pers_segment_pins");

  String get pers_item_series => get("pers_item_series");

  String get desc_pers_item_series => get("desc_pers_item_series");

  String get pers_item_number => get("pers_item_number");

  String get desc_pers_item_number => get("desc_pers_item_number");

  String get pers_item_batch_id => get("pers_item_batch_id");

  String get desc_pers_item_batch_id => get("desc_pers_item_batch_id");

  String get pers_item_curve => get("pers_item_curve");

  String get desc_pers_item_curve => get("desc_pers_item_curve");

  String get pers_item_blockchain => get("pers_item_blockchain");

  String get desc_pers_item_blockchain => get("desc_pers_item_blockchain");

  String get pers_item_custom_blockchain => get("pers_item_custom_blockchain");

  String get desc_pers_item_custom_blockchain => get("desc_pers_item_custom_blockchain");

  String get pers_item_max_signatures => get("pers_item_max_signatures");

  String get desc_pers_item_max_signatures => get("desc_pers_item_max_signatures");

  String get pers_item_create_wallet => get("pers_item_create_wallet");

  String get desc_pers_item_create_wallet => get("desc_pers_item_create_wallet");

  String get pers_item_sign_tx_hashes => get("pers_item_sign_tx_hashes");

  String get desc_pers_item_sign_tx_hashes => get("desc_pers_item_sign_tx_hashes");

  String get pers_item_sign_raw_tx => get("pers_item_sign_raw_tx");

  String get desc_pers_item_sign_raw_tx => get("desc_pers_item_sign_raw_tx");

  String get pers_item_sign_validated_tx_hashes => get("pers_item_sign_validated_tx_hashes");

  String get desc_pers_item_sign_validated_tx_hashes => get("desc_pers_item_sign_validated_tx_hashes");

  String get pers_item_sign_validated_raw_tx => get("pers_item_sign_validated_raw_tx");

  String get desc_pers_item_sign_validated_raw_tx => get("desc_pers_item_sign_validated_raw_tx");

  String get pers_item_sign_validated_tx_hashes_with_iss_data => get("pers_item_sign_validated_tx_hashes_with_iss_data");

  String get desc_pers_item_sign_validated_tx_hashes_with_iss_data => get("desc_pers_item_sign_validated_tx_hashes_with_iss_data");

  String get pers_item_sign_validated_raw_tx_with_iss_data => get("pers_item_sign_validated_raw_tx_with_iss_data");

  String get desc_pers_item_sign_validated_raw_tx_with_iss_data => get("desc_pers_item_sign_validated_raw_tx_with_iss_data");

  String get pers_item_sign_hash_ex => get("pers_item_sign_hash_ex");

  String get desc_pers_item_sign_hash_ex => get("desc_pers_item_sign_hash_ex");

  String get pers_item_pin_less_floor_limit => get("pers_item_pin_less_floor_limit");

  String get desc_pers_item_pin_less_floor_limit => get("desc_pers_item_pin_less_floor_limit");

  String get pers_item_cr_ex_key => get("pers_item_cr_ex_key");

  String get desc_pers_item_cr_ex_key => get("desc_pers_item_cr_ex_key");

  String get pers_item_require_terminal_cert_sig => get("pers_item_require_terminal_cert_sig");

  String get desc_pers_item_require_terminal_cert_sig => get("desc_pers_item_require_terminal_cert_sig");

  String get pers_item_require_terminal_tx_sig => get("pers_item_require_terminal_tx_sig");

  String get desc_pers_item_require_terminal_tx_sig => get("desc_pers_item_require_terminal_tx_sig");

  String get pers_item_check_pin3_on_card => get("pers_item_check_pin3_on_card");

  String get desc_pers_item_check_pin3_on_card => get("desc_pers_item_check_pin3_on_card");

  String get pers_item_write_on_personalize => get("pers_item_write_on_personalize");

  String get desc_pers_item_write_on_personalize => get("desc_pers_item_write_on_personalize");

  String get pers_item_denomination => get("pers_item_denomination");

  String get desc_pers_item_denomination => get("desc_pers_item_denomination");

  String get pers_item_its_token => get("pers_item_its_token");

  String get desc_pers_item_its_token => get("desc_pers_item_its_token");

  String get pers_item_symbol => get("pers_item_symbol");

  String get desc_pers_item_symbol => get("desc_pers_item_symbol");

  String get pers_item_contract_address => get("pers_item_contract_address");

  String get desc_pers_item_contract_address => get("desc_pers_item_contract_address");

  String get pers_item_decimal => get("pers_item_decimal");

  String get desc_pers_item_decimal => get("desc_pers_item_decimal");

  String get pers_item_note => get("pers_item_note");

  String get desc_pers_item_note => get("desc_pers_item_note");

  String get pers_item_tag => get("pers_item_tag");

  String get desc_pers_item_tag => get("desc_pers_item_tag");

  String get pers_item_id_card => get("pers_item_id_card");

  String get desc_pers_item_id_card => get("desc_pers_item_id_card");

  String get pers_item_id_issuer_card => get("pers_item_id_issuer_card");

  String get desc_pers_item_id_issuer_card => get("desc_pers_item_id_issuer_card");

  String get pers_item_is_reusable => get("pers_item_is_reusable");

  String get desc_pers_item_is_reusable => get("desc_pers_item_is_reusable");

  String get pers_item_use_activation => get("pers_item_use_activation");

  String get desc_pers_item_use_activation => get("desc_pers_item_use_activation");

  String get pers_item_forbid_purge => get("pers_item_forbid_purge");

  String get desc_pers_item_forbid_purge => get("desc_pers_item_forbid_purge");

  String get pers_item_allow_select_blockchain => get("pers_item_allow_select_blockchain");

  String get desc_pers_item_allow_select_blockchain => get("desc_pers_item_allow_select_blockchain");

  String get pers_item_use_block => get("pers_item_use_block");

  String get desc_pers_item_use_block => get("desc_pers_item_use_block");

  String get pers_item_one_apdu_at_once => get("pers_item_one_apdu_at_once");

  String get desc_pers_item_one_apdu_at_once => get("desc_pers_item_one_apdu_at_once");

  String get pers_item_use_cvc => get("pers_item_use_cvc");

  String get desc_pers_item_use_cvc => get("desc_pers_item_use_cvc");

  String get pers_item_allow_swap_pin1 => get("pers_item_allow_swap_pin");

  String get desc_pers_item_allow_swap_pin1 => get("desc_pers_item_allow_swap_pin");

  String get pers_item_allow_swap_pin2 => get("pers_item_allow_swap_pin2");

  String get desc_pers_item_allow_swap_pin2 => get("desc_pers_item_allow_swap_pin2");

  String get pers_item_forbid_default_pin => get("pers_item_forbid_default_pin");

  String get desc_pers_item_forbid_default_pin => get("desc_pers_item_forbid_default_pin");

  String get pers_item_smart_security_delay => get("pers_item_smart_security_delay");

  String get desc_pers_item_smart_security_delay => get("desc_pers_item_smart_security_delay");

  String get pers_item_protect_issuer_data_against_replay => get("pers_item_protect_issuer_data_against_replay");

  String get desc_pers_item_protect_issuer_data_against_replay => get("desc_pers_item_protect_issuer_data_against_replay");

  String get pers_item_skip_security_delay_if_validated => get("pers_item_skip_security_delay_if_validated");

  String get desc_pers_item_skip_security_delay_if_validated => get("desc_pers_item_skip_security_delay_if_validated");

  String get pers_item_skip_pin2_and_cvc_if_validated => get("pers_item_skip_pin2_and_cvc_if_validated");

  String get desc_pers_item_skip_pin2_and_cvc_if_validated => get("desc_pers_item_skip_pin2_and_cvc_if_validated");

  String get pers_item_skip_security_delay_on_linked_terminal => get("pers_item_skip_security_delay_on_linked_terminal");

  String get desc_pers_item_skip_security_delay_on_linked_terminal => get("desc_pers_item_skip_security_delay_on_linked_terminal");

  String get pers_item_restrict_overwrite_ex_issuer_data => get("pers_item_restrict_overwrite_ex_issuer_data");

  String get desc_pers_item_restrict_overwrite_ex_issuer_data => get("desc_pers_item_restrict_overwrite_ex_issuer_data");

  String get pers_item_allow_unencrypted => get("pers_item_allow_unencrypted");

  String get desc_pers_item_allow_unencrypted => get("desc_pers_item_allow_unencrypted");

  String get pers_item_allow_fast_encryption => get("pers_item_allow_fast_encryption");

  String get desc_pers_item_allow_fast_encryption => get("desc_pers_item_allow_fast_encryption");

  String get pers_item_use_ndef => get("pers_item_use_ndef");

  String get desc_pers_item_use_ndef => get("desc_pers_item_use_ndef");

  String get pers_item_dynamic_ndef => get("pers_item_dynamic_ndef");

  String get desc_pers_item_dynamic_ndef => get("desc_pers_item_dynamic_ndef");

  String get pers_item_disable_precomputed_ndef => get("pers_item_disable_precomputed_ndef");

  String get desc_pers_item_disable_precomputed_ndef => get("desc_pers_item_disable_precomputed_ndef");

  String get pers_item_aar => get("pers_item_aar");

  String get desc_pers_item_aar => get("desc_pers_item_aar");

  String get pers_item_custom_aar_package_name => get("pers_item_custom_aar_package_name");

  String get desc_pers_item_custom_aar_package_name => get("desc_pers_item_custom_aar_package_name");

  String get pers_item_uri => get("pers_item_uri");

  String get desc_pers_item_uri => get("desc_pers_item_uri");

  String get pers_item_pin => get("pers_item_pin");

  String get desc_pers_item_pin => get("desc_pers_item_pin");

  String get pers_item_pin2 => get("pers_item_pin2");

  String get desc_pers_item_pin2 => get("desc_pers_item_pin2");

  String get pers_item_pin3 => get("pers_item_pin3");

  String get desc_pers_item_pin3 => get("desc_pers_item_pin3");

  String get pers_item_cvc => get("pers_item_cvc");

  String get desc_pers_item_cvc => get("desc_pers_item_cvc");

  String get pers_item_pause_before_pin2 => get("pers_item_pause_before_pin2");

  String get desc_pers_item_pause_before_pin2 => get("desc_pers_item_pause_before_pin2");

  String get response_card_cid => get("response_card_cid");

  String get desc_response_card_cid => get("desc_response_card_cid");

  String get response_card_manufacturer_name => get("response_card_manufacturer_name");

  String get desc_response_card_manufacturer_name => get("desc_response_card_manufacturer_name");

  String get response_card_status => get("response_card_status");

  String get desc_response_card_status => get("desc_response_card_status");

  String get response_card_firmware_version => get("response_card_firmware_version");

  String get desc_response_card_firmware_version => get("desc_response_card_firmware_version");

  String get response_card_public_key => get("response_card_public_key");

  String get desc_response_card_public_key => get("desc_response_card_public_key");

  String get response_card_settings_mask => get("response_card_settings_mask");

  String get desc_response_card_settings_mask => get("desc_response_card_settings_mask");

  String get response_card_is_reusable => get("response_card_is_reusable");

  String get desc_response_card_is_reusable => get("desc_response_card_is_reusable");

  String get response_card_use_activation => get("response_card_use_activation");

  String get desc_response_card_use_activation => get("desc_response_card_use_activation");

  String get response_card_purge_wallet => get("response_card_purge_wallet");

  String get desc_response_card_purge_wallet => get("desc_response_card_purge_wallet");

  String get response_card_use_block => get("response_card_use_block");

  String get desc_response_card_use_block => get("desc_response_card_use_block");

  String get response_card_allow_pin => get("response_card_allow_pin");

  String get desc_response_card_allow_pin => get("desc_response_card_allow_pin");

  String get response_card_allow_pin2 => get("response_card_allow_pin2");

  String get desc_response_card_allow_pin2 => get("desc_response_card_allow_pin2");

  String get response_card_use_cvc => get("response_card_use_cvc");

  String get desc_response_card_use_cvc => get("desc_response_card_use_cvc");

  String get response_card_default_pin => get("response_card_default_pin");

  String get desc_response_card_default_pin => get("desc_response_card_default_pin");

  String get response_card_one_apdu_at_time => get("response_card_one_apdu_at_time");

  String get desc_response_card_one_apdu_at_time => get("desc_response_card_one_apdu_at_time");

  String get response_card_use_ndef => get("response_card_use_ndef");

  String get desc_response_card_use_ndef => get("desc_response_card_use_ndef");

  String get response_card_use_dynamic_ndef => get("response_card_use_dynamic_ndef");

  String get desc_response_card_use_dynamic_ndef => get("desc_response_card_use_dynamic_ndef");

  String get response_card_smart_security_delay => get("response_card_smart_security_delay");

  String get desc_response_card_smart_security_delay => get("desc_response_card_smart_security_delay");

  String get response_card_allow_unencrypted => get("response_card_allow_unencrypted");

  String get desc_response_card_allow_unencrypted => get("desc_response_card_allow_unencrypted");

  String get response_card_allow_fast_encryption => get("response_card_allow_fast_encryption");

  String get desc_response_card_allow_fast_encryption => get("desc_response_card_allow_fast_encryption");

  String get response_card_protect_issuer_data_against_replay => get("response_card_protect_issuer_data_against_replay");

  String get desc_response_card_protect_issuer_data_against_replay => get("desc_response_card_protect_issuer_data_against_replay");

  String get response_card_allow_select_blockchain => get("response_card_allow_select_blockchain");

  String get desc_response_card_allow_select_blockchain => get("desc_response_card_allow_select_blockchain");

  String get response_card_disable_precomputed_ndef => get("response_card_disable_precomputed_ndef");

  String get desc_response_card_disable_precomputed_ndef => get("desc_response_card_disable_precomputed_ndef");

  String get response_card_security_delay_if_validated => get("response_card_security_delay_if_validated");

  String get desc_response_card_security_delay_if_validated => get("desc_response_card_security_delay_if_validated");

  String get response_card_skip_pin2_cvc_if_validated_by_issuer => get("response_card_skip_pin2_cvc_if_validated_by_issuer");

  String get desc_response_card_skip_pin2_cvc_if_validated_by_issuer => get("desc_response_card_skip_pin2_cvc_if_validated_by_issuer");

  String get response_card_skip_security_delay_if_validated_by_linked_terminal =>
      get("response_card_skip_security_delay_if_validated_by_linked_terminal");

  String get desc_response_card_skip_security_delay_if_validated_by_linked_terminal =>
      get("desc_response_card_skip_security_delay_if_validated_by_linked_terminal");

  String get response_card_restrict_overwrite_issuer_ex_data => get("response_card_restrict_overwrite_issuer_ex_data");

  String get desc_response_card_restrict_overwrite_issuer_ex_data => get("desc_response_card_restrict_overwrite_issuer_ex_data");

  String get response_card_prohibit_overwriting_issuer_ex_data => get("response_card_prohibit_overwriting_issuer_ex_data");

  String get desc_response_card_prohibit_overwriting_issuer_ex_data => get("desc_response_card_prohibit_overwriting_issuer_ex_data");

  String get response_card_require_terminal_tx_sig => get("response_card_require_terminal_tx_sig");

  String get desc_response_card_require_terminal_tx_sig => get("desc_response_card_require_terminal_tx_sig");

  String get response_card_require_terminal_cert_sig => get("response_card_require_terminal_cert_sig");

  String get desc_response_card_require_terminal_cert_sig => get("desc_response_card_require_terminal_cert_sig");

  String get response_card_check_pin3 => get("response_card_check_pin3");

  String get desc_response_card_check_pin3 => get("desc_response_card_check_pin3");

  String get response_card_card_data => get("response_card_card_data");

  String get desc_response_card_card_data => get("desc_response_card_card_data");

  String get response_card_issuer_data_public_key => get("response_card_issuer_data_public_key");

  String get desc_response_card_issuer_data_public_key => get("desc_response_card_issuer_data_public_key");

  String get response_card_curve => get("response_card_curve");

  String get desc_response_card_curve => get("desc_response_card_curve");

  String get response_card_max_signatures => get("response_card_max_signatures");

  String get desc_response_card_max_signatures => get("desc_response_card_max_signatures");

  String get response_card_signing_method => get("response_card_signing_method");

  String get desc_response_card_signing_method => get("desc_response_card_signing_method");

  String get response_card_pause_before_pin2 => get("response_card_pause_before_pin2");

  String get desc_response_card_pause_before_pin2 => get("desc_response_card_pause_before_pin2");

  String get response_card_wallet_public_key => get("response_card_wallet_public_key");

  String get desc_response_card_wallet_public_key => get("desc_response_card_wallet_public_key");

  String get response_card_wallet_remaining_signatures => get("response_card_wallet_remaining_signatures");

  String get desc_response_card_wallet_remaining_signatures => get("desc_response_card_wallet_remaining_signatures");

  String get response_card_wallet_signed_hashes => get("response_card_wallet_signed_hashes");

  String get desc_response_card_wallet_signed_hashes => get("desc_response_card_wallet_signed_hashes");

  String get response_card_health => get("response_card_health");

  String get desc_response_card_health => get("desc_response_card_health");

  String get response_card_is_activated => get("response_card_is_activated");

  String get desc_response_card_is_activated => get("desc_response_card_is_activated");

  String get response_card_activation_seed => get("response_card_activation_seed");

  String get desc_response_card_activation_seed => get("desc_response_card_activation_seed");

  String get response_card_payment_flow_version => get("response_card_payment_flow_version");

  String get desc_response_card_payment_flow_version => get("desc_response_card_payment_flow_version");

  String get response_card_user_counter => get("response_card_user_counter");

  String get desc_response_card_user_counter => get("desc_response_card_user_counter");

  String get response_card_user_protected_counter => get("response_card_user_protected_counter");

  String get desc_response_card_user_protected_counter => get("desc_response_card_user_protected_counter");

  String get response_card_card_data_batch_id => get("response_card_card_data_batch_id");

  String get desc_response_card_card_data_batch_id => get("desc_response_card_card_data_batch_id");

  String get response_card_card_data_manufacture_date_time => get("response_card_card_data_manufacture_date_time");

  String get desc_response_card_card_data_manufacture_date_time => get("desc_response_card_card_data_manufacture_date_time");

  String get response_card_card_data_issuer_name => get("response_card_card_data_issuer_name");

  String get desc_response_card_card_data_issuer_name => get("desc_response_card_card_data_issuer_name");

  String get response_card_card_data_blockchain_name => get("response_card_card_data_blockchain_name");

  String get desc_response_card_card_data_blockchain_name => get("desc_response_card_card_data_blockchain_name");

  String get response_card_card_data_manufacturer_signature => get("response_card_card_data_manufacturer_signature");

  String get desc_response_card_card_data_manufacturer_signature => get("desc_response_card_card_data_manufacturer_signature");

  String get response_card_card_data_product_mask => get("response_card_card_data_product_mask");

  String get desc_response_card_card_data_product_mask => get("desc_response_card_card_data_product_mask");

  String get response_card_card_data_token_symbol => get("response_card_card_data_token_symbol");

  String get desc_response_card_card_data_token_symbol => get("desc_response_card_card_data_token_symbol");

  String get response_card_card_data_token_contract_address => get("response_card_card_data_token_contract_address");

  String get desc_response_card_card_data_token_contract_address => get("desc_response_card_card_data_token_contract_address");

  String get response_card_card_data_token_decimal => get("response_card_card_data_token_decimal");

  String get desc_response_card_card_data_token_decimal => get("desc_response_card_card_data_token_decimal");

  String get response_sign_cid => get("response_sign_cid");

  String get desc_response_sign_cid => get("desc_response_sign_cid");

  String get response_sign_wallet_signed_hashes => get("response_sign_wallet_signed_hashes");

  String get desc_response_sign_wallet_signed_hashes => get("desc_response_sign_wallet_signed_hashes");

  String get response_sign_wallet_remaining_signatures => get("response_sign_wallet_remaining_signatures");

  String get desc_response_sign_wallet_remaining_signatures => get("desc_response_sign_wallet_remaining_signatures");

  String get response_sign_signature => get("response_sign_signature");

  String get desc_response_sign_signature => get("desc_response_sign_signature");

  String get response_depersonalize_is_success => get("response_depersonalize_is_success");

  String get desc_response_depersonalize_is_success => get("desc_response_depersonalize_is_success");

  String get response_issuer_data_size => get("response_issuer_data_size");

  String get desc_response_issuer_data_size => get("desc_response_issuer_data_size");

  String get response_issuer_data => get("response_issuer_data");

  String get desc_response_issuer_data => get("desc_response_issuer_data");

  String get response_issuer_data_signature => get("response_issuer_data_signature");

  String get desc_response_issuer_data_signature => get("desc_response_issuer_data_signature");

  String get response_issuer_data_counter => get("response_issuer_data_counter");

  String get desc_response_issuer_data_counter => get("desc_response_issuer_data_counter");

  String get response_issuer_ex_data_size => get("response_issuer_ex_data_size");

  String get desc_response_issuer_ex_data_size => get("desc_response_issuer_ex_data_size");

  String get response_issuer_ex_data => get("response_issuer_ex_data");

  String get desc_response_issuer_ex_data => get("desc_response_issuer_ex_data");

  String get response_issuer_ex_data_signature => get("response_issuer_ex_data_signature");

  String get desc_response_issuer_ex_data_signature => get("desc_response_issuer_ex_data_signature");

  String get response_issuer_ex_data_counter => get("response_issuer_ex_data_counter");

  String get desc_response_issuer_ex_data_counter => get("desc_response_issuer_ex_data_counter");

  String get response_user_data => get("response_user_data");

  String get desc_response_user_data => get("desc_response_user_data");

  String get response_user_protected_data => get("response_user_protected_data");

  String get desc_response_user_protected_data => get("desc_response_user_protected_data");

  String get response_user_data_counter => get("response_user_data_counter");

  String get desc_response_user_data_counter => get("desc_response_user_data_counter");

  String get response_user_data_protected_counter => get("response_user_data_protected_counter");

  String get desc_response_user_data_protected_counter => get("desc_response_user_data_protected_counter");

  String get response_set_pin_status => get("response_set_pin_status");

  String get desc_response_set_pin_status => get("desc_response_set_pin_status");

  String get card_id => get("card_id");

  String get desc_card_id => get("desc_card_id");

  String get transaction_out_hash => get("transaction_out_hash");

  String get desc_transaction_out_hash => get("desc_transaction_out_hash");

  String get issuer_data => get("issuer_data");

  String get desc_issuer_data => get("desc_issuer_data");

  String get user_data => get("user_data");

  String get desc_user_data => get("desc_user_data");

  String get user_protected_data => get("user_protected_data");

  String get desc_user_protected_data => get("desc_protected_user_data");

  String get counter => get("counter");

  String get desc_counter => get("desc_counter");

  String get pin1 => get("pin1");

  String get desc_pin1 => get("desc_pin1");

  String get pin2 => get("pin2");

  String get desc_pin2 => get("desc_pin2");

  String get hint_enter_config_name => get("hint_enter_config_name");

  String get hint_paste => get("hint_paste");

  String get show_rare_fields => get("show_rare_fields");

  String get hide_rare_fields => get("hide_rare_fields");

  String get copy_to_clipboard => get("copy_to_clipboard");

  String get btn_delete => get("btn_delete");

  String get btn_ok => get("btn_ok");

  String get btn_cancel => get("btn_cancel");

  String get btn_save => get("btn_save");

  String get btn_load => get("btn_load");

  String get error_nothing_to_import => get("error_nothing_to_import");

  String get error_not_saved => get("error_not_saved");

  String get error_nothing_to_load => get("error_nothing_to_load");

  String get card_error_not_personalized => get("card_error_not_personalized");

  String get card_error_bad_series => get("card_error_bad_series");

  String get card_error_bad_series_number => get("card_error_bad_series_number");

  String get unknown => get("unknown");

  String get how_to_scan => get("how_to_scan");

  String get how_to_depersonalize => get("how_to_depersonalize");
}
