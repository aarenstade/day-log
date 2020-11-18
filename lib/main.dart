import 'package:daylog/login_create_account/login_create_account.dart';
import 'package:daylog/services/auth_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = hasUser();
  runApp(App(isLoggedIn: user));
}

bool hasUser() {
  print('checking auth');
  var user = AuthFunctions.getUser();
  if (user != null) {
    return true;
  } else {
    return false;
  }
}

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({Key key, this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? Home() : LoginCreateAccount());
  }
}
