import 'package:calculators/globals.dart';
import 'package:calculators/home.dart';
import 'package:calculators/inputs/fixflip/ff_address_form.dart';
import 'package:calculators/inputs/fixflip/ff_renovations_calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipLocation extends ConsumerWidget {
  final String title;
  final String? subtitle;
  FixFlipLocation(this.title, {Key? key, this.subtitle}) : super(key: key);
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ffAddressKey,
      child: MyInputPage(
        headlineText: title,
        subHeadlineText: subtitle,
        imageUri: 'images/house_searching.svg',
        headerText: 'Let\'s first find the property',
        subheadText: 'Where is the property located?',
        shouldShowBackButton: true,
        child: FixFlipAddressForm(addressController),
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
          ref.read(fixFlipProvider).updateAddress(addressController.text);

          if (ffAddressKey.currentState?.validate() ?? false) {
            Get.to(() => const FixFlipRenovationsCalculator());
          }
        },
        position: 1,
        totalQuestions: kFixFlipQuestions.length,
      ),
    );
  }
}
