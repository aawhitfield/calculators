import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_finance_options.dart';
import 'package:calculators/inputs/fixflip/ff_property_costs.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipExpensesInput extends ConsumerStatefulWidget {
  const FixFlipExpensesInput({Key? key}) : super(key: key);

  @override
  _ExpensesInputState createState() => _ExpensesInputState();
}

class _ExpensesInputState extends ConsumerState<FixFlipExpensesInput> {
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();

  @override
  void initState() {
    double taxes = ref.read(fixFlipProvider).taxesYearly;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(fixFlipProvider).insuranceYearly;
    if (insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double taxesMonthly = ref.watch(fixFlipProvider).taxesMonthly;
    double insuranceMonthly = ref.watch(fixFlipProvider).insuranceMonthly;

    String taxesMonthlyString = kCurrencyFormat.format(taxesMonthly);
    String insuranceMonthlyString = kCurrencyFormat.format(insuranceMonthly);

    return MyInputPage(
      imageUri: 'images/expenses.svg',
      headerText: 'Expenses',
      subheadText: '',
      position: kFixFlipQuestions.indexOf(FixFlipExpensesInput) + 1,
      totalQuestions: kFixFlipQuestions.length,
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const FixFlipPropertyCosts());
        } else {
          Get.back();
        }
      },
      onSubmit: () {
        Get.to(() => const FixFlipFinanceOptions());
      },
      child: ResponsiveLayout(
        children: [
          MoneyTextField(
            labelText: 'Taxes (Yearly)',
            controller: taxesController,
            onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? taxes = double.tryParse(newValue);
              if (taxes != null) {
                ref.read(fixFlipProvider).updateTaxes(taxes);
              } else {
                ref.read(fixFlipProvider).updateTaxes(0);
              }
              ref.read(fixFlipProvider).calculateAllExpenses();
            },
          ),
          MoneyListTile('Taxes', taxesMonthlyString, subtitle: 'Monthly'),
          MoneyTextField(
            labelText: 'Insurance (Yearly)',
            controller: insuranceController,
            onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? insurance = double.tryParse(newValue);
              if (insurance != null) {
                ref.read(fixFlipProvider).updateInsurance(insurance);
              } else {
                ref.read(fixFlipProvider).updateTaxes(0);
              }
              ref.read(fixFlipProvider).calculateAllExpenses();
            },
          ),
          MoneyListTile('Insurance', insuranceMonthlyString,
              subtitle: 'Monthly'),

          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat
                .format(ref.watch(fixFlipProvider).totalMonthlyExpenses)
                .toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat.format(double.parse(ref
                .watch(fixFlipProvider)
                .totalAnnualExpenses
                .toStringAsFixed(2))),
            subtitle: 'Annually',
          ),
        ],
      ),
    );
  }
}
