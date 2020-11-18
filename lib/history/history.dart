import 'package:daylog/models/hourState.dart';
import 'package:daylog/services/db_funcs.dart';
import 'package:daylog/services/time_utils.dart';
import 'package:daylog/ui_elements/buttons.dart';
import 'package:daylog/ui_elements/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//HISTORY PAGE

//Chosen date text
//Choose Date button --> opens showDatePicker
//When new chosen date, get date function
//Return List<HourState> dateState
//Show that list in nice list viewer

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool hasData = false;
  bool loading = false;
  String errorMessage = "";
  DateTime selectedDate = DateTime.now();
  List<HourState> dayData = List<HourState>();

  getData() async {
    final data = await DBFuncs.getPastDay(selectedDate);
    if (data != null) {
      setState(() {
        dayData = data;
        hasData = true;
        loading = false;
      });
    } else {
      setState(() {
        errorMessage = "No data for that day...";
        hasData = false;
        loading = false;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          errorMessage = "";
        });
      });
    }
  }

  selectDate(BuildContext context) async {
    final newDT = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        currentDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025),
        helpText: "View Day",
        confirmText: "Select",
        cancelText: "Cancel");
    if (newDT != null && newDT != selectedDate) {
      setState(() {
        loading = true;
        selectedDate = newDT;
      });
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("History",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      body: Flex(direction: Axis.vertical, children: [
        heading(),
        chooseDateButton(),
        showErrorMessage(),
        showData(),
      ]),
    );
  }

  Widget heading() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(direction: Axis.vertical, children: [
        Text("Selected", style: TextStyle(fontSize: 22)),
        Text("${DateFormat('MMMM d, y').format(selectedDate)}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget chooseDateButton() {
    return NormalButton(
        text: "Choose Date",
        onPressed: () async {
          await selectDate(context);
        });
  }

  Widget showErrorMessage() {
    return Text("$errorMessage",
        style: TextStyle(fontSize: 18, color: Colors.red));
  }

  Widget showData() {
    if (loading) {
      return LoadingIcon();
    } else {
      if (hasData) {
        return dataSection();
      } else {
        return Container();
      }
    }
  }

  Widget dataSection() {
    return Expanded(
      child: ListView.builder(
          itemCount: dayData.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return hourRow(i);
          }),
    );
  }

  Widget hourRow(int index) {
    return ListTile(
        leading: Text("${formatHour(dayData[index].hour)}"),
        title: Text("${dayData[index].initText}"));
  }
}
