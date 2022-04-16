
import 'package:bugreportingsystem/components/login/model/firstname_input.dart';
import 'package:bugreportingsystem/components/login/model/lastname_input.dart';
import 'package:bugreportingsystem/components/login/model/phonenumber_input.dart';
import 'package:bugreportingsystem/core/exceptions/authentication_exceptions.dart';
import 'package:bugreportingsystem/core/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../app_settings.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({
    required AuthenticationRepository? authenticationRepository,
    required ApiSettings apiConfig,
    required Dio httpClient
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository!,
        super( LoginState(exception: null));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginFirstNameChangedEvent) {
      yield _mapFirstNameChangedToState(event, state);
    }
    if (event is LoginLastNameChangedEvent) {
      yield _mapLastNameChangedToState(event, state);
    }
    if (event is LoginPhoneNumberChangedEvent) {
      yield _mapPhoneNumberChangedToState(event, state);
    }
    else if (event is LoginSubmittedEvent) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapFirstNameChangedToState(LoginFirstNameChangedEvent event, LoginState state) {
    final firstNameInput = FirstNameInput.dirty(event.firstName);

    return state.copyWith(
      firstNameInput: firstNameInput,
      status: Formz.validate([state.firstNameInput, firstNameInput]),
    );
  }
  LoginState _mapLastNameChangedToState(LoginLastNameChangedEvent event, LoginState state) {
    final lastNameInput = LastNameInput.dirty(event.lastName);

    return state.copyWith(
      lastNameInput: lastNameInput,
      status: Formz.validate([state.lastNameInput, lastNameInput]),
    );
  }
  LoginState _mapPhoneNumberChangedToState(LoginPhoneNumberChangedEvent event, LoginState state) {
    final phoneNumberInput = PhoneNumberInput.dirty(event.phoneNumber);

    return state.copyWith(
      phoneNumberInput: phoneNumberInput,
      status: Formz.validate([state.phoneNumberInput, phoneNumberInput]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(LoginSubmittedEvent event, LoginState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _authenticationRepository.logIn(
          firstName: state.firstNameInput.value,
          lastName: state.lastNameInput.value,
          phoneNumber: state.phoneNumberInput.value,
          password: "Pass123\$",
          rememberMe: true
        );

        yield state.copyWith(status: FormzStatus.submissionSuccess);


      } on Exception catch (ex) {
        Exception exception = ex;

        if (ex is DioError) {
          var errorDescription = ex.response?.data['error_description'];

          if (errorDescription != null) {
            switch (errorDescription) {
              case 'invalid_username_or_password':
                exception = InvalidUserNameOrPasswordException();
                break;
            }
          }
        }

        yield state.copyWith(status: FormzStatus.submissionFailure, exception: exception);
      }
    }
  }
}