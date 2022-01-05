import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_option_construction_loan.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/refinance_input.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'holding_costs.dart';

class FinanceOptions extends ConsumerStatefulWidget {
  const FinanceOptions({Key? key}) : super(key: key);

  @override
  _FinanceOptionsState createState() => _FinanceOptionsState();
}

class _FinanceOptionsState extends ConsumerState<FinanceOptions> {
  TextEditingController downPaymentPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(brrrrProvider).downPaymentPercent * 100;
    if(loanPercent != 0) {
      downPaymentPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(brrrrProvider).interestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(brrrrProvider).term;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    double closingCosts = ref.read(brrrrProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(brrrrProvider).financingType;

    double loanAmount = ref.watch(brrrrProvider).loanAmount;

    double downPaymentAmount = ref.watch(brrrrProvider).purchasePrice -
        loanAmount;

    double monthlyPayment = (ref.watch(brrrrProvider).paymentType ==
            PaymentType.principalAndInterest)
        ? ref.watch(brrrrProvider).calculateMonthlyPayment(
              rate: ref.watch(brrrrProvider).interestRate / 12,
              nper: ref.watch(brrrrProvider).term * 12,
              pv: -1 * loanAmount,
            )
        : ref.watch(brrrrProvider).calculateMonthlyPaymentInterestOnly(
              rate: ref.watch(brrrrProvider).interestRate / 12,
              nper: ref.watch(brrrrProvider).term,
              pv: -1 * loanAmount,
              per: 1,
            );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
      imageUri: 'images/finance.svg',
      headerText: 'Finance Options',
      subheadText: '',
      onSubmit: () {
        ref.read(brrrrProvider).updateMonthlyPayment(monthlyPayment);
        ref.read(brrrrProvider).updateDownPayment(downPaymentAmount);
        ref.read(brrrrProvider).updateLoanAmount(loanAmount);
        FinancingType financingType = ref.watch(brrrrProvider).financingType;
        if (financingType == FinancingType.hardMoneyWithConstruction ||
            financingType == FinancingType.commercialWithConstruction) {
          Get.to(() => const FinanceOptionConstructionLoan());
        } else if(financingType == FinancingType.sellerFinancing){
          Get.to(() => const FinanceOptionSellerFinanced());
        }
        else if(ref.read(brrrrProvider).wantsToRefinance) {
          Get.to(() => const RefinanceInput());
        }
        else {
          ref.read(brrrrProvider).calculateAllHoldingCosts();
          Get.to(() => const HoldingCosts());
        }
      },
      position: kBRRRRQuestions.indexOf(FinanceOptions) + 1,
      totalQuestions: kBRRRRQuestions.length,
      child: ResponsiveLayout(
        children: [
          (MediaQuery.of(context).size.width > 640)
              ? Row(
                  children: [
                    const Text('Financing Type'),
                    const SizedBox(width: 8),
                    Expanded(child: FinancingDropDown(value: value, ref: ref)),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Financing Type'),
                    const SizedBox(height: 8),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FinancingDropDown(value: value, ref: ref)),
                  ],
                ),
          PercentTextField(
            labelText: 'Down Payment Percent',
            controller: downPaymentPercentController,
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double downPaymentPercentage = newValue / 100;
                ref.read(brrrrProvider).updateDownPaymentPercentage(downPaymentPercentage);
              }
              else {
                ref.read(brrrrProvider).updateDownPaymentPercentage(0.0);
              }
              ref.read(brrrrProvider).calculateAllFinanceOptions();
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
                ref.read(brrrrProvider).updateInterestRate(interestRate);
              }
              else {
                ref.read(brrrrProvider).updateInterestRate(0);
              }
            },
          ),
          IntegerTextField(
            labelText: 'Term in Years',
            controller: termController,
            leftPadding: 8,
            rightPadding: 8,
            onChanged: (String newTerm) {
              newTerm = newTerm.replaceAll(',', '');
              int? newValue = int.tryParse(newTerm);
              if (newValue != null) {
                ref.read(brrrrProvider).updateTerm(newValue);
              }
              else {
                ref.read(brrrrProvider).updateTerm(0);
              }
            },
          ),
          MoneyTextField(
            labelText: 'Closing Costs',
            controller: closingCostsController,
            onChanged: (String newCost) {
              newCost = newCost.replaceAll(',', '');
              double? newValue = double.tryParse(newCost);
              if (newValue != null) {
                ref.read(brrrrProvider).updateClosingCosts(newValue);
              }
              else {
                ref.read(brrrrProvider).updateClosingCosts(0);
              }
            },
          ),
          CupertinoSlidingSegmentedControl<PaymentType>(
            thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
            groupValue: ref.watch(brrrrProvider).paymentType,
            children: const {
              PaymentType.principalAndInterest: Text('Principal & Interest'),
              PaymentType.interestOnly: Text('Interest Only'),
            },
            onValueChanged: (PaymentType? newValue) =>
                ref.read(brrrrProvider).updatePaymentType(newValue!),
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Monthly\nPayment'
                  : 'Monthly Payment',
              monthlyPaymentString),
          const Divider(),
          const SizedBox(height: 8),
          Text('Would you like to refinance this property?', style: Theme.of(context).textTheme.headline6,),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CupertinoSlidingSegmentedControl<bool>(
              groupValue: ref.watch(brrrrProvider).wantsToRefinance,
              thumbColor: Theme.of(context).primaryColor.withOpacity(0.5),
              children: const {
                true: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Yes'),
                ),
                false: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No'),
                ),
              },
              onValueChanged: (bool? newValue) {
                ref.read(brrrrProvider).updateWantsToRefinance(newValue!);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FinancingDropDown extends StatelessWidget {
  const FinancingDropDown({
    Key? key,
    required this.value,
    required this.ref,
  }) : super(key: key);

  final FinancingType value;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<FinancingType>(
      value: value,
      items: FinancingType.values
          .map((FinancingType financingType) =>
              DropdownMenuItem<FinancingType>(
                  value: financingType,
                  child: Text(FinancingTypeUtils(financingType).name)))
          .toList(),
      onChanged: (FinancingType? newValue) {
        ref.read(brrrrProvider).updateFinancingType(newValue);
        ref.read(brrrrProvider).updateWillRefinance(
            (newValue == FinancingType.conventional ||
                    newValue == FinancingType.commercial)
                ? false
                : true);
      },
    );
  }
}
