import 'dart:async';
import 'package:daylog/history/history.dart';
import 'package:daylog/home/widgets/dayList.dart';
import 'package:daylog/login_create_account/login_create_account.dart';
import 'package:daylog/services/auth_functions.dart';
import 'package:daylog/settings/settings.dart';
import 'package:daylog/ui_elements/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  String uid;
  getUser() {
    var u = AuthFunctions.getUser();
    if (u == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginCreateAccount()),
          (route) => false);
    } else {
      setState(() {
        uid = u[0];
        _loading = false;
      });
    }
  }

  String date;
  String time;
  void _getDateTime() {
    final DateTime now = DateTime.now();
    final d = DateFormat('EEEE, MMMM d yyyy').format(now);
    final t = DateFormat('h:mm:ss aaa').format(now);
    setState(() {
      date = d;
      time = t;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    date = "";
    time = "";
    Timer.periodic(Duration(seconds: 1), (timer) {
      _getDateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Text(
                  '$date',
                  style: TextStyle(fontSize: 16),
                ),
                Text('$time', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: InkWell(
                child: Icon(Icons.history),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                }),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: InkWell(
                    child: Icon(Icons.settings),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    })),
          ],
        ),
        body: _loading ? loading() : DayList());
  }

  Widget loading() {
    return LoadingIcon();
  }
}

//DB layout
//YEAR/MONTH/DAY/HOUR/data

//widgets needed

//top level HourField widget
//HourField children widgets:
//Styled container showing hour with area for field
//Field with save button showing while editing
//Small save button which saves string to correct YEAR/MONTH/DAY/HOUR

//without other widgets
//text form field
//vars for each hour
//main save button saves all strings for each hour
