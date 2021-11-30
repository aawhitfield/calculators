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

class FinanceOptionConstructionLoan extends ConsumerWidget {
  const FinanceOptionConstructionLoan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FinancingType value = ref.watch(financeProvider).financingType;

    double loanAmount = ref.watch(renovationsProvider).total *
        ref.watch(financeConstructionProvider).loanPercentage;

    double downPaymentAmount = ref.watch(renovationsProvider).total -
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
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double loanPercentage = newValue / 100;
                  ref.read(financeConstructionProvider).updateLoanPercentage(loanPercentage);
                  double purchasePrice = ref.read(propertyProvider).purchasePrice;
                  double loanAmount = purchasePrice * loanPercentage;

                  ref.read(financeConstructionProvider).updateLoanAmount(loanAmount);

                  double downPayment = purchasePrice - loanAmount;
                  ref.read(financeConstructionProvider).updateDownPayment(downPayment);
                }
              },
            ),
            MoneyListTile('Loan Amount', loanAmountString),
            MoneyListTile('Down Payment', downPaymentString),
            PercentTextField(
              labelText: 'Interest Rate',
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
              leftPadding: 8,
              rightPadding: 8,
              onChanged: (String newTerm) {
                newTerm = newTerm.replaceAll(',', '');
                int? newValue = int.tryParse(newTerm);
                if (newValue != null) {
                  ref.read(financeConstructionProvider).updateTerm(newValue);
                }
              },
            ),
            MoneyListTile('Monthly Payment', monthlyPaymentString),
          ],
        ),
    );
  }
}