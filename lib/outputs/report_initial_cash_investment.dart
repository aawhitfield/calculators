import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportInitialCashInvestment extends ConsumerWidget {
  const ReportInitialCashInvestment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalDownPayment = ref.watch(brrrrProvider).purchasePrice -
        ref.watch(brrrrProvider).loanAmount;

    double constructionDownPayment =
        ref.watch(brrrrProvider).constructionDownPaymentAmount;

    double closingCosts = ref.watch(brrrrProvider).closingCosts;
    double rehab = ref.watch(brrrrProvider).totalRenovations;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double costPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;

    String loanDownPaymentString = kCurrencyFormat.format(totalDownPayment);
    String constructionDownPaymentString =
        kCurrencyFormat.format(constructionDownPayment);
    String closingCostsString = kCurrencyFormat.format(closingCosts);
    String rehabString = kCurrencyFormat.format(rehab);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String costPerInvestorString = kCurrencyFormat.format(costPerInvestor);

    return Column(
      children: [
        const ReportHeader('Initial Purchase'),
        const SizedBox(height: 16),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Loan\nDP'
                : 'Loan \nDown Payment',
            loanDownPaymentString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Construct\nDP'
                : 'Construction \nDown Payment',
            constructionDownPaymentString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Closing\nCosts'
                : 'Closing Costs',
            closingCostsString),
        MoneyListTile('Rehab', rehabString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Initial\nCash'
                : 'Initial \nCash Investment',
            initialCashInvestmentString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Cost per\ninvestor'
                : 'Cost per investor',
            costPerInvestorString),
      ],
    );
  }
}
