import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/outputs/colored_percent_list_tile.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/colored_money_list_tile.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/numerical_list_tile.dart';
import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashFlowStatement extends ConsumerStatefulWidget {
  const CashFlowStatement({
    Key? key,
  }) : super(key: key);

  @override
  _CashFlowStatementState createState() => _CashFlowStatementState();
}

class _CashFlowStatementState extends ConsumerState<CashFlowStatement> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double income = ref.read(brrrrProvider).totalIncome;
    if (income != 0) {
      incomeController.text = kCurrencyFormat.format(income);
    }
    double taxes = ref.read(brrrrProvider).taxesMonthly;
    if (taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(brrrrProvider).insuranceMonthly;
    if (insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }
    double propertyManagement =
        ref.read(brrrrProvider).propertyManagementMonthly;
    if (propertyManagement != 0) {
      propertyManagementController.text =
          kCurrencyFormat.format(propertyManagement);
    }
    double vacancy = ref.read(brrrrProvider).vacancyMonthly;
    if (vacancy != 0) {
      vacancyController.text = kCurrencyFormat.format(vacancy);
    }
    double maintenance = ref.read(brrrrProvider).maintenanceMonthly;
    if (maintenance != 0) {
      maintenanceController.text = kCurrencyFormat.format(maintenance);
    }
    double other = ref.read(brrrrProvider).otherExpensesMonthly;
    if (other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalMonthlyIncome = ref.watch(brrrrProvider).totalIncome;
    double totalMonthlyExpenses = ref.watch(brrrrProvider).totalMonthlyExpenses;
    double noiMonthly = totalMonthlyIncome - totalMonthlyExpenses;

    int months = ref.read(brrrrProvider).monthsToRehabRent;
    double debtService = (months != 0)
        ? ref.read(brrrrProvider).debtService / months
        : ref.read(brrrrProvider).debtService;
    double cashFlow = noiMonthly - debtService;
    double yearlyCashFlow = cashFlow * 12;
    BRRRR provider = ref.read(brrrrProvider);
    double cashOnCash = yearlyCashFlow /
        (provider.downPaymentAmount +
            provider.constructionDownPaymentAmount +
            provider.closingCosts) *
        100;
    double dscr = noiMonthly / debtService;
    double onePercentRule = provider.rent / provider.purchasePrice * 100;

    String expensesString = kCurrencyFormat.format(totalMonthlyExpenses);
    String noiString = kCurrencyFormat.format(noiMonthly);
    String debtServiceString = kCurrencyFormat.format(debtService);
    String cashFlowString = kCurrencyFormat.format(cashFlow);
    String yearlyCashFlowString = kCurrencyFormat.format(yearlyCashFlow);
    String cashOnCashReturnString = cashOnCash.toStringAsFixed(2);
    String dscrString = dscr.toStringAsFixed(2);
    String onePercentRuleString = onePercentRule.toStringAsFixed(3);

    return Column(
      children: [
        const ReportHeader('Monthly Cashflow Statement'),
        const SizedBox(height: 16),
        MoneyTextField(
            labelText: 'Income',
            controller: incomeController,
            onChanged: (String newPrice) {
              newPrice = newPrice.replaceAll(',', '');
              double? price = double.tryParse(newPrice);
              if (price != null) {
                ref.read(brrrrProvider).updateTotalIncome(price);
              } else {
                ref.read(brrrrProvider).updateTotalIncome(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        ExpansionTile(
          leading: Text(
            'Expenses',
            style: Theme.of(context).textTheme.headline6,
          ),
          title: Text(
            '\$ $expensesString',
            style: Theme.of(context).textTheme.headline5,
          ),
          children: [
            MoneyTextField(
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
            MoneyTextField(
                labelText: 'Property Management',
                controller: propertyManagementController,
                onChanged: (String newValue) {
                  double? value = double.tryParse(newValue);
                  if (value != null) {
                    ref
                        .read(brrrrProvider)
                        .updatePropertyManagementMonthly(value);
                  } else {
                    ref
                        .read(brrrrProvider)
                        .updatePropertyManagementMonthly(0.0);
                  }
                  ref.read(brrrrProvider).calculateAllExpenses();
                }),
            MoneyTextField(
                labelText: 'Vacancy',
                controller: vacancyController,
                onChanged: (String newValue) {
                  double? value = double.tryParse(newValue);
                  if (value != null) {
                    ref.read(brrrrProvider).updateVacancyMonthly(value);
                  } else {
                    ref.read(brrrrProvider).updateVacancyMonthly(0.0);
                  }
                  ref.read(brrrrProvider).calculateAllExpenses();
                }),
            MoneyTextField(
                labelText: 'Maintenance',
                controller: maintenanceController,
                onChanged: (String newValue) {
                  double? value = double.tryParse(newValue);
                  if (value != null) {
                    ref.read(brrrrProvider).updateMaintenanceMonthly(value);
                  } else {
                    ref.read(brrrrProvider).updateMaintenanceMonthly(0.0);
                  }
                  ref.read(brrrrProvider).calculateAllExpenses();
                }),
            MoneyTextField(
                labelText: 'Other',
                controller: otherController,
                onChanged: (String newValue) {
                  double? value = double.tryParse(newValue);
                  if (value != null) {
                    ref.read(brrrrProvider).updateOtherMonthly(value);
                  } else {
                    ref.read(brrrrProvider).updateOtherMonthly(0.0);
                  }
                  ref.read(brrrrProvider).calculateAllExpenses();
                }),
          ],
        ),
        MoneyListTile('NOI', noiString),
        MoneyListTile('Debt Service', debtServiceString),
        ColoredMoneyListTile(
          value: cashFlow,
          smallScreenTitle: 'Cashflow',
          largeScreenTitle: 'Cashflow',
          valueString: cashFlowString,
        ),
        ColoredMoneyListTile(
          value: yearlyCashFlow,
          smallScreenTitle: 'Yearly\nCashflow',
          largeScreenTitle: 'Yearly Cashflow',
          valueString: yearlyCashFlowString,
        ),
        const SizedBox(height: 16),
        Text('Initial Purchase Metrics',
            style: Theme.of(context).textTheme.headline5),
        const Divider(),
        ColoredPercentListTile(
            value: cashOnCash,
            smallScreenTitle: 'Cash on\nCash Return', largeScreenTitle: 'Cash on Cash Return',
            valueString: cashOnCashReturnString),
        NumericalListTile('Debt Service\n Coverage Ratio', dscrString),
        PercentListTile('1% Rule', onePercentRuleString),
        const SizedBox(height: 32),
      ],
    );
  }
}
