import 'package:calculators/widgets/dollar_prefix.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class MoneyTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;

  const MoneyTextField({
    required this.labelText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DollarPrefix(
        child: TextField(
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
