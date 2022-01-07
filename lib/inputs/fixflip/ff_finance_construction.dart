import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipFinanceConstruction extends ConsumerStatefulWidget {
  const FixFlipFinanceConstruction({Key? key}) : super(key: key);

  @override
  _FinanceOptionConstructionLoanState createState() => _FinanceOptionConstructionLoanState();
}

class _FinanceOptionConstructionLoanState extends ConsumerState<FixFlipFinanceConstruction> {

  TextEditingController downPaymentPercentageController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(fixFlipProvider).constructionDownPaymentPercentage * 100;
    if(loanPercent != 0) {
      downPaymentPercentageController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(fixFlipProvider).constructionInterestRate;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(fixFlipProvider).constructionTerm;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(fixFlipProvider).financingType;

    double loanAmount = ref.watch(fixFlipProvider).constructionLoanAmount;

    double downPaymentAmount = ref.watch(fixFlipProvider).constructionDownPaymentAmount;

    double monthlyPayment = ref.watch(fixFlipProvider).calculateMonthlyPaymentInterestOnly(
      rate: ref.watch(fixFlipProvider).constructionInterestRate / 12,
      nper: ref.watch(fixFlipProvider).constructionTerm,
      pv: -1 * loanAmount,
      per: 1,
    );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/finance-construction.svg',
        headerText: 'Finance Option', subheadText: 'Construction Loan',
        onSubmit: () {
          ref.read(fixFlipProvider).updateMonthlyPayment(monthlyPayment);
          ref.read(fixFlipProvider).updateConstructionDownPayment(downPaymentAmount);
          ref.read(fixFlipProvider).updateConstructionLoanAmount(loanAmount);
          if(ref.read(fixFlipProvider).financingType == FinancingType.sellerFinancing) {
            Get.to(() => const FinanceOptionSellerFinanced());
          }
          else {
            ref.read(fixFlipProvider).calculateAllHoldingCosts();
            Get.to(() => const HoldingCosts());
          }
        },
        position: kFixFlipQuestions.indexOf(FixFlipFinanceConstruction) + 1,
        totalQuestions: kFixFlipQuestions.length,
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
                  ref.read(fixFlipProvider).updateConstructionDownPaymentPercentage(loanPercentage);
                } else {
                  ref.read(fixFlipProvider).updateConstructionDownPaymentPercentage(0.0);
                }
                ref.read(fixFlipProvider).calculateAllConstructionCalculations();
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
                  ref.read(fixFlipProvider).updateConstructionInterestRate(interestRate);
                }
                else {
                  ref.read(fixFlipProvider).updateConstructionInterestRate(0.0);
                }
                ref.read(fixFlipProvider).calculateAllConstructionCalculations();
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
                  ref.read(fixFlipProvider).updateConstructionTerm(newValue);
                }
                else {
                  ref.read(fixFlipProvider).updateConstructionTerm(0);
                }
                ref.read(fixFlipProvider).calculateAllConstructionCalculations();
              },
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
