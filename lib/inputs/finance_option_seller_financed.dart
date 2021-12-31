import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/inputs/want_to_refinance.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FinanceOptionSellerFinanced extends ConsumerStatefulWidget {
  const FinanceOptionSellerFinanced({Key? key}) : super(key: key);

  @override
  _FinanceOptionDownPaymentState createState() => _FinanceOptionDownPaymentState();
}

class _FinanceOptionDownPaymentState extends ConsumerState<FinanceOptionSellerFinanced> {

  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController amortizationController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(brrrrProvider).sellerLoanPercentage * 100;
    if(loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(brrrrProvider).sellerInterestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(brrrrProvider).sellerTerm;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    int amortization = ref.read(brrrrProvider).amortization;
    if(amortization != 0) {
      amortizationController.text = kWholeNumber.format(amortization);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double loanAmount = ref.watch(brrrrProvider).sellerLoanAmount;

    double monthlyPayment = (ref.watch(brrrrProvider).sellerFinancingType ==
            SellerFinancingType.payment)
        ? ref.watch(brrrrProvider).calculateMonthlyPayment(
              rate: ref.watch(brrrrProvider).sellerInterestRate / 12,
              nper: ref.watch(brrrrProvider).sellerTerm * 12,
              pv: -1 * loanAmount,
            )
        : ref.watch(brrrrProvider).calculateMonthlyPaymentInterestOnly(
              rate: ref.watch(brrrrProvider).sellerInterestRate / 12,
              nper: ref.watch(brrrrProvider).sellerTerm,
              pv: -1 * loanAmount,
              per: 1,
            );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/transfer.svg',
        headerText: 'Finance Option',
        subheadText: 'Seller Financed Loan',
        onSubmit: () {
          ref.read(brrrrProvider).updateSellerMonthlyPayment(monthlyPayment);
          ref.read(brrrrProvider).updateSellerLoanAmount(loanAmount);
          Calculator calculatorType = ref.read(calculatorProvider).type;
          if (calculatorType == Calculator.brrrr) {
            Get.to(() => const WantToRefinance());
          }
          else {
            double realtorsFees = ref.watch(brrrrProvider).afterRepairValue *
                ref.watch(ffSellingCostsProvider).realtorFeesPercentage;
            ref.read(ffSellingCostsProvider).updateRealtorFees(realtorsFees);

            int numberOfMonthsToRehabRent =
                ref.read(brrrrProvider).monthsToRehabRent;
            double taxes = ref.watch(brrrrProvider).taxesYearly;
            if (numberOfMonthsToRehabRent != 0) {
              taxes = taxes / numberOfMonthsToRehabRent;
            }
            ref.read(ffSellingCostsProvider).updateTaxes(taxes);
            double other = ref.watch(brrrrProvider).afterRepairValue * 0.02;
            ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
            ref.read(ffSellingCostsProvider).calculateTotal();
            Get.to(() => const FixAndFlipSellingCostsInput());
          }
        },
        position:
            kBRRRRQuestions.indexOf(FinanceOptionSellerFinanced) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: ResponsiveLayout(
          children: [
            ((MediaQuery.of(context).size.width > 640))
                ? Row(
                    children: [
                      const Text('Financing Type'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CupertinoSlidingSegmentedControl<SellerFinancingType>(
                          thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
                          groupValue: ref.watch(brrrrProvider).sellerFinancingType,
                          children: {
                            SellerFinancingType.payment: Text(SellerFinancingTypeUtils(SellerFinancingType.payment).name),
                            SellerFinancingType.interest: Text(SellerFinancingTypeUtils(SellerFinancingType.interest).name),
                          },
                          onValueChanged: (SellerFinancingType? newValue) =>
                              ref.read(brrrrProvider).updateSellerFinancingType(newValue!),
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Financing Type'),
                      const SizedBox(height: 8),
                      CupertinoSlidingSegmentedControl<SellerFinancingType>(
                        thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
                        groupValue: ref.watch(brrrrProvider).sellerFinancingType,
                        children: {
                          SellerFinancingType.payment: Text(SellerFinancingTypeUtils(SellerFinancingType.payment).name),
                          SellerFinancingType.interest: Text(SellerFinancingTypeUtils(SellerFinancingType.interest).name),
                        },
                        onValueChanged: (SellerFinancingType? newValue) =>
                            ref.read(brrrrProvider).updateSellerFinancingType(newValue!),
                      ),
                    ],
                  ),
            PercentTextField(
              labelText: 'Loan Percent',
              controller: loanPercentController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double sellerLoanPercentage = newValue / 100;
                  ref
                      .read(brrrrProvider)
                      .updateSellerLoanPercentage(sellerLoanPercentage);
                }
                else {
                  ref
                      .read(brrrrProvider)
                      .updateSellerLoanPercentage(0.0);
                }
                ref.read(brrrrProvider).calculateSellerFinanceCalculations();
              },
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Loan\nAmount'
                    : 'Loan Amount',
                loanAmountString),
            PercentTextField(
              labelText: 'Interest Rate',
              controller: interestRateController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double interestRate = newValue / 100;
                  ref
                      .read(brrrrProvider)
                      .updateSellerInterestRate(interestRate);
                }
                else {
                  ref
                      .read(brrrrProvider)
                      .updateSellerInterestRate(0.0);
                }
                ref.read(brrrrProvider).calculateSellerFinanceCalculations();
              },
            ),
            IntegerTextField(
              labelText: 'Amortization',
              controller: amortizationController,
              leftPadding: 8,
              rightPadding: 8,
              onChanged: (String newTerm) {
                newTerm = newTerm.replaceAll(',', '');
                int? newValue = int.tryParse(newTerm);
                if (newValue != null) {
                  ref.read(brrrrProvider).updateAmortization(newValue);
                }
                else {
                  ref.read(brrrrProvider).updateAmortization(0);
                }
                ref.read(brrrrProvider).calculateSellerFinanceCalculations();
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
                  ref.read(brrrrProvider).updateSellerTerm(newValue);
                }
                else {
                  ref.read(brrrrProvider).updateSellerTerm(0);
                }
                ref.read(brrrrProvider).calculateSellerFinanceCalculations();
              },
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Monthly\nPayment'
                    : 'Monthly Payment',
                monthlyPaymentString),
          ],
        ));
  }
}

class SellerDropdown extends StatelessWidget {
  const SellerDropdown({
    Key? key,
    required this.value,
    required this.ref,
  }) : super(key: key);

  final SellerFinancingType value;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SellerFinancingType>(
      value: value,
      items: SellerFinancingType.values
          .map((SellerFinancingType sellerFinancingType) =>
              DropdownMenuItem<SellerFinancingType>(
                  value: sellerFinancingType,
                  child:
                      Text(SellerFinancingTypeUtils(sellerFinancingType).name)))
          .toList(),
      onChanged: (SellerFinancingType? newValue) {
        ref.read(brrrrProvider).updateSellerFinancingType(newValue);
      },
    );
  }
}
