import 'package:formz/formz.dart';

import '../../../validators.dart';

enum EmailValidatorError { empty, invalid }
///Валидатор для Электронной почты
class Email extends FormzInput<String, EmailValidatorError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidatorError? validator(String value) {
    final isValid = Validators.isValidEmail(value);
    final isEmpty = value.isNotEmpty != true;
    if(isEmpty){
      return EmailValidatorError.empty;
    }
    if(!isValid){
      return EmailValidatorError.invalid;
    }
    return null;
  }
}