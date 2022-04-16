import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty }

class PhoneNumberInput extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberInput.pure() : super.pure('');
  const PhoneNumberInput.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : PhoneNumberValidationError.empty;
  }
}