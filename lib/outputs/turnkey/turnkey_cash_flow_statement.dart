import 'package:calculators/globals.dart';
import 'package:calculators/models/turnkey_rental_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/numerical_list_tile.dart';
import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnkeyCashFlowStatement extends ConsumerStatefulWidget {
  const TurnkeyCashFlowStatement({
    Key? key,
  }) : super(key: key);

  @override
  _CashFlowStatementState createState() => _CashFlowStatementState();
}

class _CashFlowStatementState extends ConsumerState<TurnkeyCashFlowStatement> {
  TextEditingController taxesController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController propertyManagementController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    double taxes = ref.read(turnkeyProvider).taxesMonthly;
    if(taxes != 0) {
      taxesController.text = kCurrencyFormat.format(taxes);
    }
    double insurance = ref.read(turnkeyProvider).insuranceMonthly;
    if(insurance != 0) {
      insuranceController.text = kCurrencyFormat.format(insurance);
    }
    double propertyManagement = ref.read(turnkeyProvider).propertyManagementMonthly;
    if(propertyManagement != 0) {
      propertyManagementController.text = kCurrencyFormat.format(propertyManagement);
    }
    double vacancy = ref.read(turnkeyProvider).vacancyMonthly;
    if(vacancy != 0) {
      vacancyController.text = kCurrencyFormat.format(vacancy);
    }
    double maintenance = ref.read(turnkeyProvider).maintenanceMonthly;
    if(maintenance != 0) {
      maintenanceController.text = kCurrencyFormat.format(maintenance);
    }
    double other = ref.read(turnkeyProvider).otherExpensesMonthly;
    if(other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalMonthlyIncome = ref.watch(turnkeyProvider).totalIncome;
    double totalMonthlyExpenses =
        ref.watch(turnkeyProvider).totalMonthlyExpenses;
    double noiMonthly = totalMonthlyIncome - totalMonthlyExpenses;

    double debtService = ref.watch(turnkeyProvider).calculateMonthlyPayment(
      rate: ref.watch(turnkeyProvider).interestRate / 12,
      nper: ref.watch(turnkeyProvider).term * 12,
      pv: -1 * ref.watch(turnkeyProvider).loanAmount,
    );

    double cashFlow = noiMonthly - debtService;
    double yearlyCashFlow = cashFlow * 12;
    TurnkeyRental provider = ref.read(turnkeyProvider);
    double cashOnCash = yearlyCashFlow / (provider.downPaymentAmount + provider.constructionDownPaymentAmount + provider.closingCosts) * 100;
    double dscr = noiMonthly / debtService;
    double onePercentRule = provider.rent / provider.purchasePrice * 100;

    String incomeString = kCurrencyFormat.format(totalMonthlyIncome);
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
        MoneyListTile('Income', incomeString),
        ExpansionTile(
          leading: Text('Expenses', style: Theme.of(context).textTheme.headline6,),
            title: Text('\$ $expensesString', style: Theme.of(context).textTheme.headline5,),
            children: [
              MoneyTextField(
                labelText: 'Taxes',
                controller: taxesController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? taxes = double.tryParse(newValue);
                  if (taxes != null) {
                    ref.read(turnkeyProvider).updateTaxesMonthly(taxes);
                  } else {
                    ref.read(turnkeyProvider).updateTaxesMonthly(0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
                },
              ),
              MoneyTextField(
                labelText: 'Insurance',
                controller: insuranceController,
                onChanged: (String newValue) {
                  newValue = newValue.replaceAll(',', '');
                  double? insurance = double.tryParse(newValue);
                  if (insurance != null) {
                    ref.read(turnkeyProvider).updateInsuranceMonthly(insurance);
                  } else {
                    ref.read(turnkeyProvider).updateInsuranceMonthly(0.0);
                  }
                  ref.read(turnkeyProvider).calculateAllExpenses();
                },
              ),
              MoneyTextField(
                  labelText: 'Property Management',
                  controller: propertyManagementController,
                  onChanged: (String newValue) {
                    double? value = double.tryParse(newValue);
                    if (value != null) {
                      ref.read(turnkeyProvider).updatePropertyManagementMonthly(value);
                    } else {
                      ref.read(turnkeyProvider).updatePropertyManagementMonthly(0.0);
                    }
                    ref.read(turnkeyProvider).calculateAllExpenses();
                  }),
              MoneyTextField(
                  labelText: 'Vacancy',
                  controller: vacancyController,
                  onChanged: (String newValue) {
                    double? value = double.tryParse(newValue);
                    if (value != null) {
                      ref.read(turnkeyProvider).updateVacancyMonthly(value);
                    } else {
                      ref.read(turnkeyProvider).updateVacancyMonthly(0.0);
                    }
                    ref.read(turnkeyProvider).calculateAllExpenses();
                  }),
              MoneyTextField(
                  labelText: 'Maintenance',
                  controller: maintenanceController,
                  onChanged: (String newValue) {
                    double? value = double.tryParse(newValue);
                    if (value != null) {
                      ref.read(turnkeyProvider).updateMaintenanceMonthly(value);
                    } else {
                      ref.read(turnkeyProvider).updateMaintenanceMonthly(0.0);
                    }
                    ref.read(turnkeyProvider).calculateAllExpenses();
                  }),
              MoneyTextField(
                  labelText: 'Other',
                  controller: otherController,
                  onChanged: (String newValue) {
                    double? value = double.tryParse(newValue);
                    if (value != null) {
                      ref.read(turnkeyProvider).updateOtherMonthly(value);
                    } else {
                      ref.read(turnkeyProvider).updateOtherMonthly(0.0);
                    }
                    ref.read(turnkeyProvider).calculateAllExpenses();
                  }),
            ],
        ),
        MoneyListTile('NOI', noiString),
        MoneyListTile('Debt Service', debtServiceString),
        MoneyListTile('Cashflow', cashFlowString),
        MoneyListTile((MediaQuery.of(context).size.width < 640)
            ? 'Yearly\nCashflow'
            : 'Yearly Cashflow', yearlyCashFlowString),
        Text('Initial Purchase Metrics', style: Theme.of(context).textTheme.headline5),
        const Divider(),
        PercentListTile((MediaQuery.of(context).size.width < 640)
            ? 'Cash on\nCash Return'
            : 'Cash on Cash Return', cashOnCashReturnString),
        NumericalListTile('Debt Service\n Coverage Ratio', dscrString),
        PercentListTile('1% Rule', onePercentRuleString),
        const SizedBox(height: 32),
      ],
    );
  }
}
