import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/refinance.dart';
import 'package:calculators/outputs/arv_cash_flow_statement.dart';
import 'package:calculators/outputs/cash_flow_statement.dart';
import 'package:calculators/outputs/report_fix_flip_holding_costs.dart';
import 'package:calculators/outputs/report_initial_cash_investment.dart';
import 'package:calculators/outputs/value_indicators.dart';
import 'package:calculators/outputs/zero_in_deal.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class Report extends ConsumerWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isRefinancing = ref.watch(brrrrProvider).wantsToRefinance;
    bool isCashOut =
        ref.watch(brrrrProvider).refinancingType == Refinancing.cashOut;
    bool shouldShow0inDeal = isRefinancing && isCashOut;
    bool shouldShowARVStatement = isRefinancing;

    Calculator calculatorType = ref.read(calculatorProvider).type;

    return MyInputPage(
      imageUri: 'images/report.svg',
      headerText: 'Report',
      subheadText: '',
      position: kBRRRRQuestions.indexOf(Report) + 1,
      totalQuestions: kBRRRRQuestions.length,
      onBack: () {
        String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
        bool shouldOverrideBackButton = savedCalculatorID != '';
        if (shouldOverrideBackButton) {
          Get.off(() => const HoldingCosts());
        }
        else {
          Get.back();
        }
      },
      onSubmit: () {},
      child: ResponsiveLayout(
        children: [
          (calculatorType == Calculator.fixAndFlip)
              ? const FixFlipHoldingCosts()
              : Container(),
          const ReportInitialCashInvestment(),
          const CashFlowStatement(),
          (shouldShow0inDeal && calculatorType == Calculator.brrrr)
              ? const ZeroInDeal()
              : Container(),
          (shouldShowARVStatement) ? const ARVCashFlowStatement() : Container(),
          (calculatorType == Calculator.fixAndFlip)
              ? const ValueIndicators()
              : Container(),
        ],
      ),
    );
  }
}
