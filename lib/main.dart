
import 'package:bugreportingsystem/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'app_configuration.dart';
import 'app_settings.dart';
import 'core/repository/authentication_repository.dart';
import 'core/repository/configuration_repository.dart';
import 'core/service/oauth2_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfiguration().setup(AppConfigurationTypes.bug_report);
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  final AppSettings appSettings = AppSettings(AppEnvironment.test);
  runApp(
      Phoenix(
        child:
           EasyLocalization(
             supportedLocales: [
               Locale('pl'),
             ],
             path: 'assets/translations',
             fallbackLocale: Locale('pl'),
             assetLoader: CodegenLoader(),
             child: App(
               configurationRepository: ConfigurationRepository(
                   config: appSettings
               ),
               authenticationRepository: AuthenticationRepository(
                   oauth2Service: OAuth2Service(
                       config: appSettings.authConfig
                   )
               ),

             ),
           )
      )
  );
}