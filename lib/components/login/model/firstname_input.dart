import 'package:formz/formz.dart';

enum FirstNameValidationError { empty }

class FirstNameInput extends FormzInput<String, FirstNameValidationError> {
  const FirstNameInput.pure() : super.pure('');
  const FirstNameInput.dirty([String value = '']) : super.dirty(value);

  @override
  FirstNameValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : FirstNameValidationError.empty;
  }
}