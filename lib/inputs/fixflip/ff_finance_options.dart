import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_expenses_input.dart';
import 'package:calculators/inputs/fixflip/ff_finance_construction.dart';
import 'package:calculators/inputs/fixflip/ff_finance_seller_financed.dart';
import 'package:calculators/inputs/fixflip/ff_holding_costs.dart';
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

class FixFlipFinanceOptions extends ConsumerStatefulWidget {
  const FixFlipFinanceOptions({Key? key}) : super(key: key);

  @override
  _FinanceOptionsState createState() => _FinanceOptionsState();
}

class _FinanceOptionsState extends ConsumerState<FixFlipFinanceOptions> {
  TextEditingController downPaymentPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();
  TextEditingController closingCostsPercentageController = TextEditingController();

  GlobalKey<FormState> ffFinanceKey = GlobalKey<FormState>();

  ClosingCosts closingCostOption = ClosingCosts.value;
  double closingCostsPercentage = 0;

  @override
  void initState() {
    double loanPercent = ref.read(fixFlipProvider).downPaymentPercent * 100;
    if(loanPercent != 0) {
      downPaymentPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(fixFlipProvider).interestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(fixFlipProvider).term;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    double closingCosts = ref.read(fixFlipProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(fixFlipProvider).financingType;

    double loanAmount = ref.watch(fixFlipProvider).loanAmount;

    double downPaymentAmount = ref.watch(fixFlipProvider).purchasePrice -
        loanAmount;

    double monthlyPayment = ref.watch(fixFlipProvider).monthlyPayment;

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return Form(
      key: ffFinanceKey,
      child: MyInputPage(
        imageUri: 'images/finance.svg',
        headerText: 'Finance Options',
        subheadText: '',
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            Get.off(() => const FixFlipExpensesInput());
          } else {
            Get.back();
          }
        },
        onSubmit: () {
          if (ffFinanceKey.currentState?.validate() ?? false) {
            FinancingType financingType = ref.watch(fixFlipProvider).financingType;
            if (financingType == FinancingType.hardMoneyWithConstruction ||
                financingType == FinancingType.commercialWithConstruction) {
              Get.to(() => const FixFlipFinanceConstruction());
            } else if(financingType == FinancingType.sellerFinancing){
              Get.to(() => const FixFlipFinanceSellerFinanced());
            }
            else {
              ref.read(fixFlipProvider).calculateAllHoldingCosts();
              Get.to(() => const FixFlipHoldingCosts());
            }
          }
        },
        position: kFixFlipQuestions.indexOf(FixFlipFinanceOptions) + 1,
        totalQuestions: kFixFlipQuestions.length,
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
              labelText: 'Down Payment Percent *',
              controller: downPaymentPercentController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double downPaymentPercentage = newValue / 100;
                  ref.read(fixFlipProvider).updateDownPaymentPercentage(downPaymentPercentage);
                }
                else {
                  ref.read(fixFlipProvider).updateDownPaymentPercentage(0.0);
                }
                ref.read(fixFlipProvider).calculateAllFinanceOptions();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Down payment is required';
                }
                return null;
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
              labelText: 'Interest Rate *',
              controller: interestRateController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double interestRate = newValue / 100;
                  ref.read(fixFlipProvider).updateInterestRate(interestRate);
                }
                else {
                  ref.read(fixFlipProvider).updateInterestRate(0);
                }
                ref.read(fixFlipProvider).calculateAllFinanceOptions();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Interest rate is required';
                }
                return null;
              },
            ),
            IntegerTextField(
              labelText: 'Term in Years *',
              controller: termController,
              leftPadding: 8,
              rightPadding: 8,
              onChanged: (String newTerm) {
                newTerm = newTerm.replaceAll(',', '');
                int? newValue = int.tryParse(newTerm);
                if (newValue != null) {
                  ref.read(fixFlipProvider).updateTerm(newValue);
                }
                else {
                  ref.read(fixFlipProvider).updateTerm(0);
                }
                ref.read(fixFlipProvider).calculateAllFinanceOptions();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Term is required';
                }
                return null;
              },
            ),
            CupertinoSlidingSegmentedControl(
              thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
              groupValue: closingCostOption,
              children: const {
                ClosingCosts.value: Text('Dollar Amount'),
                ClosingCosts.percentage: Text('Percentage'),
              },
              onValueChanged: (ClosingCosts? newClosingCostOption) {
                setState(() {
                  closingCostOption = newClosingCostOption!;

                  if(newClosingCostOption == ClosingCosts.value) {
                    closingCostsController.text = kCurrencyFormat.format(ref.read(fixFlipProvider).closingCosts);
                  }
                  else {
                    closingCostsPercentageController.text = ((ref.read(fixFlipProvider).closingCosts) / loanAmount * 100).toStringAsFixed(2);
                  }
                });
              },
            ),
            (closingCostOption == ClosingCosts.value)
                ? MoneyTextField(
              labelText: 'Closing Costs',
              controller: closingCostsController,
              onChanged: (String newCost) {
                newCost = newCost.replaceAll(',', '');
                double? newValue = double.tryParse(newCost);
                if (newValue != null) {
                  ref.read(fixFlipProvider).updateClosingCosts(newValue);
                } else {
                  ref.read(fixFlipProvider).updateClosingCosts(0);
                }
              },
            )
                : Column(
              children: [
                PercentTextField(
                  controller: closingCostsPercentageController,
                  labelText: 'Closing Costs Percentage',
                  onChanged: (String newPercentage) {
                    newPercentage = newPercentage.replaceAll(',', '');
                    double? newValue = double.tryParse(newPercentage);
                    if (newValue != null) {
                      double closingCostsPercentage = newValue / 100;
                      double newClosingCosts = closingCostsPercentage * loanAmount;
                      ref.read(fixFlipProvider).updateClosingCosts(newClosingCosts);
                    } else {
                      ref.read(fixFlipProvider).updateClosingCosts(0);
                    }
                    ref.read(fixFlipProvider).calculateAll();
                  },
                ),
                MoneyListTile(
                    'Closing Costs',
                    kCurrencyFormat
                        .format(ref.watch(fixFlipProvider).closingCosts)),
              ],
            ),
            CupertinoSlidingSegmentedControl<PaymentType>(
              thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
              groupValue: ref.watch(fixFlipProvider).paymentType,
              children: const {
                PaymentType.principalAndInterest: Text('Principal & Interest'),
                PaymentType.interestOnly: Text('Interest Only'),
              },
              onValueChanged: (PaymentType? newValue) =>
                  ref.read(fixFlipProvider).updatePaymentType(newValue!),
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Monthly\nPayment'
                    : 'Monthly Payment',
                monthlyPaymentString),
          ],
        ),
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
        ref.read(fixFlipProvider).updateFinancingType(newValue);
        ref.read(fixFlipProvider).updateWillRefinance(
            (newValue == FinancingType.conventional ||
                    newValue == FinancingType.commercial)
                ? false
                : true);
      },
    );
  }
}
