import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesExpansionTile extends ConsumerStatefulWidget {
  const ExpensesExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  _ExpensesExpansionTileState createState() => _ExpensesExpansionTileState();
}

class _ExpensesExpansionTileState extends ConsumerState<ExpensesExpansionTile> {
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementPercentageController =
  TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double taxes = ref.read(brrrrProvider).taxesMonthly;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(brrrrProvider).insuranceMonthly;
    if (insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }
    double propertyManagementPercentage =
        ref.read(brrrrProvider).propertyManagementPercentage * 100;
    if (propertyManagementPercentage != 0) {
      propertyManagementPercentageController.text =
          kWholeNumber.format(propertyManagementPercentage);
    }
    double vacancyPercentage = ref.read(brrrrProvider).vacancyPercentage * 100;
    if (vacancyPercentage != 0) {
      vacancyController.text = kWholeNumber.format(vacancyPercentage);
    }
    double maintenancePercentage =
        ref.read(brrrrProvider).maintenancePercentage * 100;
    if (maintenancePercentage != 0) {
      maintenanceController.text = kWholeNumber.format(maintenancePercentage);
    }
    double otherPercentage =
        ref.read(brrrrProvider).otherExpensesPercentage * 100;
    if (otherPercentage != 0) {
      otherController.text = kWholeNumber.format(otherPercentage);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BRRRR provider = ref.watch(brrrrProvider);
    double expenses = provider.afterRepairTotalExpensesMonthly;

    double propertyManagement =
        ref.watch(brrrrProvider).propertyManagementMonthly;
    double vacancy = ref.watch(brrrrProvider).vacancyMonthly;
    double maintenance = ref.watch(brrrrProvider).maintenanceMonthly;
    double other = ref.watch(brrrrProvider).otherExpensesMonthly;

    String expensesString = kCurrencyFormat.format(expenses);

    return ExpansionTile(
      leading: Text(
        'Expenses',
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Text(
        '\$ $expensesString',
        style: Theme.of(context).textTheme.headline5,
      ),
      children: [
        PercentTextField(
          labelText: 'Taxes',
          controller: taxesController,
          onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? taxes = double.tryParse(newValue);
            if (taxes != null) {
              ref.read(brrrrProvider).updateTaxesMonthly(taxes);
            } else {
              ref.read(brrrrProvider).updateTaxesMonthly(0);
            }
            ref.read(brrrrProvider).calculateAllExpenses();
          },
        ),
        MoneyTextField(
          labelText: 'Insurance',
          controller: insuranceController,
          onChanged: (String newValue) {
            newValue = newValue.replaceAll(',', '');
            double? insurance = double.tryParse(newValue);
            if (insurance != null) {
              ref.read(brrrrProvider).updateInsuranceMonthly(insurance);
            } else {
              ref.read(brrrrProvider).updateInsuranceMonthly(0.0);
            }
            ref.read(brrrrProvider).calculateAllExpenses();
          },
        ),
        PercentTextField(
            labelText: 'Property Management Percentage',
            controller: propertyManagementPercentageController,
            onChanged: (String newValue) {
              double? value = double.tryParse(newValue);
              if (value != null) {
                value = value / 100; // convert to decimal from %
                ref.read(brrrrProvider).updatePropertyManagement(value);
              } else {
                ref.read(brrrrProvider).updatePropertyManagement(0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile(
            'Property\nManagement', kCurrencyFormat.format(propertyManagement)),
        MoneyTextField(
            labelText: 'Vacancy Percentage',
            controller: vacancyController,
            onChanged: (String newValue) {
              double? value = double.tryParse(newValue);
              if (value != null) {
                value = value / 100; // convert to decimal from %
                ref.read(brrrrProvider).updateVacancy(value);
              } else {
                ref.read(brrrrProvider).updateVacancy(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile('Vacancy', kCurrencyFormat.format(vacancy)),
        MoneyTextField(
            labelText: 'Maintenance Percentage',
            controller: maintenanceController,
            onChanged: (String newValue) {
              double? value = double.tryParse(newValue);
              if (value != null) {
                value = value / 100;
                ref.read(brrrrProvider).updateMaintenance(value);
              } else {
                ref.read(brrrrProvider).updateMaintenance(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile('Maintenance', kCurrencyFormat.format(maintenance)),
        MoneyTextField(
            labelText: 'Other Percentage',
            controller: otherController,
            onChanged: (String newValue) {
              double? value = double.tryParse(newValue);
              if (value != null) {
                value = value / 100;
                ref.read(brrrrProvider).updateOther(value);
              } else {
                ref.read(brrrrProvider).updateOther(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile('Other', kCurrencyFormat.format(other)),
      ],
    );
  }
}
