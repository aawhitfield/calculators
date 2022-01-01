import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
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

    String incomeString = kCurrencyFormat.format(totalMonthlyIncome);
    String expensesString = kCurrencyFormat.format(totalMonthlyExpenses);
    String noiString = kCurrencyFormat.format(noiMonthly);
    String debtServiceString = kCurrencyFormat.format(debtService);
    String cashFlowString = kCurrencyFormat.format(cashFlow);
    String yearlyCashFlowString = kCurrencyFormat.format(yearlyCashFlow);

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
        const SizedBox(height: 32),
      ],
    );
  }
}
