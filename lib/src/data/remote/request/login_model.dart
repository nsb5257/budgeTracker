
import 'package:flutter/scheduler.dart';

import '../../../base/common/validator.dart';
import '../../model/validation_exception_model.dart';

class LoginModel {
  String? email;
  String? password;
  String authOptions;
  String? phoneNumber;

  LoginModel({
    required this.authOptions,
    this.email,
    this.password
});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'authOptions': authOptions
    };
  }

  void validate(){
    if (authOptions.isEmpty){
      throw ValidationException('authOptions is missing');
    }
    switch (authOptions){
      case 'MOBILE_OTP': if(phoneNumber == null || phoneNumber!.length != 10){
        throw ValidationException('Incorrect phone number');
      }
      break;
      case 'EMAIL_PWD': if(email == null ||  isValidEmail(email!)){
        throw ValidationException('Incorrect Email');
      }
      if(password == null){
        throw ValidationException('Invalid Password');
      }
      break;
      case 'SSO': if(email == null ||  isValidEmail(email!)){
        throw ValidationException('Incorrect Email');
      }
      break;
      default:
        throw ValidationException('Incorrect authOptions');
    }
  }
}