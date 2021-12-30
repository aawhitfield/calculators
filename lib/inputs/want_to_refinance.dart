import 'package:calculators/globals.dart';
import 'package:calculators/inputs/refinance_input.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class WantToRefinance extends ConsumerWidget {
  const WantToRefinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInputPage(
      imageUri: 'images/question.svg',
      headerText: 'Refinance',
      subheadText: '',
      onSubmit: () {
        if (ref.read(brrrrProvider).wantsToRefinance) {
          Get.to(() => const RefinanceInput());
        } else {
          Get.to(() => const Report());
        }
      },
      position: kResidentialREIQuestions.indexOf(WantToRefinance) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      child: const ResponsiveLayout(
        children: [

        ],
      ),
    );
  }
}
