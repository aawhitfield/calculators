import 'package:calculators/my_text_field.dart';
import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: Column(
          children: const [
            MyTextField(
              labelText: 'Street Address',
            ),
            MyTextField(
              labelText: 'Apt, Suite, Bldg #',
            ),
            MyTextField(
              labelText: 'City',
            ),
            MyTextField(
              labelText: 'State',
            ),
            MyTextField(
              labelText: 'ZIP',
            ),
            MyTextField(
              labelText: 'Square Feet',
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
