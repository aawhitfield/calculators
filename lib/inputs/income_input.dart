import 'package:calculators/globals.dart';
import 'package:calculators/inputs/expenses_input.dart';
import 'package:calculators/providers.dart';
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

  @override
  void initState() {
    double rent = ref.read(incomeProvider).rent;
    if (rent != 0) {
      rentController.text = kCurrencyFormat.format(rent);
    }
    double other = ref.read(incomeProvider).other;
    if (other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MyInputPage(
        imageUri: 'images/income.svg',
        headerText: 'Income',
        subheadText: 'Enter the income amounts',
        onSubmit: () {
          ref.read(incomeProvider).calculateTotal();
          Get.to(() => const ExpensesInput());
        },
        position: kResidentialREIQuestions.indexOf(IncomeInput) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'Rent',
                controller: rentController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(incomeProvider).updateRent(value);
                  }
                }),
            MoneyTextField(
                labelText: 'Other',
                controller: otherController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(incomeProvider).updateOther(value);
                  }
                }),
          ],
        ),
    );
  }
}
