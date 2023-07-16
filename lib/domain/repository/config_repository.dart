import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepository(this._remoteConfig);

  bool get useDefaultColor =>
      _remoteConfig.getBool(_ConfigFields.useDefaultColor);

  Future<void> init() async {
    _remoteConfig.setDefaults({
      _ConfigFields.useDefaultColor: true,
    });
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const useDefaultColor = 'use_default_color';
}
