import 'package:calculators/globals.dart';
import 'package:calculators/inputs/turnkey/tr_expenses_input.dart';
import 'package:calculators/inputs/turnkey/tr_property_costs.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TurnkeyRentalIncomeInput extends ConsumerStatefulWidget {
  const TurnkeyRentalIncomeInput({Key? key}) : super(key: key);

  @override
  _IncomeInputState createState() => _IncomeInputState();
}

class _IncomeInputState extends ConsumerState<TurnkeyRentalIncomeInput> {
  TextEditingController rentController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double rent = ref.read(turnkeyProvider).rent;
    if (rent != 0) {
      rentController.text = kCurrencyFormat.format(rent);
    }
    double other = ref.read(turnkeyProvider).otherIncome;
    if (other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double totalIncome = ref.watch(turnkeyProvider).totalIncome;
    double yearlyIncome = ref.watch(turnkeyProvider).yearlyIncome;

    String totalIncomeString = kCurrencyFormat.format(totalIncome);
    String totalYearlyIncomeString = kCurrencyFormat.format(yearlyIncome);

    return MyInputPage(
        imageUri: 'images/income.svg',
        headerText: 'Income',
        subheadText: 'Enter the income amounts',
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const TurnkeyRentalPropertyCosts());
        } else {
          Get.back();
        }
      },
        onSubmit: () {
          ref.read(turnkeyProvider).calculateTotalIncome();
          Get.to(() => const TurnkeyRentalExpensesInput());
        },
        position: kTurnKeyRentalQuestions.indexOf(TurnkeyRentalIncomeInput) + 1,
        totalQuestions: kTurnKeyRentalQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'Rent Per Month',
                controller: rentController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(turnkeyProvider).updateRent(value);
                    ref.read(turnkeyProvider).calculateTotalIncome();
                    ref.read(turnkeyProvider).calculateYearlyIncome();
                  }
                  else {
                    ref.read(turnkeyProvider).updateRent(0);
                    ref.read(turnkeyProvider).calculateTotalIncome();
                    ref.read(turnkeyProvider).calculateYearlyIncome();
                  }
                }),
            MoneyTextField(
                labelText: 'Other',
                controller: otherController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(turnkeyProvider).updateOtherIncome(value);
                    ref.read(turnkeyProvider).calculateTotalIncome();
                    ref.read(turnkeyProvider).calculateYearlyIncome();
                  }
                  else {
                    ref.read(turnkeyProvider).updateOtherIncome(0);
                    ref.read(turnkeyProvider).calculateTotalIncome();
                    ref.read(turnkeyProvider).calculateYearlyIncome();
                  }
                }),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Total\nIncome'
                : 'Total Income', totalIncomeString),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Yearly\nIncome'
                : 'Yearly Income', totalYearlyIncomeString),
          ],
        ),
    );
  }
}
