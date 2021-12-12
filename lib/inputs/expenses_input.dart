import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_options.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ExpensesInput extends ConsumerStatefulWidget {
  const ExpensesInput({Key? key}) : super(key: key);

  @override
  _ExpensesInputState createState() => _ExpensesInputState();
}

class _ExpensesInputState extends ConsumerState<ExpensesInput> {
  TextEditingController taxesController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double taxes = ref.read(expensesProvider).taxes;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double propertyManagement =
        ref.read(expensesProvider).propertyManagement * 100;
    if (propertyManagement != 0) {
      propertyManagementController.text =
          kWholeNumber.format(propertyManagement);
    }
    double vacancy = ref.read(expensesProvider).vacancy * 100;
    if (vacancy != 0) {
      vacancyController.text = kWholeNumber.format(vacancy);
    }
    double maintenance = ref.read(expensesProvider).maintenance * 100;
    if (maintenance != 0) {
      maintenanceController.text = kWholeNumber.format(maintenance);
    }
    double other = ref.read(expensesProvider).other * 100;
    if (other != 0) {
      otherController.text = kWholeNumber.format(other);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Calculator calculatorType = ref.read(propertyProvider).calculator;

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
            controller: taxesController,
            onChanged: (String newValue) {
              newValue = newValue.replaceAll(',', '');
              double? taxes = double.tryParse(newValue);
              if (taxes != null) {
                ref.read(expensesProvider).updateTaxes(taxes);
              }
              else {
                ref.read(expensesProvider).updateTaxes(0);
              }
            },
          ),
          (calculatorType == Calculator.residentialREI)
              ? Column(
                  children: [
                    PercentTextField(
                        labelText: 'Property Management',
                        controller: propertyManagementController,
                        onChanged: (String newValue) {
                          double? value = double.tryParse(newValue);
                          if (value != null) {
                            value = value / 100; // convert to decimal from %
                            ref
                                .read(expensesProvider)
                                .updatePropertyManagement(value);
                          }
                          else {
                            ref.read(expensesProvider).updatePropertyManagement(0);
                          }
                        }),
                    PercentTextField(
                        labelText: 'Vacancy',
                        controller: vacancyController,
                        onChanged: (String newValue) {
                          double? value = double.tryParse(newValue);
                          if (value != null) {
                            value = value / 100; // convert to decimal from %
                            ref.read(expensesProvider).updateVacancy(value);
                          }
                          else {
                            ref.read(expensesProvider).updateVacancy(0);
                          }
                        }),
                    PercentTextField(
                        labelText: 'Maintenance',
                        controller: maintenanceController,
                        onChanged: (String newValue) {
                          double? value = double.tryParse(newValue);
                          if (value != null) {
                            value = value / 100; // convert to decimal from %
                            ref.read(expensesProvider).updateMaintenance(value);
                          }
                          else {
                            ref.read(expensesProvider).updateMaintenance(0);
                          }
                        }),
                    PercentTextField(
                        labelText: 'Other',
                        controller: otherController,
                        onChanged: (String newValue) {
                          double? value = double.tryParse(newValue);
                          if (value != null) {
                            value = value / 100; // convert to decimal from %
                            ref.read(expensesProvider).updateOther(value);
                          }
                          else {
                            ref.read(expensesProvider).updateOther(0);
                          }
                        }),
                  ],
                )
              : Container(),
          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat
                .format(ref
                    .watch(expensesProvider)
                    .calculateTotalExpensesMonthly(
                        ref.watch(incomeProvider).total))
                .toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat.format(double.parse(ref
                .watch(expensesProvider)
                .calculateTotalAnnualExpenses()
                .toStringAsFixed(2))),
            subtitle: 'Annually',
          ),
          (calculatorType == Calculator.residentialREI)
              ? Column(
                  children: [
                    MoneyListTile(
                      'NOI',
                      kCurrencyFormat
                          .format(ref
                              .watch(expensesProvider)
                              .calculateNOIMonthly(
                                  ref.watch(incomeProvider).total))
                          .toString(),
                      subtitle: 'Monthly',
                    ),
                    MoneyListTile(
                      'NOI',
                      kCurrencyFormat
                          .format(ref
                              .watch(expensesProvider)
                              .calculateNOIAnnually(
                                  ref.watch(incomeProvider).total))
                          .toString(),
                      subtitle: 'Annually',
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
