import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:bugreportingsystem/components/shared/center_loader_widget.dart';
import 'package:bugreportingsystem/core/helper/context_keeper.dart';
import 'package:bugreportingsystem/core/model/api/add_report.dart';
import 'package:bugreportingsystem/core/model/api/module_model.dart';
import 'package:bugreportingsystem/core/model/api/module_model_response.dart';
import 'package:bugreportingsystem/core/repository/authentication_repository.dart';
import 'package:bugreportingsystem/core/repository/bug_repository.dart';
import 'package:bugreportingsystem/translations/locale_keys.g.dart';
import 'package:device_information/device_information.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'bloc/add_bug_bloc.dart';
import 'bloc/add_bug_event.dart';
import 'bloc/add_bug_state.dart';

final descriptionController = TextEditingController();
ModuleModelResponse? model;
int? val=-1;
int? _type=-1;

Map<PriorityEnum, String> PriorityEnumMap = {
  PriorityEnum.Normal:"Normal",
  PriorityEnum.High:"High",
};
Map<TypeEnum, String> TypeEnumMap = {
  TypeEnum.Standard:"Standard",
  TypeEnum.VIP:"Vip",
};

class AddBugPage extends StatefulWidget {

  static Widget widget() {
    return BlocProvider(
        create: (context) => AddBugBloc(
            bugRepository: context.read<BugRepository>(),
            authenticationRepository: context.read<AuthenticationRepository>()
        ) ..add(AddBugWaitingForEvent()),
        child: AddBugPage()
    );
  }

  @override
  _AddBugPageState createState() => _AddBugPageState();

}

class _AddBugPageState extends State<AddBugPage> {

  GlobalKey? key =
  new GlobalKey<AutoCompleteTextFieldState<ModuleModel>>();
  late AutoCompleteTextField<ModuleModel> textField;
  late ModuleModel selected;

  @override
  Widget build(BuildContext context) {
    ContextKeeper().init(context);
    return BlocConsumer<AddBugBloc, AddBugState>(
        listener: (prevState, state) {
        },
        builder: (context, state) {
          return _bugWidget();
        }
    );
  }


