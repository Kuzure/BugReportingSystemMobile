import 'package:alert/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertHelper {

  static void showSuccess(BuildContext context, String title, String message) {
    Alert(
       message: title,
      shortDuration: true,
    ).show();
  }

}