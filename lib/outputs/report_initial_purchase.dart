import 'package:calculators/globals.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportInitialPurchase extends ConsumerStatefulWidget {
  const ReportInitialPurchase({
    Key? key,
  }) : super(key: key);

  @override
  _ReportInitialPurchaseState createState() => _ReportInitialPurchaseState();
}

class _ReportInitialPurchaseState extends ConsumerState<ReportInitialPurchase> {
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController constructionAmountController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();

  @override
  void initState() {
    double purchasePrice = ref.read(brrrrProvider).purchasePrice;
    if (purchasePrice != 0) {
      purchasePriceController.text = kCurrencyFormat.format(purchasePrice);
    }
    double constructionAmount = ref.read(brrrrProvider).totalRenovations;
    if (constructionAmount != 0) {
      constructionAmountController.text =
          kCurrencyFormat.format(constructionAmount);
    }
    double closingCosts = ref.read(brrrrProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double loanAmount = ref.watch(brrrrProvider).loanAmount;
    double totalDownPayment = ref.watch(brrrrProvider).purchasePrice -
        ref.watch(brrrrProvider).loanAmount;
    double constructionDownPayment =
        ref.watch(brrrrProvider).constructionDownPaymentAmount;

    double closingCosts = ref.watch(brrrrProvider).closingCosts;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double costPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String loanDownPaymentString = kCurrencyFormat.format(totalDownPayment);
    String constructionDownPaymentString =
        kCurrencyFormat.format(constructionDownPayment);
    String closingCostsString = kCurrencyFormat.format(closingCosts);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String costPerInvestorString = kCurrencyFormat.format(costPerInvestor);

    return Column(
      children: [
        const ReportHeader('Initial Purchase'),
        const SizedBox(height: 16),
        MoneyTextField(
            labelText: 'Purchase Price',
            controller: purchasePriceController,
            onChanged: (String newPrice) {
              newPrice = newPrice.replaceAll(',', '');
              double? price = double.tryParse(newPrice);
              if (price != null) {
                ref.read(brrrrProvider).updatePurchasePrice(price);
              } else {
                ref.read(brrrrProvider).updatePurchasePrice(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Loan\nAmount'
                : 'Loan Amount',
            loanAmountString),
        MoneyListTile(
          (MediaQuery.of(context).size.width < 640)
              ? 'Loan\nDP'
              : 'Loan \nDown Payment',
          loanDownPaymentString,
          subtitle: 'Down Payment',
        ),
        MoneyTextField(
            labelText: 'Construction Amount',
            controller: constructionAmountController,
            onChanged: (String newPrice) {
              newPrice = newPrice.replaceAll(',', '');
              double? price = double.tryParse(newPrice);
              if (price != null) {
                ref.read(brrrrProvider).updateTotalRenovations(price);
              } else {
                ref.read(brrrrProvider).updateTotalRenovations(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile(
          (MediaQuery.of(context).size.width < 640)
              ? 'Construct\nDP'
              : 'Construction \nDown Payment',
          constructionDownPaymentString,
          subtitle: 'Construction Down Payment',
        ),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Closing\nCosts'
                : 'Closing Costs',
            closingCostsString),
        MoneyTextField(
            labelText: 'Closing Costs',
            controller: closingCostsController,
            onChanged: (String newPrice) {
              newPrice = newPrice.replaceAll(',', '');
              double? price = double.tryParse(newPrice);
              if (price != null) {
                ref.read(brrrrProvider).updateClosingCosts(price);
              } else {
                ref.read(brrrrProvider).updateClosingCosts(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyTextField(
            labelText: 'Rehab',
            controller: constructionAmountController,
            onChanged: (String newPrice) {
              newPrice = newPrice.replaceAll(',', '');
              double? price = double.tryParse(newPrice);
              if (price != null) {
                ref.read(brrrrProvider).updateTotalRenovations(price);
              } else {
                ref.read(brrrrProvider).updateTotalRenovations(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Initial\nCash'
                : 'Initial \nCash Investment',
            initialCashInvestmentString),
        (ref.read(brrrrProvider).investors > 1)
            ? MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Cost per\ninvestor'
                    : 'Cost per investor',
                costPerInvestorString)
            : Container(),
      ],
    );
  }
}
