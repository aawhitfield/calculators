import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_option_down_payment.dart';
import 'package:calculators/inputs/want_to_refinance.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'fix_and_flip_selling_costs_input.dart';

class IsSellerFinanced extends ConsumerWidget {
  const IsSellerFinanced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      imageUri: 'images/question.svg',
      headerText: 'Seller Financed Loan',
      subheadText: 'Is any part of this loan seller financed?',
      onSubmit: () {
        if (ref.read(optionsProvider).isSellerFinanced) {
          Get.to(() => const FinanceOptionDownPayment());
        } else {
          if (ref.read(propertyProvider).calculator == Calculator.residentialREI) {
            Get.to(() => const WantToRefinance());
          }
          else {
            double realtorsFees = ref.watch(propertyProvider).afterRepairValue *
                ref.watch(ffSellingCostsProvider).realtorFeesPercentage;
            ref.read(ffSellingCostsProvider).updateRealtorFees(realtorsFees);

            int numberOfMonthsToRehabRent =
                ref.read(propertyProvider).monthsToRehabRent;
            double taxes = ref.watch(expensesProvider).taxes;
            if (numberOfMonthsToRehabRent != 0) {
              taxes = taxes / numberOfMonthsToRehabRent;
            }
            ref.read(ffSellingCostsProvider).updateTaxes(taxes);
            double other = ref.watch(propertyProvider).afterRepairValue * 0.02;
            ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
            ref.read(ffSellingCostsProvider).calculateTotal();
            Get.to(() => const FixAndFlipSellingCostsInput());
          }
        }
      },
      position: kResidentialREIQuestions.indexOf(IsSellerFinanced) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      child: ResponsiveLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CupertinoSlidingSegmentedControl<bool>(
              groupValue: ref.watch(optionsProvider).isSellerFinanced,
              thumbColor: Theme.of(context).primaryColor.withOpacity(0.5),
              children: const {
                true: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Yes'),
                ),
                false: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No'),
                ),
              },
              onValueChanged: (bool? newValue) {
                ref.read(optionsProvider).updateIsSellerFinanced(newValue!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
