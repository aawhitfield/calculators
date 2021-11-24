import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class IntegerTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final TextEditingController? controller;

  const IntegerTextField({
    required this.labelText,
    required this.onChanged,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (String newTotal) {
            onChanged(newTotal);
          }),
    );
  }
}
