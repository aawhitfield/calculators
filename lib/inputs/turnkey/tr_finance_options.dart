import 'package:calculators/globals.dart';
import 'package:calculators/inputs/turnkey/tr_expenses_input.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
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

enum ClosingCosts { value, percentage }

class TurnkeyRentalFinanceOptions extends ConsumerStatefulWidget {
  const TurnkeyRentalFinanceOptions({Key? key}) : super(key: key);

  @override
  _FinanceOptionsState createState() => _FinanceOptionsState();
}

class _FinanceOptionsState extends ConsumerState<TurnkeyRentalFinanceOptions> {
  TextEditingController downPaymentPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController closingCostsController = TextEditingController();
  TextEditingController closingCostsPercentageController = TextEditingController();

  ClosingCosts closingCostOption = ClosingCosts.value;
  double closingCostsPercentage = 0;
  
  GlobalKey<FormState> turnkeyFinanceKey = GlobalKey<FormState>();

  @override
  void initState() {
    double loanPercent = ref.read(turnkeyProvider).downPaymentPercent * 100;
    if (loanPercent != 0) {
      downPaymentPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(turnkeyProvider).interestRate * 100;
    if (interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(turnkeyProvider).term;
    if (term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    double closingCosts = ref.read(turnkeyProvider).closingCosts;
    if (closingCosts != 0) {
      closingCostsController.text = kCurrencyFormat.format(closingCosts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(turnkeyProvider).financingType;

    double loanAmount = ref.watch(turnkeyProvider).loanAmount;

    double downPaymentAmount =
        ref.watch(turnkeyProvider).purchasePrice - loanAmount;

    double monthlyPayment = ref.watch(turnkeyProvider).calculateMonthlyPayment(
          rate: ref.watch(turnkeyProvider).interestRate / 12,
          nper: ref.watch(turnkeyProvider).term * 12,
          pv: -1 * loanAmount,
        );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
      imageUri: 'images/finance.svg',
      headerText: 'Finance Options',
      subheadText: '',
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const TurnkeyRentalExpensesInput());
        } else {
          Get.back();
        }
      },
      onSubmit: () {
        ref.read(turnkeyProvider).updateMonthlyPayment(monthlyPayment);
        ref.read(turnkeyProvider).updateDownPayment(downPaymentAmount);
        ref.read(turnkeyProvider).updateLoanAmount(loanAmount);
        if (turnkeyFinanceKey.currentState?.validate() ?? false) {
          Get.to(() => const TurnkeyRentalReport());
        }
      },
      position:
          kTurnKeyRentalQuestions.indexOf(TurnkeyRentalFinanceOptions) + 1,
      totalQuestions: kTurnKeyRentalQuestions.length,
      child: Form(
        key: turnkeyFinanceKey,
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
                  ref
                      .read(turnkeyProvider)
                      .updateDownPaymentPercentage(downPaymentPercentage);
                } else {
                  ref.read(turnkeyProvider).updateDownPaymentPercentage(0.0);
                }
                ref.read(turnkeyProvider).calculateAllFinanceOptions();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Down Payment is required';
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
                  ref.read(turnkeyProvider).updateInterestRate(interestRate);
                } else {
                  ref.read(turnkeyProvider).updateInterestRate(0);
                }
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
                  ref.read(turnkeyProvider).updateTerm(newValue);
                } else {
                  ref.read(turnkeyProvider).updateTerm(0);
                }
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
                    closingCostsController.text = kCurrencyFormat.format(ref.read(turnkeyProvider).closingCosts);
                  }
                  else {
                    closingCostsPercentageController.text = ((ref.read(turnkeyProvider).closingCosts) / loanAmount * 100).toStringAsFixed(2);
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
                        ref.read(turnkeyProvider).updateClosingCosts(newValue);
                      } else {
                        ref.read(turnkeyProvider).updateClosingCosts(0);
                      }
                      ref.read(turnkeyProvider).calculateAll();
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
                            ref.read(turnkeyProvider).updateClosingCosts(newClosingCosts);
                          } else {
                            ref.read(turnkeyProvider).updateClosingCosts(0);
                          }
                          ref.read(turnkeyProvider).calculateAll();
                        },
                      ),
                      MoneyListTile(
                          'Closing Costs',
                          kCurrencyFormat
                              .format(ref.watch(turnkeyProvider).closingCosts)),
                    ],
                  ),
            MoneyListTile(
              (MediaQuery.of(context).size.width < 640)
                  ? 'Monthly\nPayment'
                  : 'Monthly Payment',
              monthlyPaymentString,
              subtitle: 'Principle and Interest Monthly',
            ),
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
          .map((FinancingType financingType) => DropdownMenuItem<FinancingType>(
              value: financingType,
              child: Text(FinancingTypeUtils(financingType).name)))
          .toList(),
      onChanged: (FinancingType? newValue) {
        ref.read(turnkeyProvider).updateFinancingType(newValue);
        ref.read(turnkeyProvider).updateWillRefinance(
            (newValue == FinancingType.conventional ||
                    newValue == FinancingType.commercial)
                ? false
                : true);
      },
    );
  }
}
