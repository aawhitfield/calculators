import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField({
    this.labelText,
    this.onChanged,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.green.shade900),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        onChanged: (newString) {
          if(onChanged != null) {
            onChanged!(newString);
          }},
      ),
    );
  }
}
