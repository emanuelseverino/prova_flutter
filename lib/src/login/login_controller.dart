import 'package:flutter/cupertino.dart';

class AuthController {
  BuildContext context;
  AuthController({required this.context});

  void login({required String usuario, required String senha}){
    Navigator.pushReplacementNamed(context, '/home');
  }

}