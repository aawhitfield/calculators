import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_options.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ExpensesInput extends ConsumerWidget {
  const ExpensesInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      imageUri: 'images/expenses.svg',
      headerText: 'Expenses',
      subheadText: '',
      position: kResidentialREIQuestions.indexOf(ExpensesInput) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      onSubmit: () {
        Get.to(() => const FinanceOptions());
      },
      child: ResponsiveLayout(
        children: [
          MoneyTextField(
            labelText: 'Taxes',
            onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? taxes = double.tryParse(newValue);
              if (taxes != null) {
                ref.read(expensesProvider).updateTaxes(taxes);
              }
            },
          ),
          MoneyListTile('Insurance',
              kCurrencyFormat.format(
                  double.parse(ref.watch(expensesProvider)
                      .insurance.toStringAsFixed(2).replaceAll(',', ''))),
          ),
          PercentTextField(labelText: 'Property Management',
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if(value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(expensesProvider).updatePropertyManagement(value);
                }
              }),
          PercentTextField(labelText: 'Vacancy',
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if(value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(expensesProvider).updateVacancy(value);
                }
              }),
          PercentTextField(labelText: 'Maintenance',
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if(value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(expensesProvider).updateMaintenance(value);
                }
              }),
          PercentTextField(labelText: 'Other',
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if(value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(expensesProvider).updateOther(value);
                }
              }),
          MoneyListTile('Total Expenses',
            kCurrencyFormat.format(ref.watch(expensesProvider).calculateTotalExpensesMonthly(
                ref.watch(incomeProvider).total)).toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile('Total Expenses',
            kCurrencyFormat.format(double.parse(ref.watch(expensesProvider)
                .calculateTotalAnnualExpenses().toStringAsFixed(2))),
            subtitle: 'Annually',
          ),
          MoneyListTile('NOI',
            kCurrencyFormat.format(ref.watch(expensesProvider).calculateNOIMonthly(
                ref.watch(incomeProvider).total)).toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile('NOI',
            kCurrencyFormat.format(ref.watch(expensesProvider).calculateNOIAnnually(
                ref.watch(incomeProvider).total)).toString(),
            subtitle: 'Annually',
          ),
        ],
      ),
    );
  }
}
