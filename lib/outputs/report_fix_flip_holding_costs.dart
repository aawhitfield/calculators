import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FixFlipHoldingCosts extends ConsumerWidget {
  const FixFlipHoldingCosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    int monthsToRehab = ref.read(brrrrProvider).monthsToRehabRent;
    double totalDebtServicePayments = ref.read(financeProvider).monthlyPayment
      + ref.read(sellerFinanceProvider).monthlyPayment +
        ref.read(financeConstructionProvider).monthlyPayment;
    double totalDebtService = monthsToRehab * totalDebtServicePayments;

    double totalMonthlyExpenses = ref.read(expensesProvider).totalMonthlyExpenses;
    double totalHoldingExpenses = monthsToRehab * totalMonthlyExpenses;

    double totalHoldingCosts = totalDebtService + totalHoldingExpenses;

    String debtServiceString = kCurrencyFormat.format(totalDebtService);
    String holdingExpensesString =
        kCurrencyFormat.format(totalHoldingExpenses);
    String holdingCostsString = kCurrencyFormat.format(totalHoldingCosts);

    return Column(
      children: [
        const ReportHeader('Holding Costs'),
        const SizedBox(height: 16),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Debt\nService'
                : 'Total \nDebt Service',
            debtServiceString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Holding\nExpenses'
                : 'Total \nHolding Expenses',
            holdingExpensesString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Holding\nCosts'
                : 'Total \nHolding Costs',
            holdingCostsString),
      ],
    );
  }
}
