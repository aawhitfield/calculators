import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/inputs/renovations_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'address_form.dart';
import '../models/address.dart';



class Location extends ConsumerWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(headlineText: 'Residential REI', imageUri: 'images/house_searching.svg',
      headerText: 'Let\'s first find the property', subheadText: 'Where is the property located?',
      child: const AddressForm(),
      onSubmit: () {
      // save the address onto the Property model class
      final address = ref.read(addressProvider);
      ref.read(propertyProvider).updateAddress(
        Address(street: address.street, line2: address.line2, city: address.city,
            state: address.state, zip: address.zip,
        )
      );
        Get.to(() => const RenovationsCalculator());
      },
      position: 1,
      totalQuestions: kResidentialREIQuestions.length,
    );
  }
}
