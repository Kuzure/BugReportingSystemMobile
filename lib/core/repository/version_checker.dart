
import 'dart:io';
import 'dart:typed_data';

import 'package:bugreportingsystem/core/client/api_anonymous_client.dart';
import 'package:bugreportingsystem/core/service/shared_preferences_service.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:r_upgrade/r_upgrade.dart';
import '../../translations/locale_keys.g.dart';
import '../../app_settings.dart';

class VersionChecker {
  final ApiSettings _apiSettings;

  VersionChecker({
    required ApiSettings? apiConfig,
  })
      : assert(apiConfig != null),
        _apiSettings = apiConfig!;

  Future tryUpdate(BuildContext context) async {
    try {
      var updateInfo = await _getUpdateInfo(context);
      if (updateInfo.isUpdateAvailable) {
        showAlertDialog(context,"Uwaga!",LocaleKeys.appNewVersionIsAvailable.tr(), updateInfo);
      }
    }
    catch (ex) {
      showAlertDialog(context,LocaleKeys.error_Occured.tr(),LocaleKeys.error_Failed_To_Fetch_Data.tr(), null);
    }
  }
  Future<String?> getAppVersion() async {
    try {
      ApiAnonymousClient apiService = ApiAnonymousClient(baseUrl: _apiSettings.coreUrl);
      var response = await apiService.getAppVersion();
      return response.version;
    } catch (e) {
      return null;
    }
  }

  Future<Uint8List?> getAppFile() async {
    try {
      HttpClient httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(_apiSettings.coreUrl + '/api/MobileVersion/download'));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      return bytes;
    }
    catch (ex) {
      return null;
    }
  }
  showAlertDialog(BuildContext context, String title, String content, updateInfo) {
    bool firstPress =true;

    Widget okButton = TextButton(
      child: Text(LocaleKeys.ok.tr()),
      onPressed: () async {
        if(firstPress) {
          Navigator.pop(context);

          ProgressDialog progressDialog;
          progressDialog = ProgressDialog(
            context,
            type: ProgressDialogType.normal,
            isDismissible: true,
            /// your body here
            customBody: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              backgroundColor: Colors.white,
            ),
          );
          progressDialog.style(
              message: 'Proszę czekać',backgroundColor: Colors.white);

          late String? apkPath;

          try {
            firstPress = false;
            if (updateInfo != null) {
              String name = updateInfo.version.replaceAll('.', '_');
              apkPath = await _downloadFile(
                  context, 'concretes_${name}.apk');

              await Future.delayed(Duration(seconds: 2));
            }
          }
          finally {
            await progressDialog.hide();
          }

          if (apkPath == null) {
            showAlertDialog(context,LocaleKeys.error_Occured.tr(),LocaleKeys.error_Update_Aborted.tr(), null);

          }

          if (await Permission.storage.isGranted) {
            bool? isSuccess =await RUpgrade.upgradeFromUrl(
              'pl.itmcode.report_app'
            );
            print(isSuccess);
          } else {
            showAlertDialog(context,LocaleKeys.error_Occured.tr(),LocaleKeys.error_Update_Aborted.tr(), null);
            print('Permission request fail!');
          }
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        firstPress ? okButton : Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 20,
            ),
          ),
        ),

      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<String> getCurrentVersion(BuildContext context) async {
    String? currentVersion = await getAppVersion();

    if ((currentVersion == null) || (currentVersion.compareTo(LocaleKeys.appVersion.tr()) != 0)) {
      currentVersion = LocaleKeys.appVersion.tr();
      await SharedPreferencesService().setAppVersion(currentVersion);
    }

    return currentVersion;
  }
  Future<_UpdateInfoModel> _getUpdateInfo(BuildContext context) async {
    String? currentVersion = await getCurrentVersion(context);
    String? newVersion = await getAppVersion();

    if (newVersion == null || currentVersion.isEmpty || newVersion.isEmpty) {
      return _UpdateInfoModel('', false);
    }

    int? nCurrentVersion = int.tryParse(currentVersion.replaceAll('.', ''));
    int? nNewVersion = int.tryParse(newVersion.replaceAll('.', ''));

    bool isUpdateAvailable = nCurrentVersion != null && nNewVersion != null && nCurrentVersion < nNewVersion;
    return _UpdateInfoModel(newVersion, isUpdateAvailable);
  }

  Future _downloadFile(BuildContext context, String fileName) async {
    String resultPath;

    try {

      var storageInfo = await getExternalStorageDirectory();

      var path = storageInfo!.path;
      var file = File('$path/$fileName');
      if (!file.existsSync()) {
        var fileContent = await getAppFile();
        file.writeAsBytes(fileContent!);
      }
      resultPath = file.path;

    }
    finally {
    }

    return resultPath;
  }
}

class _UpdateInfoModel {
  final String version;
  final bool isUpdateAvailable;

  _UpdateInfoModel(this.version, this.isUpdateAvailable);
}
