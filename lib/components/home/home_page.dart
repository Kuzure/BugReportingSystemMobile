import 'package:bugreportingsystem/components/account/account_page.dart';
import 'package:bugreportingsystem/components/bugs/components/add_bug/add_bug_page.dart';
import 'package:bugreportingsystem/components/bugs/components/bug_list/bug_list_page.dart';
import 'package:bugreportingsystem/core/model/identity/user.dart';
import 'package:bugreportingsystem/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bloc/alert_bloc.dart';
import 'bloc/alert_state.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomePage extends StatefulWidget{
  static Route route(User user, {TabTypes? initialTab}) {
    return MaterialPageRoute<void>(
        builder: (_) =>
            BlocProvider(
                create: (_) => HomeBloc(),
                child: HomePage(user, initialTab)
            )
    );
  }
  final User user;
  final TabTypes? initialTab;

  HomePage(this.user, this.initialTab);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
   late _HomePageBuilder _pageBuilder;
   late TabController _tabController;

  @override
  void initState() {
    super.initState();

    switch (widget.user.role) {
      case UserRoles.user:
        _pageBuilder = _UserHomePageBuilder();
        break;

      case UserRoles.admin:
        _pageBuilder = _UserHomePageBuilder();
        break;
    }


    _tabController = TabController(
        initialIndex: widget.initialTab != null ? _pageBuilder.getIndex(
            widget.initialTab!) : 0,
        length: _pageBuilder.tabsLength,
        vsync: this
    );

    _tabController.addListener(() {
      int index = _tabController.index;
      String title = _pageBuilder.getTitle(context, index);
      TabTypes tabType = _pageBuilder.getTabType(index);

      context.read<HomeBloc>().add(HomeTitleChangedEvent(title, tabType));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlertBloc, AlertState>(
        listenWhen: (prevState, state) => (state.title != null && state.title!.isNotEmpty) || (state.message != null && state.message!.isNotEmpty),
        listener: (context, state) {

        },
        child: BlocConsumer<HomeBloc, HomeState>(
            listenWhen: (prevState, state) => prevState.activeTab != state.activeTab,
            listener: (prevState, state) {
              int index = _pageBuilder.getIndex(state.activeTab);
              _tabController.animateTo(index);
            },
            buildWhen: (prevSate, state) => prevSate.title != state.title,
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.blue[50],

                    bottomNavigationBar: GFTabBar(
                      controller: _tabController,
                      labelColor: Theme.of(context).primaryColor,
                      tabBarColor: Colors.blue[50],
                      unselectedLabelColor: Colors.blueGrey,
                      length: _pageBuilder.tabsLength,
                      tabs: _pageBuilder.getTabs(),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: _pageBuilder.getBodies(),
                    )
                ),
              );
            }
        )
    );
  }
   @override
   void dispose() {
     super.dispose();
     _tabController.dispose();
   }
}


abstract class _HomePageBuilder {
  List<_Tab> get tabs;

  int getIndex(TabTypes type) {
    int index = tabs.indexWhere((x) => x.type == type);
    return index != -1 ? index : 0;
  }

  TabTypes getTabType(int index) {
    TabTypes tabType = tabs[index].type;
    return tabType;
  }

  String getTitle(BuildContext context, int index) {
    return tabs[index].titleFactory(context);
  }

  List<Widget> getTabs() {
    return tabs.map((x) => Tab(
        icon: Icon(
            x.icon,
            size: 28.0
        )
    )).toList();
  }

  List<Widget> getBodies() {
    return tabs.map((x) => x.body).toList();
  }

  int get tabsLength => tabs.length;
}

class _Tab {
  final TabTypes type;
  Function titleFactory;
  final IconData icon;
  final Widget body;

  _Tab({
     required this.type,
     required this.titleFactory,
     required this.icon,
     required this.body
  });
}
class _UserHomePageBuilder  extends _HomePageBuilder{
   late List<_Tab> _tabs;

  _UserHomePageBuilder() {
    _tabs = [

      _Tab(
          type: TabTypes.reportList,
          titleFactory: (context) => LocaleKeys.task_Bug_List.tr(),
          icon: MdiIcons.viewList,
          body: BugListPage.widget()
      ),
      _Tab(
          type: TabTypes.addBug,
          titleFactory: (context) => LocaleKeys.task_Add_Bug.tr(),
          icon: MdiIcons.plusCircle,
          body: AddBugPage.widget()
      ),
    _Tab(
    type: TabTypes.account,
    titleFactory: (context) => LocaleKeys.acc_login_Account.tr(),
    icon: MdiIcons.account,
    body: AccountPage.widget()
    ),
      /*
      _Tab(
          type: TabTypes.addBug,
          titleFactory: (context) => S.of(context).task_Active_Supply,
          icon: MdiIcons.truck,
          body: AddBugPage.widget()
      ),*/
    ];
  }
  List<_Tab> get tabs => _tabs;
}
/*class
_AdminHomePageBuilder extends _HomePageBuilder {
  List<_Tab> _tabs;

  _AdminHomePageBuilder() {
    _tabs = [
      _Tab(
          type: TabTypes.service,
          titleFactory: (context) => "Obsluga",
          icon: MdiIcons.wrench,
          body: AdminServicePage.widget()
      ),

      _Tab(
          type: TabTypes.listOrder,
          titleFactory: (context) => 'Zamowienia',
          icon: MdiIcons.viewList,
          body: AdminListPage.widget()
      ),
      _Tab(
          type: TabTypes.account,
          titleFactory: (context) => S.of(context).acc_login_Account,
          icon: MdiIcons.account,
          body: AccountPage.widget()
      )
    ];
  }

  @override
  List<_Tab> get tabs => _tabs;
}
*/