import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_option_down_payment.dart';
import 'package:calculators/inputs/refinance_input.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HoldingCosts extends ConsumerWidget {
  const HoldingCosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
        imageUri: 'images/holdingCosts.svg',
        headerText: 'Holding Costs',
        subheadText: '',
        position: kBRRRRQuestions.indexOf(HoldingCosts) + 1,
        totalQuestions: kBRRRRQuestions.length,
        onSubmit: () {
          FinancingType financingType = ref.read(brrrrProvider).financingType;
          bool wantsToRefinance = ref.read(brrrrProvider).wantsToRefinance;
          if (financingType == FinancingType.sellerFinancing) {
            Get.to(() => const FinanceOptionSellerFinanced());
          }
          else if(wantsToRefinance) {
            Get.to(() => const RefinanceInput());
          }
          else {
            Get.to(() => const Report());
          }
        },
      child: const ResponsiveLayout(
        children: [

        ],
      ),
    );
  }
}
