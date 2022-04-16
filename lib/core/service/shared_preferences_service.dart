import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String APP_VERSION_KEY = 'app_version';

  Future<bool> setEmail(String direction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user_email", direction);
  }
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user_email")) {
      return prefs.getString("user_email");
    }
    return null;
  }
  Future<bool> setLanguage(String direction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("language", direction);
  }
  Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("language")) {
      return prefs.getString("language");
    }
    return 'pl';
  }
  Future<bool> setStopwatch(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt("stopwatch", time);
  }
  Future<int?> getStopwatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("stopwatch")) {
      return prefs.getInt("stopwatch");
    }
    return 0;
  }
  Future<bool> setStopwatchStop(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt("stopwatchStop", time);
  }
  Future<int?> getStopwatchStop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("stopwatchStop")) {
      return prefs.getInt("stopwatchStop");
    }
    return 0;
  }
  Future<String?> getAppVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(APP_VERSION_KEY)) {
      return prefs.getString(APP_VERSION_KEY);
    }
    return null;
  }

  Future<bool> setAppVersion(String version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(APP_VERSION_KEY, version);
  }
}