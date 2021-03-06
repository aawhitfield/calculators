import 'package:calculators/globals.dart';
import 'package:calculators/models/brrrr.dart';
import 'package:calculators/outputs/colored_percent_list_tile.dart';
import 'package:calculators/outputs/expenses_expansion_tile.dart';
import 'package:calculators/outputs/income_expansion_tile.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/colored_money_list_tile.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/numerical_list_tile.dart';
import 'package:calculators/widgets/percent_list_tile.dart';
import 'package:calculators/widgets/report_header.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:finance/finance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ARVCashFlowStatement extends ConsumerStatefulWidget {
  const ARVCashFlowStatement({
    Key? key,
  }) : super(key: key);

  @override
  _ARVCashFlowStatementState createState() => _ARVCashFlowStatementState();
}

class _ARVCashFlowStatementState extends ConsumerState<ARVCashFlowStatement> {

  @override
  Widget build(BuildContext context) {
    BRRRR provider = ref.watch(brrrrProvider);
    double income = provider.totalIncome;
    double expenses = provider.afterRepairTotalExpensesMonthly;
    double noi = income - expenses;
    double debtService = Finance.pmt(
      rate: provider.refinancingInterestRate / 12,
      nper: provider.refinancingTerm * 12,
      pv: -1 * provider.refinancingLoanAmount,
    ) as double;
    double cashFlow = noi - debtService;
    double yearlyCashFlow = cashFlow * 12;
    double initialCash = provider.downPaymentAmount +
        provider.constructionDownPaymentAmount +
        provider.closingCosts;
    double cashOnCashReturn = yearlyCashFlow / initialCash * 100;
    double dscr = noi / debtService;
    double onePercentRule =
        provider.afterRepairRentPerMonth / provider.afterRepairValue * 100;

    String noiString = kCurrencyFormat.format(noi);
    String debtServiceString = kCurrencyFormat.format(debtService);
    String cashFlowString = kCurrencyFormat.format(cashFlow);
    String yearlyCashFlowString = kCurrencyFormat.format(yearlyCashFlow);
    String cashOnCashReturnString = cashOnCashReturn.toStringAsFixed(2);
    String dscrString = dscr.toStringAsFixed(2);
    String onePercentRuleString = onePercentRule.toStringAsFixed(3);

    return Column(
      children: [
        const ReportHeader('Monthly ARV Cash Flow Statement'),
        const SizedBox(height: 16),
        const IncomeExpansionTile(),
        const ExpensesExpansionTile(),
        MoneyListTile('NOI', noiString),
        MoneyListTile('Debt Service', debtServiceString),
        ColoredMoneyListTile(
          value: cashFlow,
          smallScreenTitle: 'Cashflow',
          largeScreenTitle: 'Cashflow',
          valueString: cashFlowString,
        ),
        ColoredMoneyListTile(
            value: yearlyCashFlow,
            smallScreenTitle: 'Yearly\nCashflow',
            largeScreenTitle: 'Yearly Cashflow',
            valueString: yearlyCashFlowString),
        const SizedBox(height: 16),
        Text('Refinance Metrics', style: Theme.of(context).textTheme.headline5),
        const Divider(),
        ColoredPercentListTile(
            value: cashOnCashReturn,
            smallScreenTitle: 'Cash on\nCash Return',
            largeScreenTitle: 'Cash on Cash Return',
            valueString: cashOnCashReturnString),
        NumericalListTile('Debt Service\nCoverage Ratio', dscrString),
        PercentListTile('1% Rule', onePercentRuleString),
        const SizedBox(height: 32),
      ],
    );
  }
}
