import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
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
    double totalAnnualIncome = totalMonthlyIncome * 12;
    double totalMonthlyExpenses =
        ref.watch(brrrrProvider).totalMonthlyExpenses;
    double totalAnnualExpenses =
        ref.watch(brrrrProvider).totalAnnualExpenses;
    double noiMonthly = totalMonthlyIncome - totalMonthlyExpenses;
    double noiAnnually = totalAnnualIncome - totalAnnualExpenses;

    double totalDebtServicePayments =
        ref.watch(financeProvider).monthlyPayment +
            ref.watch(financeConstructionProvider).monthlyPayment +
            ref.watch(sellerFinanceProvider).monthlyPayment;

    double netCashFlowMonthly = noiMonthly - totalDebtServicePayments;
    double netCashFlowAnnually = noiAnnually - totalDebtServicePayments * 12;

    bool cashFlowIsPositive =
        (netCashFlowMonthly > 0 && netCashFlowAnnually > 0);
    bool cashFlowIsNegative =
        (netCashFlowMonthly < 0 || netCashFlowAnnually < 0);

    return Column(
      children: [
        const ReportHeader('Cash Flow Statement'),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.all(),
          children: [
            const TableRow(
              children: [
                Text(''),
                Center(child: Text('Monthly')),
                Center(child: Text('Annually')),
              ],
            ),
            TableRow(
              children: [
                const Text('Income'),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(totalMonthlyIncome))),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(totalAnnualIncome))),
              ],
            ),
            TableRow(
              children: [
                const Text('Expenses'),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(totalMonthlyExpenses))),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(totalAnnualExpenses))),
              ],
            ),
            TableRow(
              children: [
                const Text('NOI'),
                Center(child: Text('\$ ' + kCurrencyFormat.format(noiMonthly))),
                Center(
                    child: Text('\$ ' + kCurrencyFormat.format(noiAnnually))),
              ],
            ),
            TableRow(
              children: [
                const Text('Debt Service'),
                Center(
                    child: Text('\$ ' +
                        kCurrencyFormat.format(totalDebtServicePayments))),
                Center(
                    child: Text('\$ ' +
                        kCurrencyFormat.format(totalDebtServicePayments * 12))),
              ],
            ),
            const TableRow(
              children: [
                Text(''),
                Text(''),
                Text(''),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: (cashFlowIsPositive)
                    ? Colors.green.withOpacity(0.6)
                    : (cashFlowIsNegative)
                        ? Colors.red.withOpacity(0.6)
                        : Colors.transparent,
              ),
              children: [
                const Text(
                  'Net Cash Flow',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(netCashFlowMonthly))),
                Center(
                    child: Text(
                        '\$ ' + kCurrencyFormat.format(netCashFlowAnnually))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
