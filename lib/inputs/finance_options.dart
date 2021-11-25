import 'package:calculators/globals.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceOptions extends ConsumerWidget {
  const FinanceOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FinancingType value = ref.watch(financeProvider).financingType;

    double loanAmount = ref.watch(propertyProvider).purchasePrice *
        ref.watch(financeProvider).loanPercentage;

    double downPaymentAmount = ref.watch(propertyProvider).purchasePrice -
        ref.watch(financeProvider).loanAmount;

    // doubel monthlyPayment = TODO: calculate monthly payment

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String downPaymentString = kCurrencyFormat.format(downPaymentAmount);

    return MyInputPage(
      imageUri: 'images/finance.svg',
      headerText: 'Finance Options',
      subheadText: '',
      onSubmit: () {},
      position: kResidentialREIQuestions.indexOf(FinanceOptions) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      child: ResponsiveLayout(
        children: [
          Row(
            children: [
              const Text('Financing Type'),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<FinancingType>(
                  value: value,
                  items: FinancingType.values
                      .map((FinancingType financingType) =>
                          DropdownMenuItem<FinancingType>(
                              value: financingType,
                              child:
                                  Text(FinancingTypeUtils(financingType).name)))
                      .toList(),
                  onChanged: (FinancingType? newValue) {
                    ref.read(financeProvider).updateFinancingType(newValue);
                  },
                ),
              )
            ],
          ),
          PercentTextField(
            labelText: 'Loan Percent',
            onChanged: (String newPercentage) {
              newPercentage = newPercentage.replaceAll(',', '');
              double? newValue = double.tryParse(newPercentage);
              if (newValue != null) {
                double loanPercentage = newValue / 100;
                ref.read(financeProvider).updateLoanPercentage(loanPercentage);
                double purchasePrice = ref.read(propertyProvider).purchasePrice;
                double loanAmount = purchasePrice * loanPercentage;

                ref.read(financeProvider).updateLoanAmount(loanAmount);

                double downPayment = purchasePrice - loanAmount;
                ref.read(financeProvider).updateDownPayment(downPayment);
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
                ref.read(financeProvider).updateInterestRate(interestRate);
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
                ref.read(financeProvider).updateTerm(newValue);
              }
            },
          ),
          MoneyTextField(
            labelText: 'Closing Costs',
            onChanged: (String newCost) {
              newCost = newCost.replaceAll(',', '');
              double? newValue = double.tryParse(newCost);
              if (newValue != null) {
                ref.read(financeProvider).updateClosingCosts(newValue);
              }
            },
          ),
          // MoneyListTile('Monthly Payment', monthlyPaymentString), TODO: calculate monthly payment string
        ],
      ),
    );
  }
}
