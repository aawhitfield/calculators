import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TurnkeyReportInitialPurchase extends ConsumerWidget {
  const TurnkeyReportInitialPurchase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalDownPayment = ref.watch(turnkeyProvider).purchasePrice -
        ref.watch(turnkeyProvider).loanAmount;
    double constructionDownPayment =
        ref.watch(turnkeyProvider).constructionDownPaymentAmount;

    double closingCosts = ref.watch(turnkeyProvider).closingCosts;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double costPerInvestor =
        initialCashInvestment / ref.watch(turnkeyProvider).investors;

    String loanDownPaymentString = kCurrencyFormat.format(totalDownPayment);
    String closingCostsString = kCurrencyFormat.format(closingCosts);
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
            loanDownPaymentString,
        subtitle: 'Down Payment',
        ),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Closing\nCosts'
                : 'Closing Costs',
            closingCostsString),
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
