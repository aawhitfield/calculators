import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/expenses_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class IncomeInput extends ConsumerStatefulWidget {
  const IncomeInput({Key? key}) : super(key: key);

  @override
  _IncomeInputState createState() => _IncomeInputState();
}

class _IncomeInputState extends ConsumerState<IncomeInput> {
  TextEditingController rentController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController afterRepairRentController = TextEditingController();
  TextEditingController afterRepairOtherController = TextEditingController();

  @override
  void initState() {
    double rent = ref.read(brrrrProvider).rent;
    if (rent != 0) {
      rentController.text = kCurrencyFormat.format(rent);
    }
    double other = ref.read(brrrrProvider).otherIncome;
    if (other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    double afterRepairRent = ref.read(brrrrProvider).afterRepairRentPerMonth;
    if (afterRepairRent != 0) {
      afterRepairRentController.text = kCurrencyFormat.format(afterRepairRent);
    }
    double afterRepairOther = ref.read(brrrrProvider).afterRepairOtherIncome;
    if (afterRepairOther != 0) {
      afterRepairOtherController.text = kCurrencyFormat.format(afterRepairOther);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double totalIncome = ref.watch(brrrrProvider).totalIncome;
    double yearlyIncome = ref.watch(brrrrProvider).yearlyIncome;
    double totalIncomeAfterRepair = ref.watch(brrrrProvider).totalIncomeAfterRepair;
    double yearlyIncomeAfterRepair = ref.watch(brrrrProvider).yearlyIncomeAfterRepair;

    String totalIncomeString = kCurrencyFormat.format(totalIncome);
    String totalYearlyIncomeString = kCurrencyFormat.format(yearlyIncome);
    String totalIncomeAfterRepairString = kCurrencyFormat.format(totalIncomeAfterRepair);
    String totalYearlyIncomeAfterRepairString = kCurrencyFormat.format(yearlyIncomeAfterRepair);

    return MyInputPage(
        imageUri: 'images/income.svg',
        headerText: 'Income',
        subheadText: 'Enter the income amounts',
        onSubmit: () {
          ref.read(brrrrProvider).calculateTotalIncome();
          Get.to(() => const ExpensesInput());
        },
        position: kBRRRRQuestions.indexOf(IncomeInput) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'Rent',
                controller: rentController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(brrrrProvider).updateRent(value);
                    ref.read(brrrrProvider).calculateTotalIncome();
                    ref.read(brrrrProvider).calculateYearlyIncome();
                  }
                  else {
                    ref.read(brrrrProvider).updateRent(0);
                    ref.read(brrrrProvider).calculateTotalIncome();
                    ref.read(brrrrProvider).calculateYearlyIncome();
                  }
                }),
            MoneyTextField(
                labelText: 'Other',
                controller: otherController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(brrrrProvider).updateOtherIncome(value);
                    ref.read(brrrrProvider).calculateTotalIncome();
                    ref.read(brrrrProvider).calculateYearlyIncome();
                  }
                  else {
                    ref.read(brrrrProvider).updateOtherIncome(0);
                    ref.read(brrrrProvider).calculateTotalIncome();
                    ref.read(brrrrProvider).calculateYearlyIncome();
                  }
                }),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Total\nIncome'
                : 'Total Income', totalIncomeString),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Yearly\nIncome'
                : 'Yearly Income', totalYearlyIncomeString),
            const Divider(),
            MoneyTextField(
                controller: afterRepairRentController,
                labelText: 'After Repair Rent Per Month', onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? value = double.tryParse(newValue);
              if(value != null) {
                ref.read(brrrrProvider).updateRepairRentPerMonth(value);
                ref.read(brrrrProvider).calculateTotalIncomeAfterRepair();
                ref.read(brrrrProvider).calculateYearlyIncomeAfterRepair();
              }
              else {
                ref.read(brrrrProvider).updateRepairRentPerMonth(0);
                ref.read(brrrrProvider).calculateTotalIncomeAfterRepair();
                ref.read(brrrrProvider).calculateYearlyIncomeAfterRepair();
              }
            }),
            MoneyTextField(
                controller: afterRepairOtherController,
                labelText: 'After Repair Other Income', onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? value = double.tryParse(newValue);
              if(value != null) {
                ref.read(brrrrProvider).updateAfterRepairOtherIncome(value);
                ref.read(brrrrProvider).calculateTotalIncomeAfterRepair();
                ref.read(brrrrProvider).calculateYearlyIncomeAfterRepair();
              }
              else {
                ref.read(brrrrProvider).updateAfterRepairOtherIncome(0);
                ref.read(brrrrProvider).calculateTotalIncomeAfterRepair();
                ref.read(brrrrProvider).calculateYearlyIncomeAfterRepair();
              }
            }),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Total\nIncome'
                : 'Total Income', totalIncomeAfterRepairString),
            MoneyListTile((MediaQuery.of(context).size.width < 640)
                ? 'Yearly\nIncome'
                : 'Yearly Income', totalYearlyIncomeAfterRepairString),
          ],
        ),
    );
  }
}
