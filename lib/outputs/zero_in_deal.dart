import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
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
    double arvLoan = ref.watch(brrrrProvider).refinancingLoanAmount;
    double totalLoans = ref.watch(brrrrProvider).loanAmount +
        ref.watch(brrrrProvider).constructionLoanAmount +
        ref.watch(brrrrProvider).sellerLoanAmount;

    double totalDownPayment = ref.watch(brrrrProvider).downPaymentAmount -
        ref.watch(brrrrProvider).sellerLoanAmount;

    double constructionDownPayment =
        ref.watch(brrrrProvider).constructionDownPaymentAmount;
    double closingCosts = ref.watch(brrrrProvider).closingCosts;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double initialCashPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;
    double equity = arvLoan - totalLoans;
    BRRRR provider = ref.read(brrrrProvider);
    double holdingCost = provider.totalHoldingCosts;
    double afterRefinance = arvLoan - totalLoans - initialCashInvestment - holdingCost;

    String arvLoanString = kCurrencyFormat.format(arvLoan);
    String totalLoansString = kCurrencyFormat.format(totalLoans);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String initialCashPerInvestorString =
        kCurrencyFormat.format(initialCashPerInvestor);
    String equityString = kCurrencyFormat.format(equity);
    String afterRefinanceString = kCurrencyFormat.format(afterRefinance);
    String holdingCostString = kCurrencyFormat.format(holdingCost);

    return Column(
      children: [
        const ReportHeader('Refinance 0 in Deal?'),
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
        MoneyListTile((MediaQuery.of(context).size.width < 640)
            ? 'Holding\ncost'
            : 'Holding Cost',
            holdingCostString),
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
                    : 'After refinance \n0 IN',
                afterRefinanceString,
              subtitle: (MediaQuery.of(context).size.width < 640)
                ? '0 IN' : '',
            ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
