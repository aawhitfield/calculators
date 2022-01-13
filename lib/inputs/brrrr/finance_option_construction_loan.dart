import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/finance_options.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/inputs/brrrr/refinance_input.dart';
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

class FinanceOptionConstructionLoan extends ConsumerStatefulWidget {
  const FinanceOptionConstructionLoan({Key? key}) : super(key: key);

  @override
  _FinanceOptionConstructionLoanState createState() => _FinanceOptionConstructionLoanState();
}

class _FinanceOptionConstructionLoanState extends ConsumerState<FinanceOptionConstructionLoan> {

  TextEditingController downPaymentPercentageController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(brrrrProvider).constructionDownPaymentPercentage * 100;
    if(loanPercent != 0) {
      downPaymentPercentageController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(brrrrProvider).constructionInterestRate;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(brrrrProvider).constructionTerm;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(brrrrProvider).financingType;

    double loanAmount = ref.watch(brrrrProvider).constructionLoanAmount;

    double downPaymentAmount = ref.watch(brrrrProvider).constructionDownPaymentAmount;

    double monthlyPayment = ref.watch(brrrrProvider).constructionMonthlyPayment;

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/finance-construction.svg',
        headerText: 'Finance Option', subheadText: 'Construction Loan',
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const FinanceOptions());
        } else {
          Get.back();
        }
      },
        onSubmit: () {
          ref.read(brrrrProvider).updateMonthlyPayment(monthlyPayment);
          ref.read(brrrrProvider).updateConstructionDownPayment(downPaymentAmount);
          ref.read(brrrrProvider).updateConstructionLoanAmount(loanAmount);
          if(ref.read(brrrrProvider).financingType == FinancingType.sellerFinancing) {
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
        position: kBRRRRQuestions.indexOf(FinanceOptionConstructionLoan) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: ResponsiveLayout(
          children: [
            ListTile(
                leading: const Text('Financing Type'),

                          title: Text(FinancingTypeUtils(value).name)
            ),
            PercentTextField(
              labelText: 'Down Payment Percentage',
              controller: downPaymentPercentageController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double loanPercentage = newValue / 100;
                  ref.read(brrrrProvider).updateConstructionDownPaymentPercentage(loanPercentage);
                } else {
                  ref.read(brrrrProvider).updateConstructionDownPaymentPercentage(0.0);
                }
                ref.read(brrrrProvider).calculateAllConstructionCalculations();
              },
            ),
            MoneyListTile(
    (MediaQuery.of(context).size.width < 640)
                ? 'Loan\nAmount'
                : 'Loan Amount', loanAmountString, subtitle: 'Construction',),
            MoneyListTile(
    (MediaQuery.of(context).size.width < 640)
                ? 'Down\nPayment'
                : 'Down Payment', downPaymentString),
            PercentTextField(
              labelText: 'Interest Rate',
              controller: interestRateController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double interestRate = newValue / 100;
                  ref.read(brrrrProvider).updateConstructionInterestRate(interestRate);
                }
                else {
                  ref.read(brrrrProvider).updateConstructionInterestRate(0.0);
                }
                ref.read(brrrrProvider).calculateAllConstructionCalculations();
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
                  ref.read(brrrrProvider).updateConstructionTerm(newValue);
                }
                else {
                  ref.read(brrrrProvider).updateConstructionTerm(0);
                }
                ref.read(brrrrProvider).calculateAllConstructionCalculations();
              },
            ),
            CupertinoSlidingSegmentedControl<PaymentType>(
              thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
              groupValue: ref.watch(brrrrProvider).constructionPaymentType,
              children: const {
                PaymentType.principalAndInterest: Text('Principal & Interest'),
                PaymentType.interestOnly: Text('Interest Only'),
              },
              onValueChanged: (PaymentType? newValue) =>
                  ref.read(brrrrProvider).updateConstructionPaymentType(newValue!),
            ),
            MoneyListTile(
    (MediaQuery.of(context).size.width < 640)
                ? 'Monthly\nPayment'
                : 'Monthly Payment', monthlyPaymentString),
          ],
        ),
    );
  }
}
