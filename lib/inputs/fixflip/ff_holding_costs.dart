import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_finance_construction.dart';
import 'package:calculators/inputs/fixflip/ff_finance_options.dart';
import 'package:calculators/inputs/fixflip/ff_finance_seller_financed.dart';
import 'package:calculators/inputs/fixflip/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipHoldingCosts extends ConsumerStatefulWidget {
  const FixFlipHoldingCosts({Key? key}) : super(key: key);

  @override
  _HoldingCostsState createState() => _HoldingCostsState();
}

class _HoldingCostsState extends ConsumerState<FixFlipHoldingCosts> {

  TextEditingController utilitiesController = TextEditingController();

  @override
  void initState() {
    double utilities = ref.read(fixFlipProvider).holdingCostsUtilities;
    if (utilities != 0) {
      utilitiesController.text = kCurrencyFormat.format(utilities);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double debtService = ref.watch(fixFlipProvider).debtService;
    double insuranceTaxes = ref.watch(fixFlipProvider).insuranceAndTaxes;
    double totalHoldingCosts = ref.watch(fixFlipProvider).totalHoldingCosts;

    String debtServiceString = kCurrencyFormat.format(debtService);
    String insuranceTaxesString = kCurrencyFormat.format(insuranceTaxes);
    String totalHoldingCostsString = kCurrencyFormat.format(totalHoldingCosts);

    return MyInputPage(
        imageUri: 'images/holdingCosts.svg',
        headerText: 'Holding Costs',
        subheadText: '',
        position: kFixFlipQuestions.indexOf(FixFlipHoldingCosts) + 1,
        totalQuestions: kFixFlipQuestions.length,
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          if(ref.read(fixFlipProvider).financingType == FinancingType.sellerFinancing) {
            Get.off(() => const FixFlipFinanceSellerFinanced());
          }
          else if(ref.read(fixFlipProvider).financingType == FinancingType.hardMoneyWithConstruction
              || ref.read(fixFlipProvider).financingType == FinancingType.commercialWithConstruction) {
            Get.off(() => const FixFlipFinanceConstruction());
          }
          else {
            Get.off(() => const FixFlipFinanceOptions());
          }
        }
        else {
          Get.back();
        }
      },
        onSubmit: () {
          Get.to(() => const FixAndFlipSellingCostsInput());
        },
      child: ResponsiveLayout(
        children: [
          MoneyListTile('Debt Service', debtServiceString),
          MoneyListTile((MediaQuery.of(context).size.width < 640)
              ? 'Insurance\n& Taxes'
              : 'Insurance and Taxes', insuranceTaxesString),
          MoneyTextField(
              controller: utilitiesController,
              labelText: 'Utilities', onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? value = double.tryParse(newValue);
            if(value != null) {
              ref.read(fixFlipProvider).updateHoldingCostsUtilities(value);
            }
            else {
              ref.read(fixFlipProvider).updateHoldingCostsUtilities(0.0);
            }
            ref.read(fixFlipProvider).calculateAllHoldingCosts();
          }),
          MoneyListTile((MediaQuery.of(context).size.width < 640)
              ? 'Holding\nCosts'
              : 'Total\nHolding Costs', totalHoldingCostsString),
        ],
      ),
    );
  }
}
