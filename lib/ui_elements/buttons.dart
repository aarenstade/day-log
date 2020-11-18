import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  const NormalButton({Key key, this.text, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FlatButton(
          color: color != null ? color : Colors.blue.shade900,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text("$text",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
          onPressed: onPressed),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SmallButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text("$text", style: TextStyle(fontSize: 18)),
        onPressed: onPressed);
  }
}
