import 'package:formz/formz.dart';

import '../../../validators.dart';

enum PasswordValidationError { empty, invalid }
///Валидатор для пароля
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    final isValid = Validators.isValidPassword(value);
    final isEmpty = value.isNotEmpty != true;
    if(isEmpty){
      return PasswordValidationError.empty;
    }
    if(!isValid){
      return PasswordValidationError.invalid;
    }
    return null;
  }
}