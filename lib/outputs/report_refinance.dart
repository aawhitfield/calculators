import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/widgets/colored_money_list_tile.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportRefinance extends ConsumerStatefulWidget {
  const ReportRefinance({
    Key? key,
  }) : super(key: key);

  @override
  _ReportRefinanceState createState() => _ReportRefinanceState();
}

class _ReportRefinanceState extends ConsumerState<ReportRefinance> {
  TextEditingController arvController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();

  late double arv;
  late double refinanceClosingCosts;

  @override
  void initState() {
    arv = ref.read(brrrrProvider).afterRepairValue;
    if(arv != 0) {
      arvController.text = kCurrencyFormat.format(arv);
    }
    refinanceClosingCosts = ref.read(brrrrProvider).refinancingClosingCosts;
    if(refinanceClosingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(refinanceClosingCosts);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double arvLoan = ref.watch(brrrrProvider).refinancingLoanAmount;
    double originalAmount = ref.watch(brrrrProvider).loanAmount +
        ref.watch(brrrrProvider).sellerLoanAmount;
    double originalConstruction =
        ref.watch(brrrrProvider).constructionLoanAmount;

    double totalDownPayment = ref.watch(brrrrProvider).downPaymentAmount -
        ref.watch(brrrrProvider).sellerLoanAmount;
    double constructionDownPayment =
        ref.watch(brrrrProvider).constructionDownPaymentAmount;
    double closingCosts = ref.watch(brrrrProvider).closingCosts;
    double refinanceClosingCosts =
        ref.watch(brrrrProvider).refinancingClosingCosts;
    double initialCashInvestment =
        totalDownPayment + constructionDownPayment + closingCosts;
    double initialCashPerInvestor =
        initialCashInvestment / ref.watch(brrrrProvider).investors;
    double equity = arvLoan - originalAmount;
    BRRRR provider = ref.read(brrrrProvider);
    double holdingCost = provider.totalHoldingCosts;
    double afterRefinance = arvLoan -
        originalAmount -
        closingCosts -
        originalConstruction -
        refinanceClosingCosts -
        holdingCost;
    int investors = ref.read(brrrrProvider).investors;
    double perInvestorAfterRefinance =
        (investors != 0) ? afterRefinance / investors : 0;

    String arvLoanString = kCurrencyFormat.format(arvLoan);
    String originalAmountString = kCurrencyFormat.format(originalAmount);
    String originalConstructionString =
        kCurrencyFormat.format(originalConstruction);
    String refinanceClosingCostsString =
        kCurrencyFormat.format(refinanceClosingCosts);
    String initialCashInvestmentString =
        kCurrencyFormat.format(initialCashInvestment);
    String initialCashPerInvestorString =
        kCurrencyFormat.format(initialCashPerInvestor);
    String equityString = kCurrencyFormat.format(equity);
    String afterRefinanceString = kCurrencyFormat.format(afterRefinance);
    String holdingCostString = kCurrencyFormat.format(holdingCost);
    String perInvestorAfterRefinanceString =
        kCurrencyFormat.format(perInvestorAfterRefinance);

    return Column(
      children: [
        const ReportHeader('Refinance'),
        const SizedBox(height: 16),
        MoneyTextField(
            controller: arvController,
            labelText: 'ARV', onChanged: (String newValue) {
          double? value = double.tryParse(newValue);
          if (value != null) {
            ref.read(brrrrProvider).updateAfterRepairValue(value);
          } else {
            ref.read(brrrrProvider).updateAfterRepairValue(0.0);
          }
          ref.read(brrrrProvider).calculateAll();
        }),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'ARV\nLoan'
                : 'ARV Loan',
            arvLoanString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Original\nAmount'
                : 'Original \nLoan Amount',
            originalAmountString),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Original\nConstruction'
                : 'Original \nConstruction Amount',
            originalConstructionString),
        MoneyTextField(
            controller: closingCostsController,
            labelText: 'Closing Costs',
            onChanged: (String newValue) {
              double? value = double.tryParse(newValue);
              if (value != null) {
                ref.read(brrrrProvider).updateRefinancingClosingCosts(value);
              } else {
                ref.read(brrrrProvider).updateRefinancingClosingCosts(0.0);
              }
              ref.read(brrrrProvider).calculateAll();
            }),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Initial\ncash'
                : 'Initial \nCash Investment',
            initialCashInvestmentString),
        MoneyListTile(
          (MediaQuery.of(context).size.width < 640)
              ? 'Per\nInvestor'
              : 'Initial Cash \nPer Investor',
          initialCashPerInvestorString,
        ),
        MoneyListTile(
          (MediaQuery.of(context).size.width < 640)
              ? 'Closing\nCosts'
              : 'Closing Costs',
          refinanceClosingCostsString,
          subtitle: 'Refinance',
        ),
        MoneyListTile(
            (MediaQuery.of(context).size.width < 640)
                ? 'Holding\ncost'
                : 'Holding Cost',
            holdingCostString),
        MoneyListTile('Equity', equityString),
        ColoredMoneyListTile(
          value: afterRefinance,
          smallScreenTitle: 'After\nrefinance',
          largeScreenTitle: 'After refinance \n0 IN',
          valueString: afterRefinanceString,
          subtitle: (MediaQuery.of(context).size.width < 640) ? '0 IN' : '',
        ),
        ColoredMoneyListTile(
            value: perInvestorAfterRefinance,
            smallScreenTitle: 'Per\nInvestor',
            largeScreenTitle: 'Per Investor', valueString: perInvestorAfterRefinanceString,
            subtitle: 'After Refinance 0 IN',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
