import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/outputs/colored_percent_list_tile.dart';
import 'package:calculators/outputs/expenses_expansion_tile.dart';
import 'package:calculators/outputs/income_expansion_tile.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/colored_money_list_tile.dart';
import 'package:calculators/widgets/money_list_tile.dart';
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
        const IncomeExpansionTile(),
        const ExpensesExpansionTile(),
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
