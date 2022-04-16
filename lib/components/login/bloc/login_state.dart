
import 'package:bugreportingsystem/components/login/model/firstname_input.dart';
import 'package:bugreportingsystem/components/login/model/lastname_input.dart';
import 'package:bugreportingsystem/components/login/model/phonenumber_input.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';


class LoginState extends Equatable {
  final FormzStatus status;
  final FirstNameInput firstNameInput;
  final LastNameInput lastNameInput;
  final PhoneNumberInput phoneNumberInput;
  final Exception? exception;

  const LoginState({
    this.status = FormzStatus.pure,
    this.firstNameInput = const FirstNameInput.pure(),
    this.lastNameInput=const LastNameInput.pure(),
    this.phoneNumberInput= const PhoneNumberInput.pure(),
    required this.exception
  });

  LoginState copyWith({
    FormzStatus? status,
    FirstNameInput? firstNameInput,
    LastNameInput? lastNameInput,
    PhoneNumberInput? phoneNumberInput,
    Exception? exception,
  }) {
    return LoginState(
      status: status ?? this.status,
        firstNameInput: firstNameInput ?? this.firstNameInput,
        lastNameInput: lastNameInput?? this.lastNameInput,
        phoneNumberInput: phoneNumberInput?? this.phoneNumberInput,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object> get props => [status, firstNameInput,lastNameInput, phoneNumberInput];
}