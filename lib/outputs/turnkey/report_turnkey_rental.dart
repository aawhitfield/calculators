import 'package:calculators/globals.dart';
import 'package:calculators/inputs/turnkey/tr_finance_options.dart';
import 'package:calculators/outputs/turnkey/turnkey_cash_flow_statement.dart';
import 'package:calculators/outputs/turnkey/turnkey_report_initial_purchase.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TurnkeyRentalReport extends ConsumerWidget {
  const TurnkeyRentalReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MyInputPage(
      imageUri: 'images/report.svg',
      headerText: 'Report',
      subheadText: '',
      position: kTurnKeyRentalQuestions.indexOf(TurnkeyRentalReport) + 1,
      totalQuestions: kTurnKeyRentalQuestions.length,
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const TurnkeyRentalFinanceOptions());
        }
        else {
          Get.back();
        }
      },
      onSubmit: () {},
      child: const ResponsiveLayout(
        children: [
          TurnkeyReportInitialPurchase(),
          TurnkeyCashFlowStatement(),
        ],
      ),
    );
  }
}
