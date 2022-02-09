import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/colored_money_list_tile.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipStatement extends ConsumerWidget {
  const FixFlipStatement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double loanDownPayment = ref.watch(fixFlipProvider).downPaymentAmount;
    double constructionDownPayment =
        ref.watch(fixFlipProvider).constructionDownPaymentAmount;

    double purchasePrice = ref.read(fixFlipProvider).purchasePrice;
    double closingCosts = ref.read(fixFlipProvider).closingCosts;
    double initialCashInvestment =
        loanDownPayment + constructionDownPayment + closingCosts;
    int investors = ref.read(fixFlipProvider).investors;
    double costPerInvestor = (investors != 0)
        ? initialCashInvestment / investors
        : initialCashInvestment;
    double totalMoneyToBuy = purchasePrice;
    double totalMoneyToHold = ref.read(fixFlipProvider).totalHoldingCosts;
    double totalMoneyToRehab = ref.read(fixFlipProvider).totalRenovations;
    double totalMoneyToSell = ref.read(fixFlipProvider).totalClosingCosts;
    double afterRepairValue = ref.read(fixFlipProvider).afterRepairValue;
    double totalProfit = afterRepairValue -
        totalMoneyToBuy -
        totalMoneyToHold -
        totalMoneyToRehab -
        totalMoneyToSell;

    int numberOfInvestors = ref.read(fixFlipProvider).investors;
    double profitPerInvestor = totalProfit / numberOfInvestors;

    double breakEvenSellPrice = totalMoneyToBuy +
        totalMoneyToHold +
        totalMoneyToRehab +
        totalMoneyToSell;
    double cashOnCashReturn =
        (costPerInvestor != 0) ? profitPerInvestor / costPerInvestor * 100 : 0;

    String loanDownPaymentString = kCurrencyFormat.format(loanDownPayment);
    String constructionDownPaymentString =
        kCurrencyFormat.format(constructionDownPayment);
    String closingCostsString = kCurrencyFormat.format(closingCosts);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String costPerInvestorString = kCurrencyFormat.format(costPerInvestor);
    String moneyToBuyString = kCurrencyFormat.format(totalMoneyToBuy);
    String moneyToHoldString = kCurrencyFormat.format(totalMoneyToHold);
    String moneyToRehabString = kCurrencyFormat.format(totalMoneyToRehab);
    String moneyToSellString = kCurrencyFormat.format(totalMoneyToSell);
    String totalProfitString = kCurrencyFormat.format(totalProfit);
    String profitPerInvestorString = kCurrencyFormat.format(profitPerInvestor);
    String breakEvenString = kCurrencyFormat.format(breakEvenSellPrice);
    String cashOnCashReturnString = cashOnCashReturn.toStringAsFixed(0);

    return MyInputPage(
      imageUri: 'images/report.svg',
      headerText: 'Report',
      subheadText: '',
      position: kFixFlipQuestions.indexOf(FixFlipStatement) + 1,
      totalQuestions: kFixFlipQuestions.length,
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const FixAndFlipSellingCostsInput());
        } else {
          Get.back();
        }
      },
      onSubmit: () {},
      child: ResponsiveLayout(
        children: [
          const ReportHeader('Fix and Flip'),
          const SizedBox(height: 16),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Loan\nDP'
                  : 'Loan Down\nPayment',
              loanDownPaymentString),
          MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Loan\nDP'
                : 'Construction\nDown Payment',
            constructionDownPaymentString,
            subtitle: 'Construction',
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Closing\nCosts'
                  : 'Closing Costs',
              closingCostsString),
          MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Initial\nCash'
                : 'Initial Cash Investment',
            initialCashInvestmentString,
            subtitle: 'Investment',
          ),
          (investors > 1)
              ? MoneyListTile(
                  (MediaQuery.of(context).size.width < 640)
                      ? 'Cost Per\nInvestor'
                      : 'Cost Per Investor',
                  costPerInvestorString,
                )
              : Container(),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Total\nto Buy'
                  : 'Total Money\nto Buy',
              moneyToBuyString),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Total\nto Hold'
                  : 'Total Money \nto Hold',
              moneyToHoldString),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Total\nto Rehab'
                  : 'Total Money \n to Rehab',
              moneyToRehabString),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Total\nto Sell'
                  : 'Total Money \n to Sell',
              moneyToSellString),
          ColoredMoneyListTile(
            largeScreenTitle: 'Total Profit',
            smallScreenTitle: 'Total\nProfit',
            valueString: totalProfitString,
            value: totalProfit,
          ),
          (investors > 1)
              ? MoneyListTile(
                  (MediaQuery.of(context).size.width < 640)
                      ? 'Profit per\ninvestor'
                      : 'Profit per investor',
                  profitPerInvestorString)
              : Container(),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Break\nEven'
                  : 'Break Even Sell Price',
              breakEvenString),
          PercentListTile('Cash on Cash Return', cashOnCashReturnString),
        ],
      ),
    );
  }
}
