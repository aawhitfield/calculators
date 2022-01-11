import 'package:calculators/globals.dart';
import 'package:calculators/home.dart';
import 'package:calculators/inputs/turnkey/tr_address_form.dart';
import 'package:calculators/inputs/turnkey/tr_property_costs.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TurnkeyRentalInput extends ConsumerWidget {
  final String title;
  final String? subtitle;
  TurnkeyRentalInput(this.title, {Key? key, this.subtitle}) : super(key: key);
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
      child: TurnkeyRentalAddressForm(addressController),
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
        ref.read(turnkeyProvider).updateAddress(addressController.text);

        Get.to(() => const TurnkeyRentalPropertyCosts());
      },
      position: 1,
      totalQuestions: kTurnKeyRentalQuestions.length,
    );
  }
}
