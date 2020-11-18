import 'package:daylog/login_create_account/auth_section.dart';
import 'package:flutter/material.dart';

class LoginCreateAccount extends StatelessWidget {
  const LoginCreateAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Flex(direction: Axis.vertical, children: [
                  SizedBox(height: 10),
                  logo(),
                  SizedBox(height: 30),
                  AuthSection()
                ]))));
  }

  Widget logo() {
    return Center(
        child: Container(
            width: 250,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain)));
  }
}
