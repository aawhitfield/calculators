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
    double totalDownPayment = ref.watch(financeProvider).downPaymentAmount -
        ref.watch(sellerFinanceProvider).loanAmount;

    double constructionDownPayment =
        ref.watch(financeConstructionProvider).downPaymentAmount;

    double closingCosts = ref.watch(financeProvider).closingCosts;
    double rehab = ref.watch(renovationsProvider).total;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double costPerInvestor =
        initialCashInvestment / ref.watch(propertyProvider).investors;

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
        const ReportHeader('Initial Cash Investment'),
        const SizedBox(height: 16),
        MoneyListTile('Loan Down Payment', loanDownPaymentString),
        MoneyListTile(
            'Construction Down Payment', constructionDownPaymentString),
        MoneyListTile('Closing Costs', closingCostsString),
        MoneyListTile('Rehab', rehabString),
        MoneyListTile('Initial Cash Investment', initialCashInvestmentString),
        MoneyListTile('Cost per investor', costPerInvestorString),
      ],
    );
  }
}
