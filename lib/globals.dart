import 'package:calculators/inputs/expenses_input.dart';
import 'package:calculators/inputs/finance_options.dart';
import 'package:calculators/inputs/income_input.dart';
import 'package:calculators/inputs/location.dart';
import 'package:calculators/inputs/property_costs.dart';
import 'package:calculators/inputs/renovations_calculator.dart';
import 'package:intl/intl.dart';

List<Type> kResidentialREIQuestions = [
  Location,
  PropertyCosts,
  IncomeInput,
  ExpensesInput,
  RenovationsCalculator,
  FinanceOptions,
];

NumberFormat kCurrencyFormat = NumberFormat("#,##0.##", "en_US");