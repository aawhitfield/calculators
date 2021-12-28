import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_option_construction_loan.dart';
import 'package:calculators/inputs/is_seller_financed.dart';
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

class FinanceOptions extends ConsumerStatefulWidget {
  const FinanceOptions({Key? key}) : super(key: key);

  @override
  _FinanceOptionsState createState() => _FinanceOptionsState();
}

class _FinanceOptionsState extends ConsumerState<FinanceOptions> {
  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(financeProvider).loanPercentage * 100;
    if(loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(financeProvider).interestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(financeProvider).term;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    double closingCosts = ref.read(financeProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(financeProvider).financingType;

    double loanAmount = ref.watch(brrrrProvider).purchasePrice *
        ref.watch(financeProvider).loanPercentage;

    double downPaymentAmount = ref.watch(brrrrProvider).purchasePrice -
        loanAmount;

    double monthlyPayment = (ref.watch(financeProvider).paymentType ==
            PaymentType.principalAndInterest)
        ? ref.watch(financeProvider).calculateMonthlyPayment(
              rate: ref.watch(financeProvider).interestRate / 12,
              nper: ref.watch(financeProvider).term * 12,
              pv: -1 * loanAmount,
            )
        : ref.watch(financeProvider).calculateMonthlyPaymentInterestOnly(
              rate: ref.watch(financeProvider).interestRate / 12,
              nper: ref.watch(financeProvider).term,
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
        ref.read(financeProvider).updateMonthlyPayment(monthlyPayment);
        ref.read(financeProvider).updateDownPayment(downPaymentAmount);
        ref.read(financeProvider).updateLoanAmount(loanAmount);
        FinancingType financingType = ref.watch(financeProvider).financingType;
        if (financingType == FinancingType.hardMoneyWithConstruction ||
            financingType == FinancingType.commercialWithConstruction) {
          Get.to(() => const FinanceOptionConstructionLoan());
        } else {
          Get.to(() => const IsSellerFinanced());
        }
      },
      position: kResidentialREIQuestions.indexOf(FinanceOptions) + 1,
      totalQuestions: kResidentialREIQuestions.length,
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
            labelText: 'Loan Percent',
            controller: loanPercentController,
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double loanPercentage = newValue / 100;
                ref.read(financeProvider).updateLoanPercentage(loanPercentage);
                double purchasePrice = ref.read(brrrrProvider).purchasePrice;
                double loanAmount = purchasePrice * loanPercentage;

                ref.read(financeProvider).updateLoanAmount(loanAmount);

                double downPayment = purchasePrice - loanAmount;
                ref.read(financeProvider).updateDownPayment(downPayment);
              }
              else {
                ref.read(financeProvider).updateLoanPercentage(0);
              }
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
                ref.read(financeProvider).updateInterestRate(interestRate);
              }
              else {
                ref.read(financeProvider).updateInterestRate(0);
              }
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
                ref.read(financeProvider).updateTerm(newValue);
              }
              else {
                ref.read(financeProvider).updateTerm(0);
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
                ref.read(financeProvider).updateClosingCosts(newValue);
              }
              else {
                ref.read(financeProvider).updateClosingCosts(0);
              }
            },
          ),
          CupertinoSlidingSegmentedControl<PaymentType>(
            thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
            groupValue: ref.watch(financeProvider).paymentType,
            children: const {
              PaymentType.principalAndInterest: Text('Principal & Interest'),
              PaymentType.interestOnly: Text('Interest Only'),
            },
            onValueChanged: (PaymentType? newValue) =>
                ref.read(financeProvider).updatePaymentType(newValue!),
          ),
          MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Monthly\nPayment'
                  : 'Monthly Payment',
              monthlyPaymentString),
          ListTile(
            title: const Text('Refinance'),
            trailing: Text(
              ref.watch(financeProvider).willRefinance ? 'YES' : 'NO',
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
        ref.read(financeProvider).updateFinancingType(newValue);
        ref.read(financeProvider).updateWillRefinance(
            (newValue == FinancingType.conventional ||
                    newValue == FinancingType.commercial)
                ? false
                : true);
      },
    );
  }
}
