import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomeInput extends ConsumerWidget {
  const IncomeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
        imageUri: 'images/income.svg',
        headerText: 'Income',
        subheadText: 'Enter the income amounts',
        onSubmit: () {
          ref.read(incomeProvider).calculateTotal();
        },
        position: kResidentialREIQuestions.indexOf(IncomeInput) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
                labelText: 'Rent',
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? value = double.tryParse(newValue);
                  if(value != null) {
                    ref.read(incomeProvider).updateRent(value);
                  }
                }),
            MoneyTextField(
                labelText: 'Other',
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
