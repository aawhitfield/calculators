import 'package:calculators/globals.dart';
import 'package:calculators/outputs/cash_flow_statement.dart';
import 'package:calculators/outputs/report_initial_cash_investment.dart';
import 'package:calculators/outputs/report_total_loans.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Report extends ConsumerWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MyInputPage(
      imageUri: 'images/report.svg',
      headerText: 'Report',
      subheadText: '',
      position: kResidentialREIQuestions.indexOf(Report) + 1,
      totalQuestions: kResidentialREIQuestions.length,
      onSubmit: () {},
      child: const ResponsiveLayout(
        children: [
          ReportTotalLoans(),
          ReportInitialCashInvestment(),
          CashFlowStatement(),
        ],
      ),
    );
  }
}
