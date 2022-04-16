import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

enum AppEnvironment {test, production}

class AppSettings {
  final AuthSettings authConfig;
  final ApiSettings apiConfig;

  AppSettings._({
     required this.authConfig,
     required this.apiConfig
  });

  factory AppSettings(AppEnvironment environment) {
    switch(environment) {

      case AppEnvironment.test:
        return AppSettings._test();

      case AppEnvironment.production:
        return AppSettings._production();
    }

  }

  AppSettings._test() : this._(
      authConfig: AuthSettings(
          baseUrl: '',
            tokenEndpoint: '/connect/token',
          clientId: 'mobile_reports_client'
      ),
      apiConfig: ApiSettings(
          coreUrl: '',
          integrationUrl: '',
          signalrUrl: '',
          secondUrl: ''
      )
  );


  AppSettings._production() : this._(
      authConfig: AuthSettings(
          baseUrl: '',
          tokenEndpoint: '/connect/token',
          clientId: 'mobile_reports_client'
      ),
      apiConfig: ApiSettings(
          coreUrl: '',
          integrationUrl: '',
          signalrUrl: '',
          secondUrl: ''
      )
  );

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings._(
        authConfig: AuthSettings.fromJson(json['authConfig']),
        apiConfig: ApiSettings.fromJson(json['apiSettings'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authConfig' : authConfig.toJson(),
      'apiSettings' : apiConfig.toJson()
    };
  }
}

@JsonSerializable()
class AuthSettings {
  final String baseUrl;
  final String tokenEndpoint;
  final String clientId;

  AuthSettings({
     required this.baseUrl,
     required this.tokenEndpoint,
     required this.clientId
  });

  factory AuthSettings.fromJson(Map<String, dynamic> json) => _$AuthSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSettingsToJson(this);
}

@JsonSerializable()
class ApiSettings {
  final String coreUrl;
  final String integrationUrl;
  final String signalrUrl;
  final String secondUrl;
  ApiSettings({
     required this.coreUrl,
     required this.integrationUrl,
     required this.signalrUrl,
    required this.secondUrl,
  });

  factory ApiSettings.fromJson(Map<String, dynamic> json) => _$ApiSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$ApiSettingsToJson(this);
}
