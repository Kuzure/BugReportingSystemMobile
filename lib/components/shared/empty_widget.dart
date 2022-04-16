import 'package:bugreportingsystem/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 64.0,
          ),
          SizedBox(height: 16.0),
          Text(LocaleKeys.task_No_reports.tr(), style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300
          ))
        ],
      ),
    );
  }
}
