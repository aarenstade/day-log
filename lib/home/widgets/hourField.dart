import 'package:daylog/models/hourState.dart';
import 'package:daylog/services/db_funcs.dart';
import 'package:daylog/services/time_utils.dart';
import 'package:daylog/ui_elements/text_fields.dart';
import 'package:flutter/material.dart';

class HourField extends StatefulWidget {
  final HourState state;
  HourField({Key key, this.state}) : super(key: key);

  @override
  _HourFieldState createState() => _HourFieldState();
}

class _HourFieldState extends State<HourField> {
  saveText(String text) async {
    await DBFuncs.saveHour(hour: widget.state.hour, text: text);
    setState(() {
      _saved = true;
    });
  }

  resetButton() {
    setState(() {
      _saved = false;
    });
  }

  TextEditingController _controller = TextEditingController();

  String hourFormat;
  bool _saved;

  @override
  void initState() {
    super.initState();
    hourFormat = formatHour(widget.state.hour);
    if (widget.state.initText != null && widget.state.initText.length > 0) {
      _controller..text = widget.state.initText;
      _saved = true;
    } else {
      _saved = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      DAHourTextField(
        controller: _controller,
        onSaved: (t) {
          if (t.length > 0) {
            saveText(t);
          } else {
            resetButton();
          }
        },
      ),
      Positioned(
        left: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text("$hourFormat",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
      saveButton()
    ]);
  }

  Widget saveButton() {
    var w = MediaQuery.of(context).size.width;
    var leftPos = w <= 375.0 ? 320.0 : w - 50.0;
    if (_saved) {
      return Positioned(
          top: 21,
          left: leftPos,
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.green),
              child: Icon(Icons.check)));
    } else {
      return Positioned(
          top: 21,
          left: leftPos,
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.red),
              child: Icon(Icons.edit)));
    }
  }
}
