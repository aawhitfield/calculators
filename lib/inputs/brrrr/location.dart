import 'package:calculators/globals.dart';
import 'package:calculators/home.dart';
import 'package:calculators/inputs/brrrr/renovations_calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'address_form.dart';

class Location extends ConsumerWidget {
  final String title;
  final String? subtitle;
  Location(this.title, {Key? key, this.subtitle}) : super(key: key);
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      headlineText: title,
      subHeadlineText: subtitle,
      imageUri: 'images/house_searching.svg',
      headerText: 'Let\'s first find the property',
      subheadText: 'Where is the property located?',
      shouldShowBackButton: true,
      child: AddressForm(addressController),
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.offAll(() => const MyHomePage(title: 'Vereifi', startingTab: 1,));
        } else {
          Get.back();
        }
      },
      onSubmit: () {
        ref.read(brrrrProvider).updateAddress(addressController.text);

        if (brrrrAddressKey.currentState?.validate() ?? false) {
          Get.to(() => const RenovationsCalculator());
        }
      },
      position: 1,
      totalQuestions: kBRRRRQuestions.length,
    );
  }
}
