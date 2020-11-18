import 'package:daylog/services/db_funcs.dart';
import 'package:daylog/ui_elements/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hourField.dart';
import 'package:daylog/models/hourState.dart';

//pass state from dayList widget into ListView builder of each HourField

class DayList extends StatefulWidget {
  final String uid;
  DayList({Key key, this.uid}) : super(key: key);

  @override
  _DayListState createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  bool _loading = true;

  final db = FirebaseFirestore.instance;
  List<HourState> todayState = List<HourState>();

  void getToday() async {
    todayState = await DBFuncs.getToday();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getToday();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return LoadingIcon();
    } else {
      return SingleChildScrollView(
        child: Column(children: [
          HourField(state: todayState[0]),
          HourField(state: todayState[1]),
          HourField(state: todayState[2]),
          HourField(state: todayState[3]),
          HourField(state: todayState[4]),
          HourField(state: todayState[5]),
          HourField(state: todayState[6]),
          HourField(state: todayState[7]),
          HourField(state: todayState[8]),
          HourField(state: todayState[9]),
          HourField(state: todayState[10]),
          HourField(state: todayState[11]),
          HourField(state: todayState[12]),
          HourField(state: todayState[13]),
          HourField(state: todayState[14]),
          HourField(state: todayState[15]),
          HourField(state: todayState[16]),
          HourField(state: todayState[17]),
          HourField(state: todayState[18]),
          HourField(state: todayState[19]),
          HourField(state: todayState[20]),
          HourField(state: todayState[21]),
          HourField(state: todayState[22]),
          HourField(state: todayState[23]),
        ]),
      );
    }
  }
}
