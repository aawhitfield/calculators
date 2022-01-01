import 'package:calculators/globals.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HoldingCosts extends ConsumerStatefulWidget {
  const HoldingCosts({Key? key}) : super(key: key);

  @override
  _HoldingCostsState createState() => _HoldingCostsState();
}

class _HoldingCostsState extends ConsumerState<HoldingCosts> {

  @override
  Widget build(BuildContext context) {
    double debtService = ref.watch(brrrrProvider).debtService;
    double insuranceTaxes = ref.watch(brrrrProvider).insuranceAndTaxes;
    double totalHoldingCosts = ref.watch(brrrrProvider).totalHoldingCosts;

    String debtServiceString = kCurrencyFormat.format(debtService);
    String insuranceTaxesString = kCurrencyFormat.format(insuranceTaxes);
    String totalHoldingCostsString = kCurrencyFormat.format(totalHoldingCosts);

    return MyInputPage(
        imageUri: 'images/holdingCosts.svg',
        headerText: 'Holding Costs',
        subheadText: '',
        position: kBRRRRQuestions.indexOf(HoldingCosts) + 1,
        totalQuestions: kBRRRRQuestions.length,
        onSubmit: () {
          Get.to(() => const Report());
        },
      child: ResponsiveLayout(
        children: [
          MoneyListTile('Debt Service', debtServiceString),
          MoneyListTile('Insurance and Taxes', insuranceTaxesString),
          MoneyTextField(labelText: 'Utilities', onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? value = double.tryParse(newValue);
            if(value != null) {
              ref.read(brrrrProvider).updateHoldingCostsUtilities(value);
            }
            else {
              ref.read(brrrrProvider).updateHoldingCostsUtilities(0.0);
            }
            ref.read(brrrrProvider).calculateAllHoldingCosts();
          }),
          MoneyListTile('Total Holding Costs', totalHoldingCostsString),
        ],
      ),
    );
  }
}
