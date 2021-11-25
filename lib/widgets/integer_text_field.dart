import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class IntegerTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final TextEditingController? controller;
  final int? leftPadding;
  final int? rightPadding;

  const IntegerTextField({
    required this.labelText,
    required this.onChanged,
    this.controller,
    this.leftPadding,
    this.rightPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding?.toDouble() ?? 20, 8,
          rightPadding?.toDouble() ?? 8, 8),
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
