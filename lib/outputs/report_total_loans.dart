import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportTotalLoans extends ConsumerWidget {
  const ReportTotalLoans({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalLoans = ref.watch(brrrrProvider).loanAmount +
        ref.watch(financeConstructionProvider).loanAmount +
        ref.watch(sellerFinanceProvider).loanAmount;

    double totalDebtServicePayments =
        ref.watch(brrrrProvider).monthlyPayment +
            ref.watch(financeConstructionProvider).monthlyPayment +
            ref.watch(sellerFinanceProvider).monthlyPayment;

    String totalLoansString = kCurrencyFormat.format(totalLoans);
    String totalDebtServiceString =
        kCurrencyFormat.format(totalDebtServicePayments);

    return Column(
      children: [
        const ReportHeader('Totals'),
        const SizedBox(height: 16),
        MoneyListTile('Total Loans', totalLoansString),
        MoneyListTile('Total Debt Service Payments', totalDebtServiceString),
        const SizedBox(height: 16),
      ],
    );
  }
}
