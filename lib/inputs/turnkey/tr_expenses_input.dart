import 'package:calculators/globals.dart';
import 'package:calculators/inputs/turnkey/tr_finance_options.dart';
import 'package:calculators/inputs/turnkey/tr_income_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TurnkeyRentalExpensesInput extends ConsumerStatefulWidget {
  const TurnkeyRentalExpensesInput({Key? key}) : super(key: key);

  @override
  _ExpensesInputState createState() => _ExpensesInputState();
}

class _ExpensesInputState extends ConsumerState<TurnkeyRentalExpensesInput> {
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  GlobalKey<FormState> turnkeyExpensesKey = GlobalKey<FormState>();

  @override
  void initState() {
    double taxes = ref.read(turnkeyProvider).taxesYearly;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(turnkeyProvider).insuranceYearly;
    if (insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }
    double propertyManagement =
        ref.read(turnkeyProvider).propertyManagementPercentage * 100;
    if (propertyManagement != 0) {
      propertyManagementController.text =
          kWholeNumber.format(propertyManagement);
    }
    double vacancy = ref.read(turnkeyProvider).vacancyPercentage * 100;
    if (vacancy != 0) {
      vacancyController.text = kWholeNumber.format(vacancy);
    }
    double maintenance = ref.read(turnkeyProvider).maintenancePercentage * 100;
    if (maintenance != 0) {
      maintenanceController.text = kWholeNumber.format(maintenance);
    }
    double other = ref.read(turnkeyProvider).otherExpensesPercentage * 100;
    if (other != 0) {
      otherController.text = kWholeNumber.format(other);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double taxesMonthly = ref.watch(turnkeyProvider).taxesMonthly;
    double insuranceMonthly = ref.watch(turnkeyProvider).insuranceMonthly;
    double vacancyMonthly = ref.watch(turnkeyProvider).vacancyMonthly;
    double propertyManagement =
        ref.watch(turnkeyProvider).propertyManagementMonthly;
    double maintenanceMonthly = ref.watch(turnkeyProvider).maintenanceMonthly;
    double otherExpenses = ref.watch(turnkeyProvider).otherExpensesMonthly;

    String taxesMonthlyString = kCurrencyFormat.format(taxesMonthly);
    String insuranceMonthlyString = kCurrencyFormat.format(insuranceMonthly);
    String propertyManagementMonthlyString =
        kCurrencyFormat.format(propertyManagement);
    String vacancyMonthlyString = kCurrencyFormat.format(vacancyMonthly);
    String maintenanceMonthlyString =
        kCurrencyFormat.format(maintenanceMonthly);
    String otherExpensesMonthlyString = kCurrencyFormat.format(otherExpenses);

    return Form(
      key: turnkeyExpensesKey,
      child: MyInputPage(
        imageUri: 'images/expenses.svg',
        headerText: 'Expenses',
        subheadText: '',
        position: kTurnKeyRentalQuestions.indexOf(TurnkeyRentalExpensesInput) + 1,
        totalQuestions: kTurnKeyRentalQuestions.length,
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            Get.off(() => const TurnkeyRentalIncomeInput());
          } else {
            Get.back();
          }
        },
        onSubmit: () {
          if (turnkeyExpensesKey.currentState?.validate() ?? false) {
            Get.to(() => const TurnkeyRentalFinanceOptions());
          }
        },
        child: ResponsiveLayout(
          children: [
            MoneyTextField(
              labelText: 'Taxes (Yearly) *',
              controller: taxesController,
              onChanged: (String newValue) {
                newValue = newValue.replaceAll(',', '');
                double? taxes = double.tryParse(newValue);
                if (taxes != null) {
                  ref.read(turnkeyProvider).updateTaxes(taxes);
                } else {
                  ref.read(turnkeyProvider).updateTaxes(0.0);
                }
                ref.read(turnkeyProvider).calculateAllExpenses();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Taxes field is required';
                }
                return null;
              },
            ),
            MoneyListTile('Taxes', taxesMonthlyString, subtitle: 'Monthly'),
            MoneyTextField(
              labelText: 'Insurance (Yearly) *',
              controller: insuranceController,
              onChanged: (String newValue) {
                newValue = newValue.replaceAll(',', '');
                double? insurance = double.tryParse(newValue);
                if (insurance != null) {
                  ref.read(turnkeyProvider).updateInsurance(insurance);
                } else {
                  ref.read(turnkeyProvider).updateInsurance(0.0);
                }
                ref.read(turnkeyProvider).calculateAllExpenses();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insurance is required';
                }
                return null;
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
                    ref.read(turnkeyProvider).updatePropertyManagement(value);
                  } else {
                    ref.read(turnkeyProvider).updatePropertyManagement(0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
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
                    ref.read(turnkeyProvider).updateVacancy(value);
                  } else {
                    ref.read(turnkeyProvider).updateVacancy(0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
                }),
            MoneyListTile('Vacancy', vacancyMonthlyString, subtitle: 'Monthly'),
            PercentTextField(
                labelText: 'Maintenance',
                controller: maintenanceController,
                onChanged: (String newValue) {
                  double? value = double.tryParse(newValue);
                  if (value != null) {
                    value = value / 100; // convert to decimal from %
                    ref.read(turnkeyProvider).updateMaintenance(value);
                  } else {
                    ref.read(turnkeyProvider).updateMaintenance(0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
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
                    ref.read(turnkeyProvider).updateOther(value);
                  } else {
                    ref.read(turnkeyProvider).updateOther(0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
                }),
            MoneyListTile('Other Expenses', otherExpensesMonthlyString,
                subtitle: 'Monthly'),
            MoneyListTile(
              'Total \nExpenses',
              kCurrencyFormat
                  .format(ref.watch(turnkeyProvider).totalMonthlyExpenses)
                  .toString(),
              subtitle: 'Monthly',
            ),
            MoneyListTile(
              'Total \nExpenses',
              kCurrencyFormat.format(double.parse(ref
                  .watch(turnkeyProvider)
                  .totalAnnualExpenses
                  .toStringAsFixed(2))),
              subtitle: 'Yearly',
            ),
            MoneyListTile(
              'NOI',
              kCurrencyFormat
                  .format(ref.watch(turnkeyProvider).noiMonthly)
                  .toString(),
              subtitle: 'Monthly',
            ),
            MoneyListTile(
              'NOI',
              kCurrencyFormat
                  .format(ref.watch(turnkeyProvider).noiAnnual)
                  .toString(),
              subtitle: 'Yearly',
            ),
          ],
        ),
      ),
    );
  }
}
