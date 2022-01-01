import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/numerical_list_tile.dart';
import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashFlowStatement extends ConsumerWidget {
  const CashFlowStatement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalMonthlyIncome = ref.watch(brrrrProvider).totalIncome;
    double totalMonthlyExpenses =
        ref.watch(brrrrProvider).totalMonthlyExpenses;
    double noiMonthly = totalMonthlyIncome - totalMonthlyExpenses;

    double debtService = ref.read(brrrrProvider).debtService / ref.read(brrrrProvider).monthsToRehabRent;
    double cashFlow = noiMonthly - debtService;
    double yearlyCashFlow = cashFlow * 12;
    BRRRR provider = ref.read(brrrrProvider);
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
        const ReportHeader('Cash Flow Statement'),
        const SizedBox(height: 16),
        MoneyListTile('Income', incomeString),
        MoneyListTile('Expenses', expensesString),
        MoneyListTile('NOI', noiString),
        MoneyListTile('Debt Service', debtServiceString),
        MoneyListTile('Cashflow', cashFlowString),
        MoneyListTile('Yearly Cashflow', yearlyCashFlowString),
        Text('Initial Purchase Metrics', style: Theme.of(context).textTheme.headline5),
        const Divider(),
        PercentListTile('Cash on Cash Return', cashOnCashReturnString),
        NumericalListTile('Debt Service\n Coverage Ratio', dscrString),
        PercentListTile('1% Rule', onePercentRuleString),
        const SizedBox(height: 32),
      ],
    );
  }
}
