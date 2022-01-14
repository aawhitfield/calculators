import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/refinance.dart';
import 'package:calculators/outputs/arv_cash_flow_statement.dart';
import 'package:calculators/outputs/cash_flow_statement.dart';
import 'package:calculators/outputs/report_fix_flip_holding_costs.dart';
import 'package:calculators/outputs/report_initial_purchase.dart';
import 'package:calculators/outputs/value_indicators.dart';
import 'package:calculators/outputs/report_refinance.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class Report extends ConsumerStatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  int tab = 0;

  late bool isRefinancing;
  late bool isCashOut;
  late bool shouldShow0inDeal;
  late bool shouldShowARVStatement;
  late Calculator calculatorType;
  late List<List<Widget>> children;

  @override
  void initState() {
    isRefinancing = ref.read(brrrrProvider).wantsToRefinance;
    isCashOut =
        ref.read(brrrrProvider).refinancingType == Refinancing.cashOut;
    shouldShow0inDeal = isRefinancing && isCashOut;
    shouldShowARVStatement = isRefinancing;
    calculatorType = ref.read(calculatorProvider).type;

    children = [[const ReportInitialPurchase(),
      const CashFlowStatement(),], [(shouldShow0inDeal && calculatorType == Calculator.brrrr)
        ? const ReportRefinance()
        : Container(),
      (shouldShowARVStatement) ? const ARVCashFlowStatement() : Container(),]];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
          CupertinoSlidingSegmentedControl<int>(
            thumbColor: Theme.of(context).primaryColor.withOpacity(0.4),
            groupValue: tab,
            children: const {
              0: Text('Initial Purchase'),
              1: Text('Refinance'),
            },
            onValueChanged: (int? newTab) {
              if (mounted) {
                setState(() {
                  tab = newTab!;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          ...children[tab],
          (calculatorType == Calculator.fixAndFlip)
              ? const ValueIndicators()
              : Container(),
        ],
      ),
    );
  }
}
