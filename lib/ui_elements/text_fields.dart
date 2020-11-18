import 'package:flutter/material.dart';

class DATextFormField extends StatelessWidget {
  final String hintText;
  final String initValue;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputType inputType;
  final String ifEmptyText;
  final bool obscureText;
  final bool req;
  const DATextFormField(
      {Key key,
      this.hintText,
      this.controller,
      this.initValue,
      this.ifEmptyText,
      this.inputType,
      this.obscureText,
      this.req,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: TextFormField(
          controller: controller ?? null,
          textAlign: TextAlign.center,
          keyboardType: inputType,
          obscureText: obscureText == null ? false : obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.black26,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blue.shade900, width: 5.0)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3.0))),
          validator: req != false
              ? (value) {
                  if (value.isEmpty) {
                    return ifEmptyText;
                  }
                  return null;
                }
              : null,
          onChanged: onChanged),
    );
  }
}

class DAHourTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSaved;
  final Function(String) onChanged;
  const DAHourTextField(
      {Key key, this.controller, this.onSaved, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            cursorColor: Colors.blue.shade900,
            cursorWidth: 2.5,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue.shade900, width: 5.0))),
            onChanged: onChanged,
            onSubmitted: onSaved));
  }
}
