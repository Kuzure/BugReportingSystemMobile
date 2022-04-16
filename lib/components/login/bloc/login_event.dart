import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class LoginPhoneNumberChangedEvent extends LoginEvent {
  final String phoneNumber;

  const LoginPhoneNumberChangedEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
class LoginLastNameChangedEvent extends LoginEvent {
  final String lastName;

  const LoginLastNameChangedEvent(this.lastName);

  @override
  List<Object> get props => [lastName];
}
class LoginFirstNameChangedEvent extends LoginEvent {
  final String firstName;

  const LoginFirstNameChangedEvent(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  const LoginPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmittedEvent extends LoginEvent {
  const LoginSubmittedEvent();
}