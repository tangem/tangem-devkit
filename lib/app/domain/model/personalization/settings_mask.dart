enum Settings {
  IsReusable,
  UseActivation,
  ProhibitPurgeWallet,
  UseBlock,
  AllowSwapPIN,
  AllowSwapPIN2,
  UseCVC,
  ForbidDefaultPIN,
  UseOneCommandAtTime,
  UseNdef,
  UseDynamicNdef,
  SmartSecurityDelay,
  ProtocolAllowUnencrypted,
  ProtocolAllowStaticEncryption,
  ProtectIssuerDataAgainstReplay,
  RestrictOverwriteIssuerDataEx,
  AllowSelectBlockchain,
  DisablePrecomputedNdef,
  SkipSecurityDelayIfValidatedByLinkedTerminal,
  SkipCheckPin2andCvcIfValidatedByIssuer,
  SkipSecurityDelayIfValidatedByIssuer,
  RequireTermTxSignature,
  RequireTermCertSignature,
  CheckPIN3onCard
}

extension SettingsCodes on Settings {
  static const codes = {
    Settings.IsReusable: 0x0001,
    Settings.UseActivation: 0x0002,
    Settings.ProhibitPurgeWallet: 0x0004,
    Settings.UseBlock: 0x0008,
    Settings.AllowSwapPIN: 0x0010,
    Settings.AllowSwapPIN2: 0x0020,
    Settings.UseCVC: 0x0040,
    Settings.ForbidDefaultPIN: 0x0080,
    Settings.UseOneCommandAtTime: 0x0100,
    Settings.UseNdef: 0x0200,
    Settings.UseDynamicNdef: 0x0400,
    Settings.SmartSecurityDelay: 0x0800,
    Settings.ProtocolAllowUnencrypted: 0x1000,
    Settings.ProtocolAllowStaticEncryption: 0x2000,
    Settings.ProtectIssuerDataAgainstReplay: 0x4000,
    Settings.RestrictOverwriteIssuerDataEx: 0x00100000,
    Settings.AllowSelectBlockchain: 0x8000,
    Settings.DisablePrecomputedNdef: 0x00010000,
    Settings.SkipSecurityDelayIfValidatedByLinkedTerminal: 0x00080000,
    Settings.SkipCheckPin2andCvcIfValidatedByIssuer: 0x00040000,
    Settings.SkipSecurityDelayIfValidatedByIssuer: 0x00020000,
    Settings.RequireTermTxSignature: 0x01000000,
    Settings.RequireTermCertSignature: 0x02000000,
    Settings.CheckPIN3onCard: 0x04000000
  };

  int get code => codes[this];
}

class SettingsMaskBuilder {
  int settingsMaskValue = 0;

  add(Settings settings) {
    settingsMaskValue = settingsMaskValue | settings.code;
  }

  int build() => settingsMaskValue;
}

class SettingsMaskHelper {
  static bool valueContains(int rawValue, Settings settings) => (rawValue & settings.code) != 0;
  static SettingsMaskBuilder get createBuilder => SettingsMaskBuilder();
}
