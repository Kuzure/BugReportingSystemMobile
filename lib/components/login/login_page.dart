import 'package:bugreportingsystem/core/exceptions/authentication_exceptions.dart';
import 'package:bugreportingsystem/core/repository/authentication_repository.dart';
import 'package:bugreportingsystem/core/repository/configuration_repository.dart';
import 'package:bugreportingsystem/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';


class LoginPage extends StatefulWidget {
  static Route route() {

    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) => LoginBloc(
                authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
                apiConfig: context.read<ConfigurationRepository>().apiSettings,
                httpClient: context.read<AuthenticationRepository>().securedHttpClient
            ),
              child: LoginPage()
        )
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!await Permission.storage.isGranted) {
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            _showErrorMessage(context, state.exception);

            //_showErrorMessage(context, state.exception.toString());
          }
        },
        child: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 15.0,),
                    Text(
                      LocaleKeys.acc_Login_AppBar.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue),),
                    SizedBox(height: 28.0),
                    _FirstNameInput(),
                    SizedBox(height: 8.0),
                    _LastNameInput(),
                    SizedBox(height: 8.0),
                    _PhoneNumberInput(),
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child:_LoginButton()
                    ),
                  ],
                ),
              ),
            )
          ],
        )

    );
  }

  void _showErrorMessage(BuildContext context,  exception) {

    if (exception != null) {
      if (exception is InvalidUserNameOrPasswordException) {
      }
      else if (exception is InvalidRoleException) {
      }
    }
    //AlertHelper.showError(context, exception, errorDesc);
  }
}
class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phoneNumberInput != current.phoneNumberInput,
      builder: (context, state) {
        return Container(
          height: 80,
          child: TextFormField(
            initialValue: '',
            onChanged: (phoneNumber)=>
                context.read<LoginBloc>().add(LoginPhoneNumberChangedEvent(phoneNumber)),
            textInputAction: TextInputAction.next,
            maxLength: 9,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: LocaleKeys.Phone_Number.tr(),
              hintText: LocaleKeys.Phone_Number.tr(),
              errorText: validatePhoneNumber(state, context),
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.phone,
              ),
            ),
          ),
        );
      },
    );
  }
}
class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.lastNameInput != current.lastNameInput,
      builder: (context, state) {
        return Container(
          height: 80,
          child: TextFormField(
            initialValue: '',
            onChanged: (lastName)=>
                context.read<LoginBloc>().add(LoginLastNameChangedEvent(lastName)),
            textInputAction: TextInputAction.next,
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú ą Ą Ę ę Ż ż ź Ź ó Ó ń Ń ć Ć ś Ś ł Ł]"))],
            decoration: InputDecoration(
              labelText: LocaleKeys.Last_Name.tr(),
              hintText: LocaleKeys.Last_Name.tr(),
              errorText: validateLastName(state, context),
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.account_circle_outlined ,
              ),
            ),
          ),
        );
      },
    );
  }
}
class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.firstNameInput != current.firstNameInput,
      builder: (context, state) {
        return Container(
          height: 80,
          child: TextFormField(
            initialValue: '',
            onChanged: (firstName)=>
                context.read<LoginBloc>().add(LoginFirstNameChangedEvent(firstName)),
            textInputAction: TextInputAction.next,
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú ą Ą Ę ę Ż ż ź Ź ó Ó ń Ń ć Ć ś Ś ł Ł]"))],
            decoration: InputDecoration(
              labelText: LocaleKeys.first_Name.tr(),
              hintText: LocaleKeys.first_Name.tr(),
              errorText: validateFirstName(state, context),
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.account_circle_outlined ,
              ),
            ),
          ),
        );
      },
    );
  }
}

String? validateFirstName(state, context) {
  if (state.firstNameInput.invalid ) {
    return LocaleKeys.error_FirstName_Empty.tr();
  }
  return null;
}
String? validateLastName(state, context) {
  if (state.lastNameInput.invalid ) {
    return LocaleKeys.error_LastName_Empty.tr();
  }
  return null;
}
String? validatePhoneNumber(state, context) {
  if (state.phoneNumberInput.invalid ) {
    return LocaleKeys.error_PhoneNumber_Empty.tr();
  }
  return null;
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(

      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch(state.status) {
          case FormzStatus.submissionInProgress:
            return Center(
                child: Scaffold(

                )
            );

          case FormzStatus.submissionSuccess:
            return Center(
                child: Icon(
                    Icons.check_circle_outline
                )
            );

          default:
            return GFButton(
              padding: const EdgeInsets.all(8.0),

              text: state.status.isValidated ? LocaleKeys.acc_Login.tr() : LocaleKeys.acc_Enter_Data.tr(),
              size: GFSize.LARGE,
              color: state.status.isValidated ? Colors.blue : Colors.white,

              onPressed:
              state.status.isValidated
                  ? () {
                MobileNumber.requestPhonePermission;
                context.read<LoginBloc>().add(LoginSubmittedEvent());}
                  : null,

            );
        }
      },
    );
  }

}