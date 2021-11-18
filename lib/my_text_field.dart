import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;

  const MyTextField({
    this.labelText,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
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
