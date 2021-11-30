import 'package:calculators/globals.dart';
import 'package:calculators/inputs/want_to_refinance.dart';
import 'package:calculators/models/seller_financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class FinanceOptionDownPayment extends ConsumerWidget {
  const FinanceOptionDownPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SellerFinancingType value = ref.watch(sellerFinanceProvider).financingType;

    double loanAmount = ref.watch(propertyProvider).purchasePrice *
        ref.watch(sellerFinanceProvider).loanPercentage;

    double monthlyPayment = (ref.watch(sellerFinanceProvider).financingType ==
        SellerFinancingType.payment)
        ? ref.watch(sellerFinanceProvider).calculateMonthlyPayment(
      rate: ref.watch(sellerFinanceProvider).interestRate / 12,
      nper: ref.watch(sellerFinanceProvider).term * 12,
      pv: -1 * loanAmount,
    )
        : ref.watch(sellerFinanceProvider).calculateMonthlyPaymentInterestOnly(
      rate: ref.watch(sellerFinanceProvider).interestRate / 12,
      nper: ref.watch(sellerFinanceProvider).term,
      pv: -1 * loanAmount,
      per: 1,
    );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/transfer.svg',
        headerText: 'Finance Option',
        subheadText: 'Down Payment',
        onSubmit: () {
          Get.to(() => const WantToRefinance());
        },
        position: kResidentialREIQuestions.indexOf(FinanceOptionDownPayment) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            Row(
              children: [
                const Text('Financing Type'),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<SellerFinancingType>(
                    value: value,
                    items: SellerFinancingType.values
                        .map((SellerFinancingType sellerFinancingType) =>
                        DropdownMenuItem<SellerFinancingType>(
                            value: sellerFinancingType,
                            child:
                            Text(SellerFinancingTypeUtils(sellerFinancingType).name)))
                        .toList(),
                    onChanged: (SellerFinancingType? newValue) {
                      ref.read(sellerFinanceProvider).updateFinancingType(newValue);
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
                  ref.read(sellerFinanceProvider).updateLoanPercentage(loanPercentage);
                }
              },
            ),
            MoneyListTile('Loan Amount', loanAmountString),
            PercentTextField(
              labelText: 'Interest Rate',
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double interestRate = newValue / 100;
                  ref.read(sellerFinanceProvider).updateInterestRate(interestRate);
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
                  ref.read(sellerFinanceProvider).updateTerm(newValue);
                }
              },
            ),
            MoneyListTile('Monthly Payment', monthlyPaymentString),
          ],
        )
    );
  }
}
