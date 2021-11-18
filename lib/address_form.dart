import 'package:calculators/models/address.dart';
import 'package:calculators/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressProvider = ChangeNotifierProvider<Address>(
        (ref) => Address(street: '', line2: '', city: '', state: '',
            zip: ''));

class AddressForm extends ConsumerWidget {
  const AddressForm({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            MyTextField(
              labelText: 'Street Address',
              onChanged: (String newStreet) =>
                  ref.read(addressProvider).updateStreet(newStreet),
            ),
            MyTextField(
              labelText: 'Apt, Suite, Bldg #',
              onChanged: (String newLine2) =>
                  ref.read(addressProvider).updateLine2(newLine2),
            ),
            MyTextField(
              labelText: 'City',
              onChanged: (String newCity) =>
                  ref.read(addressProvider).updateCity(newCity),
            ),
            MyTextField(
              labelText: 'State',
              onChanged: (String newState) =>
                  ref.read(addressProvider).updateStreet(newState),
            ),
            MyTextField(
              labelText: 'ZIP',
              onChanged: (String newZip) =>
                  ref.read(addressProvider).updateZip(newZip),
            ),
            MyTextField(
              labelText: 'Square Feet',
              onChanged: (String newSqft) {
                int? squareFeet = int.tryParse(newSqft);
                if (squareFeet != null) {
                  ref.read(addressProvider).updateSqft(squareFeet);
                }
              }
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
