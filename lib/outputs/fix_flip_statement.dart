import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
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

    double breakEvenSellPrice = totalMoneyToBuy + totalMoneyToHold
      + totalMoneyToRehab + totalMoneyToSell;

    String moneyToBuyString = kCurrencyFormat.format(totalMoneyToBuy);
    String moneyToHoldString = kCurrencyFormat.format(totalMoneyToHold);
    String moneyToRehabString = kCurrencyFormat.format(totalMoneyToRehab);
    String moneyToSellString = kCurrencyFormat.format(totalMoneyToSell);
    String totalProfitString = kCurrencyFormat.format(totalProfit);
    String profitPerInvestorString = kCurrencyFormat.format(profitPerInvestor);
    String breakEvenString = kCurrencyFormat.format(breakEvenSellPrice);

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
        }
        else {
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
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Total\nProfit'
                    : 'Total Profit',
                totalProfitString),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Profit per\ninvestor'
                    : 'Profit per investor',
                profitPerInvestorString),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Break\nEven'
                    : 'Break Even Sell Price',
                breakEvenString),
          ],
      ),
    );
  }
}
