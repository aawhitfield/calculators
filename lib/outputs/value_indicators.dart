import 'package:calculators/providers.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValueIndicators extends ConsumerWidget {
  const ValueIndicators({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double purchasePrice = ref.read(brrrrProvider).purchasePrice;
    double closingCosts = ref.read(brrrrProvider).closingCosts;
    double totalMoneyToBuy = purchasePrice + closingCosts;

    int monthsToRehab = ref.read(brrrrProvider).monthsToRehabRent;
    double totalDebtServicePayments = ref.read(brrrrProvider).monthlyPayment
        + ref.read(brrrrProvider).sellerMonthlyPayment +
        ref.read(brrrrProvider).constructionMonthlyPayment;
    double totalDebtService = monthsToRehab * totalDebtServicePayments;

    double totalMonthlyExpenses = ref.read(brrrrProvider).totalMonthlyExpenses;
    double totalHoldingExpenses = monthsToRehab * totalMonthlyExpenses;

    double totalMoneyToHold = totalDebtService + totalHoldingExpenses;

    double totalMoneyToRehab = ref.read(brrrrProvider).totalRenovations;

    double totalMoneyToSell = ref.read(fixFlipProvider).totalClosingCosts;

    double afterRepairValue = ref.read(brrrrProvider).afterRepairValue;
    double totalProfit = afterRepairValue - totalMoneyToBuy - totalMoneyToHold
        - totalMoneyToRehab - totalMoneyToSell;

    int numberOfInvestors = ref.read(brrrrProvider).investors;
    double profitPerInvestor = totalProfit / numberOfInvestors;

    double totalDownPayment = ref.watch(brrrrProvider).downPaymentAmount -
        ref.watch(brrrrProvider).sellerLoanAmount;

    double constructionDownPayment =
        ref.watch(brrrrProvider).constructionDownPaymentAmount;

    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double costPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;

    double cashOnCashReturn = profitPerInvestor / costPerInvestor * 100;

    String cashOnCashString = cashOnCashReturn.toStringAsFixed(2);


    return Column(
      children: [
        const ReportHeader('Value Indicators'),
        const SizedBox(height: 16),
        ListTile(
          leading: Text('Cash on\nCash Return', style: Theme.of(context).textTheme.headline6,),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(cashOnCashString, style: Theme.of(context).textTheme.headline6,),
              ),
                const SizedBox(width: 8),
                const Text('%', style: TextStyle(fontWeight: FontWeight.w700),),
            ],
          ),
        )
      ],
    );
  }
}
