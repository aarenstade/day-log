import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Container(
              width: 75,
              height: 75,
              child: Image.asset('assets/images/loading_icon.gif',
                  fit: BoxFit.contain))),
    );
  }
}
