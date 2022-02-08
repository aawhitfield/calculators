import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/clear_all_fields_button.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipAddressForm extends ConsumerStatefulWidget {
  final TextEditingController addressController;
  const FixFlipAddressForm(
    this.addressController, {
    Key? key,
  }) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends ConsumerState<FixFlipAddressForm> {
  TextEditingController sqftController = TextEditingController();
  TextEditingController listPriceController = TextEditingController();

  @override
  void initState() {
    widget.addressController.text = ref.read(fixFlipProvider).address;
    int? sqft = ref.read(fixFlipProvider).sqft;
    if (sqft != null && sqft != 0) {
      sqftController.text = sqft.toString();
    }
    double listPrice = ref.read(fixFlipProvider).listPrice;
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
            ClearAllFieldsButton(
              onPressed: () {
                resetAllData(ref);
                setState(() {
                  widget.addressController.clear();
                  sqftController.clear();
                  listPriceController.clear();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlacesAutocompleteFormField(
                controller: widget.addressController,
                onSaved: (String? newAddress) {
                  if (newAddress != null) {
                    ref.read(fixFlipProvider).updateAddress(newAddress);
                  }
                },
                hint: 'Address *',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                apiKey: kGoogleAPIkey,
                mode: Mode.fullscreen,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: sqftController,
                  decoration: const InputDecoration(
                    labelText: 'Square Feet *',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (String newSqft) {
                    int? squareFeet = int.tryParse(newSqft);
                    if (squareFeet != null) {
                      ref.read(fixFlipProvider).updateSqft(squareFeet);
                    }
                  },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Square feet is required';
                  }
                  return null;
                },
              ),
            ),
            MoneyTextField(
                controller: listPriceController,
                labelText: 'List Price * ',
                onChanged: (String newListPrice) {
                  newListPrice = newListPrice.replaceAll(',', '');
                  double? listPrice = double.tryParse(newListPrice);
                  if (listPrice != null) {
                    ref.read(fixFlipProvider).updateListPrice(listPrice);
                  }
                  else {
                    ref.read(fixFlipProvider).updateListPrice(0.0);
                  }
                },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'List price is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
