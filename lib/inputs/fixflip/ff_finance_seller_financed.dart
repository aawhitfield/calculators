import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_finance_construction.dart';
import 'package:calculators/inputs/fixflip/ff_finance_options.dart';
import 'package:calculators/inputs/fixflip/ff_holding_costs.dart';
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

class FixFlipFinanceSellerFinanced extends ConsumerStatefulWidget {
  const FixFlipFinanceSellerFinanced({Key? key}) : super(key: key);

  @override
  _FinanceOptionDownPaymentState createState() =>
      _FinanceOptionDownPaymentState();
}

class _FinanceOptionDownPaymentState
    extends ConsumerState<FixFlipFinanceSellerFinanced> {
  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController amortizationController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(fixFlipProvider).sellerLoanPercentage * 100;
    if (loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(fixFlipProvider).sellerInterestRate * 100;
    if (interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(fixFlipProvider).sellerTerm;
    if (term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    int amortization = ref.read(fixFlipProvider).amortization;
    if (amortization != 0) {
      amortizationController.text = kWholeNumber.format(amortization);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double loanAmount = ref.watch(fixFlipProvider).sellerLoanAmount;

    double monthlyPayment = (ref.watch(fixFlipProvider).sellerFinancingType ==
            SellerFinancingType.payment)
        ? ref.watch(fixFlipProvider).calculateMonthlyPayment(
              rate: ref.watch(fixFlipProvider).sellerInterestRate / 12,
              nper: ref.watch(fixFlipProvider).sellerTerm * 12,
              pv: -1 * loanAmount,
            )
        : ref.watch(fixFlipProvider).calculateMonthlyPaymentInterestOnly(
              rate: ref.watch(fixFlipProvider).sellerInterestRate / 12,
              nper: ref.watch(fixFlipProvider).sellerTerm,
              pv: -1 * loanAmount,
              per: 1,
            );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/transfer.svg',
        headerText: 'Finance Option',
        subheadText: 'Seller Financed Loan',
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            if(ref.read(fixFlipProvider).financingType == FinancingType.hardMoneyWithConstruction
                || ref.read(fixFlipProvider).financingType == FinancingType.commercialWithConstruction) {
              Get.off(() => const FixFlipFinanceConstruction());
            }
            else {
              Get.off(() => const FixFlipFinanceOptions());
            }
          }
          else {
            Get.back();
          }
        },
        onSubmit: () {
          ref.read(fixFlipProvider).updateSellerMonthlyPayment(monthlyPayment);
          ref.read(fixFlipProvider).updateSellerLoanAmount(loanAmount);

          ref.read(fixFlipProvider).calculateAllHoldingCosts();
          Get.to(() => const FixFlipHoldingCosts());
        },
        position: kFixFlipQuestions.indexOf(FixFlipFinanceSellerFinanced) + 1,
        totalQuestions: kFixFlipQuestions.length,
        child: ResponsiveLayout(
          children: [
            ((MediaQuery.of(context).size.width > 640))
                ? Row(
                    children: [
                      const Text('Financing Type'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CupertinoSlidingSegmentedControl<
                            SellerFinancingType>(
                          thumbColor:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          groupValue:
                              ref.watch(fixFlipProvider).sellerFinancingType,
                          children: {
                            SellerFinancingType.payment: Text(
                                SellerFinancingTypeUtils(
                                        SellerFinancingType.payment)
                                    .name),
                            SellerFinancingType.interest: Text(
                                SellerFinancingTypeUtils(
                                        SellerFinancingType.interest)
                                    .name),
                          },
                          onValueChanged: (SellerFinancingType? newValue) => ref
                              .read(fixFlipProvider)
                              .updateSellerFinancingType(newValue!),
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
                        thumbColor:
                            Theme.of(context).primaryColor.withOpacity(0.4),
                        groupValue:
                            ref.watch(fixFlipProvider).sellerFinancingType,
                        children: {
                          SellerFinancingType.payment: Text(
                              SellerFinancingTypeUtils(
                                      SellerFinancingType.payment)
                                  .name),
                          SellerFinancingType.interest: Text(
                              SellerFinancingTypeUtils(
                                      SellerFinancingType.interest)
                                  .name),
                        },
                        onValueChanged: (SellerFinancingType? newValue) => ref
                            .read(fixFlipProvider)
                            .updateSellerFinancingType(newValue!),
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
                      .read(fixFlipProvider)
                      .updateSellerLoanPercentage(sellerLoanPercentage);
                } else {
                  ref.read(fixFlipProvider).updateSellerLoanPercentage(0.0);
                }
                ref.read(fixFlipProvider).calculateSellerFinanceCalculations();
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
                      .read(fixFlipProvider)
                      .updateSellerInterestRate(interestRate);
                } else {
                  ref.read(fixFlipProvider).updateSellerInterestRate(0.0);
                }
                ref.read(fixFlipProvider).calculateSellerFinanceCalculations();
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
                  ref.read(fixFlipProvider).updateAmortization(newValue);
                } else {
                  ref.read(fixFlipProvider).updateAmortization(0);
                }
                ref.read(fixFlipProvider).calculateSellerFinanceCalculations();
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
                  ref.read(fixFlipProvider).updateSellerTerm(newValue);
                } else {
                  ref.read(fixFlipProvider).updateSellerTerm(0);
                }
                ref.read(fixFlipProvider).calculateSellerFinanceCalculations();
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
        ref.read(fixFlipProvider).updateSellerFinancingType(newValue);
      },
    );
  }
}
