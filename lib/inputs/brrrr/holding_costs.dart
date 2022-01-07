import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_option_construction_loan.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/finance_options.dart';
import 'package:calculators/inputs/brrrr/refinance_input.dart';
import 'package:calculators/models/financing_type.dart';
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
  TextEditingController utilitiesController = TextEditingController();

  @override
  void initState() {
    double utilities = ref.read(brrrrProvider).holdingCostsUtilities;
    if (utilities != 0) {
      utilitiesController.text = kCurrencyFormat.format(utilities);
    }
    super.initState();
  }

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
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          if (ref.read(brrrrProvider).wantsToRefinance) {
            Get.off(() => const RefinanceInput());
          }
          else if(ref.read(brrrrProvider).financingType == FinancingType.sellerFinancing) {
            Get.off(() => const FinanceOptionSellerFinanced());
          }
          else if(ref.read(brrrrProvider).financingType == FinancingType.hardMoneyWithConstruction
          || ref.read(brrrrProvider).financingType == FinancingType.commercialWithConstruction) {
            Get.off(() => const FinanceOptionConstructionLoan());
          }
          else {
            Get.off(() => const FinanceOptions());
          }
        }
        else {
          Get.back();
        }
      },
      onSubmit: () {
        Get.to(() => const Report());
      },
      child: ResponsiveLayout(
        children: [
          MoneyListTile('Debt Service', debtServiceString),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Insurance\n& Taxes'
                  : 'Insurance and Taxes',
              insuranceTaxesString),
          MoneyTextField(
              controller: utilitiesController,
              labelText: 'Utilities',
              onChanged: (String newValue) {
                newValue = newValue.replaceAll(',', '');
                double? value = double.tryParse(newValue);
                if (value != null) {
                  ref.read(brrrrProvider).updateHoldingCostsUtilities(value);
                } else {
                  ref.read(brrrrProvider).updateHoldingCostsUtilities(0.0);
                }
                ref.read(brrrrProvider).calculateAllHoldingCosts();
              }),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Holding\nCosts'
                  : 'Total\nHolding Costs',
              totalHoldingCostsString),
        ],
      ),
    );
  }
}