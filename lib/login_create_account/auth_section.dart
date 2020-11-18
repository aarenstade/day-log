import 'package:daylog/services/auth_functions.dart';
import 'package:daylog/ui_elements/loading_icon.dart';
import 'package:daylog/ui_elements/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui_elements/buttons.dart';
import 'package:email_validator/email_validator.dart';
import '../home/home.dart';

class AuthSection extends StatefulWidget {
  @override
  _AuthSectionState createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection> {
  final auth = FirebaseAuth.instance;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String pass;

  String _errorMessage = "";
  String _headerText = "Login";
  bool _loginForm = false;
  bool _loading = false;

  setError(String m) {
    setState(() {
      _loading = true;
      _errorMessage = m;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  //login function
  login() async {
    setState(() {
      _loading = true;
    });
    var login = await AuthFunctions.login(email: email, pass: pass);
    if (login.success) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    } else {
      setState(() {
        _errorMessage = "${login.message}";
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _errorMessage = "";
          _loading = false;
        });
      });
    }
  }

  createAccount() async {
    setState(() {
      _loading = true;
    });
    var create = await AuthFunctions.createAccount(email: email, pass: pass);
    if (create.success) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    } else {
      setState(() {
        _errorMessage = "${create.message}";
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _errorMessage = "";
          _loading = false;
        });
      });
    }
  }

  switchForms() {
    setState(() {
      _loginForm = !_loginForm;
      _headerText = _loginForm ? "Login" : "Create Account";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_loginForm) ...[
            loginSection(),
          ] else ...[
            createAccountSection(),
          ]
        ]);
  }

  Widget emailPassForms() {
    var w = MediaQuery.of(context).size.width;
    var width = w > 1000.0 ? w - 300.0 : w - 100.0;
    return Container(
      width: width,
      child: Form(
        key: _formKey,
        child: Flex(direction: Axis.vertical, children: [
          DATextFormField(
              hintText: "Email",
              inputType: TextInputType.emailAddress,
              ifEmptyText: "Email is required",
              onChanged: (t) {
                email = t;
              }),
          DATextFormField(
              hintText: "Password",
              ifEmptyText: "Password is required",
              obscureText: true,
              onChanged: (t) {
                pass = t;
              })
        ]),
      ),
    );
  }

  Widget createAccountSection() {
    return Flex(direction: Axis.vertical, children: [
      SizedBox(height: 20),
      emailPassForms(),
      errorMessage(),
      submitButton("CREATE ACCOUNT", false),
      switchFormsButton("Or Login")
    ]);
  }

  Widget loginSection() {
    return Flex(direction: Axis.vertical, children: [
      SizedBox(height: 20),
      emailPassForms(),
      forgotPasswordButton(),
      errorMessage(),
      submitButton("LOGIN", true),
      switchFormsButton("Or Create Account"),
    ]);
  }

  Widget submitButton(String text, bool loggingIn) {
    if (_loading) {
      return LoadingIcon();
    } else {
      return NormalButton(
          text: text,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              print('validating: $email');
              var v = EmailValidator.validate(email);
              if (!v) {
                setError("Email not valid");
              } else {
                if (loggingIn) {
                  login();
                } else {
                  createAccount();
                }
              }
            }
          });
    }
  }

  Widget switchFormsButton(String text) {
    return SmallButton(
        text: text,
        onPressed: () {
          switchForms();
        });
  }

  Widget forgotPasswordButton() {
    return SmallButton(
        text: "Forgot Password",
        onPressed: () {
          showDialog(context: context, child: passResetDialog());
        });
  }

  Widget passResetDialog() {
    return AlertDialog(
      title: Text("Reset Password",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      content: Container(
        height: 250,
        child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              Text("Enter your email to send a password reset link."),
              DAHourTextField(onChanged: (t) {
                email = t;
              }),
              NormalButton(
                  text: "Send Reset Link",
                  onPressed: () async {
                    await AuthFunctions.sendPassResetLink(email);
                    Navigator.of(context).pop();
                  })
            ]),
      ),
    );
  }

  Widget errorMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: Text("$_errorMessage",
          style: TextStyle(fontSize: 18, color: Colors.red)),
    );
  }
}
