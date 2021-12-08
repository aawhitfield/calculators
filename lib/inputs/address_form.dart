import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AddressForm extends ConsumerStatefulWidget {
  final TextEditingController addressController;
  const AddressForm(
    this.addressController, {
    Key? key,
  }) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends ConsumerState<AddressForm> {
  TextEditingController sqftController = TextEditingController();
  TextEditingController listPriceController = TextEditingController();

  @override
  void initState() {
    widget.addressController.text = ref.read(propertyProvider).address;
    int? sqft = ref.read(propertyProvider).sqft;
    if (sqft != null && sqft != 0) {
      sqftController.text = sqft.toString();
    }
    double listPrice = ref.read(propertyProvider).listPrice;
    if (listPrice != 0) {
      listPriceController.text = kCurrencyFormat.format(listPrice);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: PlacesAutocompleteField(
                controller: widget.addressController,
                onChanged: (String? newAddress) {
                  if (newAddress != null) {
                    ref.read(propertyProvider).updateAddress(newAddress);
                  }
                },
                apiKey: kGoogleAPIkey,
                mode: Mode.fullscreen,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       labelText: 'Street Address',
            //     ),
            //     textCapitalization: TextCapitalization.words,
            //     onChanged: (String newStreet) =>
            //         ref.read(addressProvider).updateStreet(newStreet),
            //   ),
            // ),
            //
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       labelText: 'Apt, Suite, Bldg #',
            //     ),
            //     textCapitalization: TextCapitalization.words,
            //     onChanged: (String newLine2) =>
            //         ref.read(addressProvider).updateLine2(newLine2),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       labelText: 'City',
            //     ),
            //     textCapitalization: TextCapitalization.words,
            //     onChanged: (String newCity) =>
            //         ref.read(addressProvider).updateCity(newCity),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       labelText: 'State',
            //     ),
            //     textCapitalization: TextCapitalization.characters,
            //     onChanged: (String newState) =>
            //         ref.read(addressProvider).updateStreet(newState),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       labelText: 'ZIP',
            //     ),
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //     keyboardType: TextInputType.number,
            //     maxLengthEnforcement: MaxLengthEnforcement.enforced,
            //     maxLength: 5,
            //     onChanged: (String newZip) =>
            //         ref.read(addressProvider).updateZip(newZip),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: sqftController,
                  decoration: const InputDecoration(
                    labelText: 'Square Feet',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (String newSqft) {
                    int? squareFeet = int.tryParse(newSqft);
                    if (squareFeet != null) {
                      ref.read(propertyProvider).updateSqft(squareFeet);
                    }
                  }),
            ),
            MoneyTextField(
                controller: listPriceController,
                labelText: 'List Price',
                onChanged: (String newListPrice) {
                  newListPrice = newListPrice.replaceAll(',', '');
                  double? listPrice = double.tryParse(newListPrice);
                  if (listPrice != null) {
                    ref.read(propertyProvider).updateListPrice(listPrice);
                  }
                }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
