import 'package:calculators/models/address.dart';
import 'package:calculators/models/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final addressProvider = ChangeNotifierProvider<Address>(
        (ref) => Address(street: '', line2: '', city: '', state: '',
            zip: ''));

final propertyProvider = ChangeNotifierProvider<Property>(
    (ref) => Property(address: Address(street: '', line2: '', city: '', state: '',
        zip: ''), listPrice: 0, )
);

class AddressForm extends ConsumerWidget {
  const AddressForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = context.isTablet
        ? MediaQuery.of(context).size.width * 0.5
        : MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'Street Address',
        ),
                textCapitalization: TextCapitalization.words,
                onChanged: (String newStreet) =>
                    ref.read(addressProvider).updateStreet(newStreet),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'Apt, Suite, Bldg #',
                ),
                textCapitalization: TextCapitalization.words,
                onChanged: (String newLine2) =>
                    ref.read(addressProvider).updateLine2(newLine2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'City',
                ),
                textCapitalization: TextCapitalization.words,
                onChanged: (String newCity) =>
                    ref.read(addressProvider).updateCity(newCity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'State',
                ),
                textCapitalization: TextCapitalization.characters,
                onChanged: (String newState) =>
                    ref.read(addressProvider).updateStreet(newState),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'ZIP',
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 5,
                onChanged: (String newZip) =>
                    ref.read(addressProvider).updateZip(newZip),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                labelText: 'Square Feet',
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (String newSqft) {
                  int? squareFeet = int.tryParse(newSqft);
                  if (squareFeet != null) {
                    ref.read(addressProvider).updateSqft(squareFeet);
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('\$'),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'List Price',
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        onChanged: (String newListPrice) {
                          double? listPrice = double.tryParse(newListPrice);
                          if (listPrice != null) {
                            ref.read(propertyProvider).updateListPrice(listPrice);
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
