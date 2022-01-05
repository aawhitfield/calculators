import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class IsSellerFinanced extends ConsumerWidget {
  const IsSellerFinanced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      imageUri: 'images/question.svg',
      headerText: 'Seller Financed Loan',
      subheadText: 'Is any part of this loan seller financed?',
      onSubmit: () {
        if (true) {
          Get.to(() => const FinanceOptionSellerFinanced());
        }
        // else {
        //   if (ref.read(calculatorProvider).type == Calculator.brrrr) {
        //     Get.to(() => const WantToRefinance());
        //   }
        //   else {
        //     double realtorsFees = ref.watch(brrrrProvider).afterRepairValue *
        //         ref.watch(ffSellingCostsProvider).realtorFeesPercentage;
        //     ref.read(ffSellingCostsProvider).updateRealtorFees(realtorsFees);
        //
        //     int numberOfMonthsToRehabRent =
        //         ref.read(brrrrProvider).monthsToRehabRent;
        //     double taxes = ref.watch(brrrrProvider).taxesYearly;
        //     if (numberOfMonthsToRehabRent != 0) {
        //       taxes = taxes / numberOfMonthsToRehabRent;
        //     }
        //     ref.read(ffSellingCostsProvider).updateTaxes(taxes);
        //     double other = ref.watch(brrrrProvider).afterRepairValue * 0.02;
        //     ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
        //     ref.read(ffSellingCostsProvider).calculateTotal();
        //     Get.to(() => const FixAndFlipSellingCostsInput());
        //   }
        // }
      },
      position: kBRRRRQuestions.indexOf(IsSellerFinanced) + 1,
      totalQuestions: kBRRRRQuestions.length,
      child: const ResponsiveLayout(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: CupertinoSlidingSegmentedControl<bool>(
          //     groupValue: ref.watch(optionsProvider).isSellerFinanced,
          //     thumbColor: Theme.of(context).primaryColor.withOpacity(0.5),
          //     children: const {
          //       true: Padding(
          //         padding: EdgeInsets.all(16),
          //         child: Text('Yes'),
          //       ),
          //       false: Padding(
          //         padding: EdgeInsets.all(16),
          //         child: Text('No'),
          //       ),
          //     },
          //     onValueChanged: (bool? newValue) {
          //       ref.read(optionsProvider).updateIsSellerFinanced(newValue!);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
