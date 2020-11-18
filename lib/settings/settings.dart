import 'package:daylog/login_create_account/login_create_account.dart';
import 'package:daylog/services/auth_functions.dart';
import 'package:daylog/ui_elements/buttons.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String email;
  String uid;

  @override
  void initState() {
    super.initState();
    var user = AuthFunctions.getUser();
    uid = user[0];
    email = user[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Settings",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        body: Align(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("$email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                logoutButton(),
                versionNumber(),
              ]),
        ));
  }

  Widget logoutButton() {
    return NormalButton(
        text: "LOGOUT",
        color: Colors.red,
        onPressed: () {
          AuthFunctions.logout();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginCreateAccount()),
              (route) => false);
        });
  }

  Widget versionNumber() {
    return Flex(
        direction: Axis.vertical,
        children: [Text("Created by Aaren Stade"), Text("v0.01")]);
  }
}
