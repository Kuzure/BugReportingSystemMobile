import 'package:formz/formz.dart';

enum LastNameValidationError { empty }

class LastNameInput extends FormzInput<String, LastNameValidationError> {
  const LastNameInput.pure() : super.pure('');
  const LastNameInput.dirty([String value = '']) : super.dirty(value);

  @override
  LastNameValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : LastNameValidationError.empty;
  }
}