  Widget _bugWidget() {

    return BlocBuilder<AddBugBloc, AddBugState>(
      builder: (context, state) {
        if (state is AddBugStateInitial) {
          descriptionController.clear();
        model=null;
        val=-1;
        _type=-1;
          return CenterLoaderWidget();
        }
        if(state is AddBugStateWaitingForAnswer){
          context.read<AddBugBloc>().add(AddBugTryEvent());
        }
        if (state is AddBugStateUpdate) {
          return _getBugStatusWidget(state, context);
        }
        if (state is AddBugStateError) {
          return _buttonErrorStatusWidget(state, context);
        }
        return Container();
      },
    );
  }
  Widget _getBugStatusWidget(AddBugStateUpdate state, context) {
    //_secondPageStateList(state.category, state);
    return Column(
      children: [
        _getBugStatusDashboard(state, context),
      ],
    );
  }
  Widget _getBugStatusDashboard(AddBugStateUpdate state,context){
  return Expanded(
      child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
        child: GFCard(
          content: Padding(
            padding: const EdgeInsets.only(left:4.0, top:8.0,right: 4.0,bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _categorieInput(state.category),
                  SizedBox(height: 8.0,),
                  _descriptionInput(),
                  SizedBox(height: 8.0,),
                  _priorityInput(),
                  SizedBox(height: 4.0,),
                  Divider(
                    color: Colors.blue,
                    height: 20,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  SizedBox(height: 4.0,),
                  _typeEnumInput(),
                  SizedBox(height: 10.0),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: _acceptButton(state.category),
                  ),
                ],
              )
        )
      )
    )
  );
  }
  Widget _categorieInput(List<ModuleModelResponse> list){
    return BlocBuilder<AddBugBloc, AddBugState>(
      builder: (context, state) {
        return Container(
            height: 60,
            width: double.infinity,
            child: DropdownButtonFormField(
              menuMaxHeight: 500,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  MdiIcons.viewList,
                  color: Colors.blue[300],
                ),
              ),
              items: buildDropDownMenuItems(list, context),
              hint: Text(LocaleKeys.task_chose_category.tr(),),
              onChanged: (value) {
                model = value as ModuleModelResponse?;
              },
              value: model,
            )
        );
      },
    );
  }List<DropdownMenuItem<ModuleModelResponse>> buildDropDownMenuItems(List listItems,context) {
    List<DropdownMenuItem<ModuleModelResponse>> items = [];
    for (ModuleModelResponse listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(
              "${listItem.label}",
           style: TextStyle(fontSize: 15),//tu dodac
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }
  Widget _priorityInput(){

    return BlocBuilder<AddBugBloc, AddBugState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              ListTile(
                title:  Text('${LocaleKeys.name_Priority_enum.tr()}'),
                leading: Radio<int>(
                  value: 0,
                  activeColor: Colors.blue,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: Text('${LocaleKeys.second_name_Priority_enum.tr()}'),
                leading: Radio<int>(
                  value: 1,
                  activeColor: Colors.blue,
                  groupValue: val,
                  onChanged: (int? value) {
                    setState(() {
                      val = value;
                    });
                  },
                ),
              )
            ],
          );
        }
    );
  }


  Widget _typeEnumInput(){
    return BlocBuilder<AddBugBloc, AddBugState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              ListTile(
                title:  Text('${LocaleKeys.name_Type_enum.tr()}'),
                leading: Radio<int>(
                  value: 0,
                  activeColor: Colors.blue,
                  groupValue: _type,
                  onChanged: (int? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('VIP'),
                leading: Radio<int>(
                  value: 1,
                  activeColor: Colors.blue,
                  groupValue: _type,
                  onChanged: (int? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
            ],
          );
        }
    );
  }
  Widget _descriptionInput(){
    return BlocBuilder<AddBugBloc, AddBugState>(
      builder: (context, state) {
        return Container(
          child: TextFormField(
            controller: descriptionController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 10,
            maxLength: 500,
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú ą Ą Ę ę Ż ż ź Ź ó Ó ń Ń ć Ć ś Ś ł Ł 0-9]"))],
            decoration: InputDecoration(
              labelText: LocaleKeys.description.tr(),
              hintText: LocaleKeys.description.tr(),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }

  Widget _buttonErrorStatusWidget(AddBugStateError state, context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _errorButton(state.error.toString())
      ],
    ),);
  }
  Widget _errorButton(var error){

    return BlocBuilder<AddBugBloc, AddBugState>(

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
                        child: new Text(LocaleKeys.error_Try_again.tr(),style: new TextStyle(fontSize: 20.0,)),
                        type: GFButtonType.solid,
                        onPressed:()=>context.read<AddBugBloc>().add(AddBugTryEvent())
                    ),
                  )
              )
            ],
          ),
        );
      },
    );
  }
  Widget _acceptButton(List<ModuleModelResponse> list){
String? number='';
String? imeiNumber='';
    return BlocBuilder<AddBugBloc, AddBugState>(
      builder: (context, state) {
        return GFButton(
            padding: const EdgeInsets.all(8.0),
            text:LocaleKeys.task_Add_Bug.tr(),
            size: GFSize.LARGE,
            color: Colors.blue,
            onPressed:() async =>{
              if(await MobileNumber.hasPhonePermission){
            imeiNumber = await DeviceInformation.deviceIMEINumber,
            number=await MobileNumber.mobileNumber,
              },
              if( descriptionController.text.isNotEmpty && model!=null && val!=-1 && _type!=-1){
                context.read<AddBugBloc>().add(AddBugValueChangedEvent(category: list,priority: val,description: descriptionController
                .text,modelResponse: model,type: _type,phoneNumber: number,imei: imeiNumber)),
                descriptionController.clear(),
                model=null,
                val=-1,
                _type=-1,
                Alert(
                context: ContextKeeper.buildContext,
                type: AlertType.success,
                title: "${LocaleKeys.task_Bug_save.tr()}",
                buttons: [
                DialogButton(
                child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                Navigator.of(ContextKeeper.buildContext).pop();
                },
                width: 120,
                )
                ],
                ).show(),
              }
              else{
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "${LocaleKeys.acc_Enter_Data.tr()}",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 120,
                    )
                  ],
                ).show(),
              },
            }
        );
      },
    );
  }
}
