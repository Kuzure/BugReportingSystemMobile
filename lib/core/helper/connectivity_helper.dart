import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityHelper {

  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Stream<bool> isOnlineStream() {
    return Connectivity().onConnectivityChanged.map((ConnectivityResult event) => event != ConnectivityResult.none);
  }
}