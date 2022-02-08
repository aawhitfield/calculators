import 'package:calculators/widgets/percent_suffix.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';


class PercentTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const PercentTextField({
    required this.labelText,
    required this.onChanged,
    this.controller,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PercentSuffix(
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
            ),
            inputFormatters: [ThousandsFormatter(allowFraction: true)],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (String newTotal) {
              onChanged(newTotal);
            },
          validator: validator,
        ),
      ),
    );
  }
}
