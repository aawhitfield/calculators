import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_options.dart';
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
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double taxes = ref.read(brrrrProvider).taxesYearly;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(brrrrProvider).insuranceYearly;
    if (insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }
    double propertyManagement =
        ref.read(brrrrProvider).propertyManagementPercentage * 100;
    if (propertyManagement != 0) {
      propertyManagementController.text =
          kWholeNumber.format(propertyManagement);
    }
    double vacancy = ref.read(brrrrProvider).vacancyPercentage * 100;
    if (vacancy != 0) {
      vacancyController.text = kWholeNumber.format(vacancy);
    }
    double maintenance = ref.read(brrrrProvider).maintenancePercentage * 100;
    if (maintenance != 0) {
      maintenanceController.text = kWholeNumber.format(maintenance);
    }
    double other = ref.read(brrrrProvider).otherExpensesPercentage * 100;
    if (other != 0) {
      otherController.text = kWholeNumber.format(other);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double taxesMonthly = ref.watch(brrrrProvider).taxesMonthly;
    double insuranceMonthly = ref.watch(brrrrProvider).insuranceMonthly;
    double vacancyMonthly = ref.watch(brrrrProvider).vacancyMonthly;
    double propertyManagement =
        ref.watch(brrrrProvider).propertyManagementMonthly;
    double maintenanceMonthly = ref.watch(brrrrProvider).maintenanceMonthly;
    double otherExpenses = ref.watch(brrrrProvider).otherExpensesMonthly;

    String taxesMonthlyString = kCurrencyFormat.format(taxesMonthly);
    String insuranceMonthlyString = kCurrencyFormat.format(insuranceMonthly);
    String propertyManagementMonthlyString =
        kCurrencyFormat.format(propertyManagement);
    String vacancyMonthlyString = kCurrencyFormat.format(vacancyMonthly);
    String maintenanceMonthlyString =
        kCurrencyFormat.format(maintenanceMonthly);
    String otherExpensesMonthlyString = kCurrencyFormat.format(otherExpenses);

    return MyInputPage(
      imageUri: 'images/expenses.svg',
      headerText: 'Expenses',
      subheadText: '',
      position: kBRRRRQuestions.indexOf(ExpensesInput) + 1,
      totalQuestions: kBRRRRQuestions.length,
      onSubmit: () {
        Get.to(() => const FinanceOptions());
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
                ref.read(brrrrProvider).updateTaxes(taxes);
              } else {
                ref.read(brrrrProvider).updateTaxes(0);
              }
              ref.read(brrrrProvider).calculateAllExpenses();
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
                ref.read(brrrrProvider).updateInsurance(insurance);
              } else {
                ref.read(brrrrProvider).updateTaxes(0);
              }
              ref.read(brrrrProvider).calculateAllExpenses();
            },
          ),
          MoneyListTile('Insurance', insuranceMonthlyString,
              subtitle: 'Monthly'),
          PercentTextField(
              labelText: 'Property Management',
              controller: propertyManagementController,
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if (value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(brrrrProvider).updatePropertyManagement(value);
                } else {
                  ref.read(brrrrProvider).updatePropertyManagement(0);
                }
                ref.read(brrrrProvider).calculateAllExpenses();
              }),
          MoneyListTile((MediaQuery.of(context).size.width < 640)
              ? 'Property\nManagement'
              : 'Property Management', propertyManagementMonthlyString,
              subtitle: 'Monthly'),
          PercentTextField(
              labelText: 'Vacancy',
              controller: vacancyController,
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if (value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(brrrrProvider).updateVacancy(value);
                } else {
                  ref.read(brrrrProvider).updateVacancy(0);
                }
                ref.read(brrrrProvider).calculateAllExpenses();
              }),
          MoneyListTile('Vacancy', vacancyMonthlyString, subtitle: 'Monthly'),
          PercentTextField(
              labelText: 'Maintenance',
              controller: maintenanceController,
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if (value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(brrrrProvider).updateMaintenance(value);
                } else {
                  ref.read(brrrrProvider).updateMaintenance(0);
                }
                ref.read(brrrrProvider).calculateAllExpenses();
              }),
          MoneyListTile('Maintenance', maintenanceMonthlyString,
              subtitle: 'Monthly'),
          PercentTextField(
              labelText: 'Other',
              controller: otherController,
              onChanged: (String newValue) {
                double? value = double.tryParse(newValue);
                if (value != null) {
                  value = value / 100; // convert to decimal from %
                  ref.read(brrrrProvider).updateOther(value);
                } else {
                  ref.read(brrrrProvider).updateOther(0);
                }
                ref.read(brrrrProvider).calculateAllExpenses();
              }),
          MoneyListTile('Other Expenses', otherExpensesMonthlyString,
              subtitle: 'Monthly'),
          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).totalMonthlyExpenses)
                .toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile(
            'Total \nExpenses',
            kCurrencyFormat.format(double.parse(ref
                .watch(brrrrProvider)
                .totalAnnualExpenses
                .toStringAsFixed(2))),
            subtitle: 'Annually',
          ),
          MoneyListTile(
            'NOI',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).noiMonthly)
                .toString(),
            subtitle: 'Monthly',
          ),
          MoneyListTile(
            'NOI',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).noiAnnual)
                .toString(),
            subtitle: 'Annually',
          ),

          MoneyListTile(
            'After\nRepair',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).totalMonthlyExpenses)
                .toString(),
            subtitle: 'Total Expenses Monthly',
          ),
          MoneyListTile(
            'After\nRepair',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).totalAnnualExpenses)
                .toString(),
            subtitle: 'Total Expenses Yearly',
          ),
          MoneyListTile(
            'After\nRepair',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).afterRepairNOIMonthly)
                .toString(),
            subtitle: 'NOI Monthly',
          ),
          MoneyListTile(
            'After\nRepair',
            kCurrencyFormat
                .format(ref.watch(brrrrProvider).afterRepairNOIYearly)
                .toString(),
            subtitle: 'NOI Yearly',
          ),
        ],
      ),
    );
  }
}
