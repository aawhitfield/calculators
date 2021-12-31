import 'package:calculators/globals.dart';
import 'package:calculators/inputs/holding_costs.dart';
import 'package:calculators/models/refinance.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RefinanceInput extends ConsumerStatefulWidget {
  const RefinanceInput({Key? key}) : super(key: key);

  @override
  _RefinanceInputState createState() => _RefinanceInputState();
}

class _RefinanceInputState extends ConsumerState<RefinanceInput> {

  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(brrrrProvider).refinancingLoanToValue * 100;
    if(loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(brrrrProvider).refinancingInterestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(brrrrProvider).refinancingTerm;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    double closingCosts = ref.read(brrrrProvider).refinancingClosingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Refinancing refinancingMethod =
        ref.watch(brrrrProvider).refinancingType;

    double loanAmount = ref.watch(brrrrProvider).afterRepairValue *
        ref.watch(brrrrProvider).refinancingLoanToValue;

    double downPaymentAmount =
        ref.watch(brrrrProvider).afterRepairValue - loanAmount;

    double monthlyPayment = ref.watch(brrrrProvider).refinancingMonthlyPayment;

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
      imageUri: 'images/refinance.svg',
      headerText: 'Refinance Options',
      subheadText: '',
      onSubmit: () {
        ref.read(brrrrProvider).updateMonthlyPayment(monthlyPayment);
        Get.to(() => const HoldingCosts());
      },
      position: kBRRRRQuestions.indexOf(RefinanceInput) + 1,
      totalQuestions: kBRRRRQuestions.length,
      child: ResponsiveLayout(
        children: [
          Row(
            children: [
              const Text('Financing Type'),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<Refinancing>(
                  value: refinancingMethod,
                  items: Refinancing.values
                      .map((Refinancing refinancingMethod) =>
                          DropdownMenuItem<Refinancing>(
                              value: refinancingMethod,
                              child: Text(
                                  RefinancingUtils(refinancingMethod).name)))
                      .toList(),
                  onChanged: (Refinancing? newValue) {
                    ref.read(brrrrProvider).updateRefinancingType(newValue!);
                  },
                ),
              )
            ],
          ),
          PercentTextField(
            labelText: 'Loan to Value',
            controller: loanPercentController,
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double loanPercentage = newValue / 100;
                ref
                    .read(brrrrProvider)
                    .updateRefinancingLoanToValue(loanPercentage);
                double afterRepairValue =
                    ref.read(brrrrProvider).afterRepairValue;
                double loanAmount = afterRepairValue * loanPercentage;

                ref.read(brrrrProvider).updateRefinancingLoanAmount(loanAmount);

                double downPayment = afterRepairValue - loanAmount;
                ref.read(brrrrProvider).updateRefinancingDownPayment(downPayment);
              }
              else {
                ref.read(brrrrProvider).updateRefinancingLoanToValue(0.0);
              }
              ref.read(brrrrProvider).calculateAllRefinanceCalculations();
            },
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Loan\nAmount'
                  : 'Loan Amount',
              loanAmountString),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Down\nPayment'
                  : 'Down Payment',
              downPaymentString),
          PercentTextField(
            labelText: 'Interest Rate',
            controller: interestRateController,
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double interestRate = newValue / 100;
                ref.read(brrrrProvider).updateRefinancingInterestRate(interestRate);
              }
              else {
                ref.read(brrrrProvider).updateRefinancingInterestRate(0.0);
              }
              ref.read(brrrrProvider).calculateAllRefinanceCalculations();
            },
          ),
          IntegerTextField(
            labelText: 'Term',
            controller: termController,
            leftPadding: 8,
            rightPadding: 8,
            onChanged: (String newTerm) {
              newTerm = newTerm.replaceAll(',', '');
              int? newValue = int.tryParse(newTerm);
              if (newValue != null) {
                ref.read(brrrrProvider).updateRefinancingTerm(newValue);
              }
              else {
                ref.read(brrrrProvider).updateRefinancingTerm(0);
              }
              ref.read(brrrrProvider).calculateAllRefinanceCalculations();
            },
          ),
          MoneyTextField(
            labelText: 'Closing Costs',
            controller: closingCostsController,
            onChanged: (String newCost) {
              newCost = newCost.replaceAll(',', '');
              double? newValue = double.tryParse(newCost);
              if (newValue != null) {
                ref.read(brrrrProvider).updateRefinancingClosingCosts(newValue);
              }
              else {
                ref.read(brrrrProvider).updateRefinancingClosingCosts(0.0);
              }
              ref.read(brrrrProvider).calculateAllRefinanceCalculations();
            },
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Monthly\nPayment':'Monthly Payment', monthlyPaymentString),
        ],
      ),
    );
  }
}
