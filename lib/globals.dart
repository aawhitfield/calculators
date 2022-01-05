import 'package:calculators/inputs/brrrr/expenses_input.dart';
import 'package:calculators/inputs/brrrr/finance_option_construction_loan.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/finance_options.dart';
import 'package:calculators/inputs/brrrr/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/inputs/brrrr/income_input.dart';
import 'package:calculators/inputs/brrrr/location.dart';
import 'package:calculators/inputs/brrrr/property_costs.dart';
import 'package:calculators/inputs/brrrr/renovations_calculator.dart';
import 'package:calculators/outputs/report.dart';
import 'package:intl/intl.dart';

import 'inputs/brrrr/refinance_input.dart';

List<Type> kBRRRRQuestions = [
  Location,
  RenovationsCalculator,
  PropertyCosts,
  IncomeInput,
  ExpensesInput,
  FinanceOptions,
  FinanceOptionConstructionLoan,
  FinanceOptionSellerFinanced,
  RefinanceInput,
  HoldingCosts,
  FixAndFlipSellingCostsInput,
  Report,
];

NumberFormat kCurrencyFormat = NumberFormat("#,##0.00", "en_US");
NumberFormat kWholeNumber = NumberFormat("###.#", "en_US");

String kGoogleAPIkey = 'AIzaSyD60flaZZs5lNOKU0uzCOiJ4uhYwmwHtuo';