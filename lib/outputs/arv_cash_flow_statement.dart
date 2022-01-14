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
// ignore: import_of_legacy_library_into_null_safe
import 'package:finance/finance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ARVCashFlowStatement extends ConsumerStatefulWidget {
  const ARVCashFlowStatement({
    Key? key,
  }) : super(key: key);

  @override
  _ARVCashFlowStatementState createState() => _ARVCashFlowStatementState();
}

class _ARVCashFlowStatementState extends ConsumerState<ARVCashFlowStatement> {
  TextEditingController rentIncomeController = TextEditingController();
  TextEditingController otherIncomeController = TextEditingController();
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  late double rentIncome;
  late double otherIncome;

  @override
  void initState() {
   rentIncome = ref.read(brrrrProvider).rent;
    if (rentIncome != 0) {
      rentIncomeController.text = kCurrencyFormat.format(rentIncome);
    }
    otherIncome = ref.read(brrrrProvider).otherIncome;
    if(otherIncome != 0) {
      otherIncomeController.text = kCurrencyFormat.format(otherIncome);
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
    BRRRR provider = ref.watch(brrrrProvider);
    double income = provider.totalIncome;
    double expenses = provider.afterRepairTotalExpensesMonthly;
    double noi = income - expenses;
    double debtService = Finance.pmt(
      rate: provider.refinancingInterestRate / 12,
      nper: provider.refinancingTerm * 12,
      pv: -1 * provider.refinancingLoanAmount,
    ) as double;
    double cashFlow = noi - debtService;
    double yearlyCashFlow = cashFlow * 12;
    double initialCash = provider.downPaymentAmount +
        provider.constructionDownPaymentAmount +
        provider.closingCosts;
    double cashOnCashReturn = yearlyCashFlow / initialCash * 100;
    double dscr = noi / debtService;
    double onePercentRule =
        provider.afterRepairRentPerMonth / provider.afterRepairValue * 100;

    String incomeString = kCurrencyFormat.format(income);
    String expensesString = kCurrencyFormat.format(expenses);
    String noiString = kCurrencyFormat.format(noi);
    String debtServiceString = kCurrencyFormat.format(debtService);
    String cashFlowString = kCurrencyFormat.format(cashFlow);
    String yearlyCashFlowString = kCurrencyFormat.format(yearlyCashFlow);
    String cashOnCashReturnString = cashOnCashReturn.toStringAsFixed(2);
    String dscrString = dscr.toStringAsFixed(2);
    String onePercentRuleString = onePercentRule.toStringAsFixed(3);

    return Column(
      children: [
        const ReportHeader('Monthly ARV Cash Flow Statement'),
        const SizedBox(height: 16),
        ExpansionTile(
          leading: Text('Income', style: Theme.of(context).textTheme.headline6,),
          title: Text(
            '\$ $incomeString',
            style: Theme.of(context).textTheme.headline5,
          ),
          children: [
            MoneyTextField(
              controller: rentIncomeController,
              labelText: 'Rent',
              onChanged: (String newValue) {
                newValue = newValue.replaceAll(',', '');
                double? newIncome = double.tryParse(newValue);
                if (newIncome != null) {
                  ref.read(brrrrProvider).updateRent(newIncome);
                } else {
                  ref.read(brrrrProvider).updateRent(0.0);
                }
                ref.read(brrrrProvider).calculateAll();
              },
            ),
            MoneyTextField(
              controller: otherIncomeController,
              labelText: 'Other Income',
              onChanged: (String newValue) {
                newValue = newValue.replaceAll(',', '');
                double? newIncome = double.tryParse(newValue);
                if (newIncome != null) {
                  ref.read(brrrrProvider).updateOtherIncome(newIncome);
                } else {
                  ref.read(brrrrProvider).updateOtherIncome(0.0);
                }
                ref.read(brrrrProvider).calculateAll();
              },
            ),
          ],
        ),
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
            smallScreenTitle: 'Cashflow', largeScreenTitle: 'Cashflow',
            valueString: cashFlowString,),
        ColoredMoneyListTile(
            value: yearlyCashFlow,
            smallScreenTitle: 'Yearly\nCashflow',
            largeScreenTitle: 'Yearly Cashflow',
            valueString: yearlyCashFlowString),
        const SizedBox(height: 16),
        Text('Refinance Metrics', style: Theme.of(context).textTheme.headline5),
        const Divider(),
        ColoredPercentListTile(
            value: cashOnCashReturn,
            smallScreenTitle: 'Cash on\nCash Return',
            largeScreenTitle: 'Cash on Cash Return',
            valueString: cashOnCashReturnString),
        NumericalListTile('Debt Service\nCoverage Ratio', dscrString),
        PercentListTile('1% Rule', onePercentRuleString),
        const SizedBox(height: 32),
      ],
    );
  }
}
