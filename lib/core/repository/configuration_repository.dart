

import '../../app_settings.dart';

class ConfigurationRepository {
  final AppSettings _config;

  ConfigurationRepository({
    required AppSettings? config
  }) : assert(config != null),
        _config = config!;

  AppSettings get settings => _config;

  AuthSettings get authSettings => _config.authConfig;

  ApiSettings get apiSettings => _config.apiConfig;
}