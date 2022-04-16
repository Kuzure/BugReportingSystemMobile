import 'core/model/identity/user.dart';

enum AppConfigurationTypes{bug_report,bug_report2}
class AppConfiguration{
  static final AppConfiguration _singleton = AppConfiguration._internal();
   late Configuration configuration;
  factory AppConfiguration() {
    return _singleton;
  }
  AppConfiguration._internal();
  void setup(AppConfigurationTypes type) {
    configuration = Configuration(type);
  }
}

class Configuration {
  final bool useSignalr;
  final bool useScale;
  final List<String> allowedRoles;

  Configuration._({
     required this.useSignalr,
     required this.useScale,
     required this.allowedRoles
  });
  factory Configuration(AppConfigurationTypes configuration) {
    switch(configuration) {
       case AppConfigurationTypes.bug_report:
        return Configuration._bug_report();
      case AppConfigurationTypes.bug_report2:
        return Configuration._bug_report();
    }
  }

  Configuration._bug_report() : this._(
      useSignalr: false,
      useScale: false,
      allowedRoles: [ UserRoles.user ]
  );
}