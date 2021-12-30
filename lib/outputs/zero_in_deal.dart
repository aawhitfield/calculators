import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ZeroInDeal extends ConsumerWidget {
  const ZeroInDeal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double arvLoan = ref.watch(refinanceProvider).loanAmount;
    double totalLoans = ref.watch(brrrrProvider).loanAmount +
        ref.watch(financeConstructionProvider).loanAmount +
        ref.watch(sellerFinanceProvider).loanAmount;

    double totalDownPayment = ref.watch(brrrrProvider).downPaymentAmount -
        ref.watch(sellerFinanceProvider).loanAmount;

    double constructionDownPayment =
        ref.watch(financeConstructionProvider).downPaymentAmount;
    double closingCosts = ref.watch(brrrrProvider).closingCosts;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double initialCashPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;
    double afterRepairValue = ref.watch(brrrrProvider).afterRepairValue;
    double equity = afterRepairValue - arvLoan;
    double afterRefinance = arvLoan - totalLoans - initialCashInvestment;

    String arvLoanString = kCurrencyFormat.format(arvLoan);
    String totalLoansString = kCurrencyFormat.format(totalLoans);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String initialCashPerInvestorString =
        kCurrencyFormat.format(initialCashPerInvestor);
    String equityString = kCurrencyFormat.format(equity);
    String afterRefinanceString = kCurrencyFormat.format(afterRefinance);

    return Column(
      children: [
        const ReportHeader('0 in Deal?'),
        const SizedBox(height: 16),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'ARV\nLoan'
                : 'ARV Loan',
            arvLoanString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Original\nAmount'
                : 'Original \nLoan Amount',
            totalLoansString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Initial\ncash'
                : 'Initial \nCash Investment',
            initialCashInvestmentString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Per\nInvestor'
                : 'Initial Cash \nPer Investor',
            initialCashPerInvestorString),
        MoneyListTile('Equity', equityString),
        Container(
            color: (afterRefinance > 0)
                ? Colors.green.withOpacity(0.5)
                : (afterRefinance < 0)
                    ? Colors.red.withOpacity(0.5)
                    : Colors.transparent,
            child: MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'After\nrefinance'
                    : 'After refinance \n0 in deal?',
                afterRefinanceString)),
        const SizedBox(height: 16),
      ],
    );
  }
}
