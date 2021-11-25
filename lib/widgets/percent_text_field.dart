import 'package:calculators/widgets/percent_suffix.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';


class PercentTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final TextEditingController? controller;

  const PercentTextField({
    required this.labelText,
    required this.onChanged,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PercentSuffix(
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
            ),
            inputFormatters: [ThousandsFormatter(allowFraction: true)],
            keyboardType: TextInputType.number,
            onChanged: (String newTotal) {
              onChanged(newTotal);
            }),
      ),
    );
  }
}
