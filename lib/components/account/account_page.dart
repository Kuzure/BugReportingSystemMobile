
import 'package:bugreportingsystem/core/bloc/authentication/bloc/authentication_bloc.dart';
import 'package:bugreportingsystem/core/bloc/authentication/bloc/authentication_event.dart';
import 'package:bugreportingsystem/core/repository/bug_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {

  static Widget widget() {
    return AccountPage();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 30.0,),
          CircleAvatar(
            radius: 130.0,
            backgroundColor: Colors.white
          ),
          SizedBox(height: 50.0,),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: GFButton(
                child: new Text(
                  tr('acc_Log_Out'),
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                size: GFSize.LARGE,
                onPressed: () async {
                  await RepositoryProvider.of<BugRepository>(context).clearCache();
                  //await RepositoryProvider.of<SuppliesRepository>(context).authEvent();
                  //await RepositoryProvider.of<OrderRepository>(context).clearCache();
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
                }
            ),
          ),
          SizedBox(height: 50.0,),
          SizedBox(
            width: double.infinity,
            height: 60,

            child: GFButton(
                child: new Text(
                  tr('acc_Clear_Cache'),
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () async => {

                  await RepositoryProvider.of<BugRepository>(context).clearCache(),
                 // await RepositoryProvider.of<OrderRepository>(context).clearCache()
                }
            ),
          ),

          SizedBox(
            width: double.infinity,

            child: Text(
                   "ver. "+tr('appVersion'),
              style: TextStyle(
                fontSize: 18,
              ),
              )
          ),
        ],
      ),
    )
    );
  }

}
