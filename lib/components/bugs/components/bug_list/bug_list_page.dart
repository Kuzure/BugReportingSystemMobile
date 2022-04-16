import 'package:bugreportingsystem/components/bugs/components/bug_list/bloc/bug_list_bloc.dart';
import 'package:bugreportingsystem/components/bugs/components/bug_list/bloc/bug_list_event.dart';
import 'package:bugreportingsystem/components/bugs/components/bug_list/bloc/bug_list_state.dart';
import 'package:bugreportingsystem/components/shared/center_loader_widget.dart';
import 'package:bugreportingsystem/components/shared/empty_widget.dart';
import 'package:bugreportingsystem/core/model/api/report.dart';
import 'package:bugreportingsystem/core/repository/bug_repository.dart';
import 'package:bugreportingsystem/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';


class BugListPage extends StatefulWidget{
  static Widget widget() {
    return BlocProvider(
        create: (context) => BugListBloc(
            bugRepository: context.read<BugRepository>()
        ) ..add(BugListFetchedEvent()),
        child: BugListPage()
    );
  }
_BugListPageState createState() => _BugListPageState();
}

class _BugListPageState extends State<BugListPage>{
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugListBloc, BugListState>(
      builder: (context, state) {
        if (state is BugListInitial) {
          return CenterLoaderWidget();
        }
        if (state is BugListError) {
          return _buttonErrorStatusWidget(state, context);
          //return ExceptionWidget(S.of(context).error_Failed_To_Fetch_Data);
        }

        if (state is BugListSuccess) {
          return RefreshIndicator(
            child: Stack(
              children: [
                if (state.bugs.length == 0)
                  EmptyWidget(),

                ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.bugs.length
                          ? _BottomLoader()
                          : _BugWidget(
                          report: state.bugs[index],
                          onTap: () {
                            _showDialog(context,state.bugs[index]);

                          }
                      );
                    },
                    itemCount: state.hasReachedMax
                        ? state.bugs.length
                        : state.bugs.length + 1,
                    controller: state.bugs.length > 0
                        ? _scrollController
                        : null
                )
              ],
            ),
            onRefresh: () async {
              context.read<BugListBloc>().add(BugListResetEvent());
            },
          );
        }

        return Container();
      },
    );
  }
  void _showDialog(BuildContext context,Report report) {
    var a;
    a='';
    if(report.comments!=null) {
      for (int i = 0; i < report.comments!.length; i++) {
        a =(a+report.comments![i].comment+"\n")!;
      }

    }
    Map<StatusEnum, String> SomeStatusName = {
      StatusEnum.Reported: "${LocaleKeys.Reported.tr()}",
      StatusEnum.Cancellation: "${LocaleKeys.Cancellation.tr()}",
      StatusEnum.Closed: "${LocaleKeys.Closed.tr()}",
      StatusEnum.Error: "${LocaleKeys.Error.tr()}",
      StatusEnum.InProgress:"${LocaleKeys.InProgress.tr()}",
      StatusEnum.Opened:"${LocaleKeys.Opened.tr()}",
      StatusEnum.Realized:"${LocaleKeys.Realized.tr()}",
    };
    Map<PriorityEnum, String> PriorityEnumMap = {
      PriorityEnum.Normal:"${LocaleKeys.name_Priority_enum.tr()}",
      PriorityEnum.High:"${LocaleKeys.second_name_Priority_enum.tr()}",
    };
    Map<TypeEnum, String> TypeEnumMap = {
      TypeEnum.Standard:"${LocaleKeys.name_Type_enum.tr()}",
      TypeEnum.VIP:"Vip",
    };
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("${LocaleKeys.title_Rapport.tr()}"),
          content: new SingleChildScrollView(
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                      "${LocaleKeys.commissioned_to.tr()}: ${report.supervisorEmail}\n"
                      "${LocaleKeys.category_name.tr()}: ${report.module!.name}\n"
                      "${LocaleKeys.description.tr()}: ${report.description}\n"
                      "${LocaleKeys.Priority.tr()}: ${PriorityEnumMap[PriorityEnum.values[report.priority]]}\n"
                      "${LocaleKeys.Status.tr()}: ${SomeStatusName[StatusEnum.values[report.status]]}\n"
                      "${LocaleKeys.Type.tr()}: ${TypeEnumMap[TypeEnum.values[report.type]]}\n"
                  "${LocaleKeys.supervisorComment.tr()}: ${a.toString()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,),
              ),
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Widget _buttonErrorStatusWidget(BugListError state, context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _errorButton(state.error.toString())
      ],
    ),);
  }
  Widget _errorButton(var error){

    return BlocBuilder<BugListBloc, BugListState>(

      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(error.toString(),style: new TextStyle(fontSize: 20.0,)),),

              SizedBox(height: 10,),
              SizedBox(
                  height: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                    child: GFButton(
                        size: GFSize.LARGE,
                        child: new Text(LocaleKeys.error_Try_again,style: new TextStyle(fontSize: 20.0,)),
                        type: GFButtonType.solid,
                        onPressed:()=>context.read<BugListBloc>().add(BugListResetEvent())

                    ),
                  )
              )
            ],
          ),
        );
      },
    );
  }
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<BugListBloc>().add(BugListFetchedEvent());
    }
  }


}

class _BugWidget extends StatelessWidget {
  final Report report;
  final Function() onTap;
  final Map<StatusEnum, String> SomeStatusName = {
    StatusEnum.Reported: "${LocaleKeys.Reported.tr()}",
    StatusEnum.Cancellation: "${LocaleKeys.Cancellation.tr()}",
    StatusEnum.Closed: "${LocaleKeys.Closed.tr()}",
    StatusEnum.Error: "${LocaleKeys.Error.tr()}",
    StatusEnum.InProgress:"${LocaleKeys.InProgress.tr()}",
    StatusEnum.Opened:"${LocaleKeys.Opened.tr()}",
    StatusEnum.Realized:"${LocaleKeys.Realized.tr()}",
  };
  _BugWidget({
    required this.report,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${report.reportNumber} ${SomeStatusName[StatusEnum.values[report.status]]}\n"
              "${report.description}\n"
                  "${report.module!.name }",
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.5,),
        ),
      ),
    );
  }

}
class _BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GFLoader(),
          )
      ),
    );
  }
}