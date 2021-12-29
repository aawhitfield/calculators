import 'package:calculators/globals.dart';
import 'package:calculators/inputs/is_seller_financed.dart';
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

class FinanceOptionConstructionLoan extends ConsumerStatefulWidget {
  const FinanceOptionConstructionLoan({Key? key}) : super(key: key);

  @override
  _FinanceOptionConstructionLoanState createState() => _FinanceOptionConstructionLoanState();
}

class _FinanceOptionConstructionLoanState extends ConsumerState<FinanceOptionConstructionLoan> {

  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(financeConstructionProvider).loanPercentage * 100;
    if(loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(financeConstructionProvider).interestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(financeConstructionProvider).term;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FinancingType value = ref.watch(financeProvider).financingType;

    double loanAmount = ref.watch(brrrrProvider).totalRenovations *
        ref.watch(financeConstructionProvider).loanPercentage;

    double downPaymentAmount = ref.watch(brrrrProvider).totalRenovations -
        loanAmount;

    double monthlyPayment = ref.watch(financeConstructionProvider).calculateMonthlyPaymentInterestOnly(
      rate: ref.watch(financeConstructionProvider).interestRate / 12,
      nper: ref.watch(financeConstructionProvider).term,
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
          ref.read(financeConstructionProvider).updateMonthlyPayment(monthlyPayment);
          ref.read(financeConstructionProvider).updateDownPayment(downPaymentAmount);
          ref.read(financeConstructionProvider).updateLoanAmount(loanAmount);
          Get.to(() => const IsSellerFinanced());
        },
        position: kResidentialREIQuestions.indexOf(FinanceOptionConstructionLoan) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            ListTile(
                leading: const Text('Financing Type'),

                          title: Text(FinancingTypeUtils(value).name)
            ),
            PercentTextField(
              labelText: 'Loan Percent',
              controller: loanPercentController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double loanPercentage = newValue / 100;
                  ref.read(financeConstructionProvider).updateLoanPercentage(loanPercentage);
                  double totalConstruction = ref.read(brrrrProvider).totalRenovations;
                  double loanAmount = totalConstruction * loanPercentage;

                  ref.read(financeConstructionProvider).updateLoanAmount(loanAmount);

                  double downPayment = totalConstruction - loanAmount;
                  ref.read(financeConstructionProvider).updateDownPayment(downPayment);
                }
              },
            ),
            MoneyListTile(
    (MediaQuery.of(context).size.width < 640)
                ? 'Loan\nAmount'
                : 'Loan Amount', loanAmountString),
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
                  ref.read(financeConstructionProvider).updateInterestRate(interestRate);
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
                  ref.read(financeConstructionProvider).updateTerm(newValue);
                }
                else {
                  ref.read(financeConstructionProvider).updateTerm(0);
                }
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
