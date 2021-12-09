import 'package:calculators/inputs/expenses_input.dart';
import 'package:calculators/inputs/finance_option_construction_loan.dart';
import 'package:calculators/inputs/finance_option_down_payment.dart';
import 'package:calculators/inputs/finance_options.dart';
import 'package:calculators/inputs/income_input.dart';
import 'package:calculators/inputs/is_seller_financed.dart';
import 'package:calculators/inputs/location.dart';
import 'package:calculators/inputs/property_costs.dart';
import 'package:calculators/inputs/refinance_input.dart';
import 'package:calculators/inputs/renovations_calculator.dart';
import 'package:calculators/inputs/want_to_refinance.dart';
import 'package:calculators/outputs/report.dart';
import 'package:intl/intl.dart';

List<Type> kResidentialREIQuestions = [
  Location,
  RenovationsCalculator,
  PropertyCosts,
  IncomeInput,
  ExpensesInput,
  FinanceOptions,
  FinanceOptionConstructionLoan,
  IsSellerFinanced,
  FinanceOptionDownPayment,
  WantToRefinance,
  RefinanceInput,
  Report,
];

NumberFormat kCurrencyFormat = NumberFormat("#,##0.00", "en_US");
NumberFormat kWholeNumber = NumberFormat("###.#", "en_US");

String kGoogleAPIkey = 'AIzaSyD60flaZZs5lNOKU0uzCOiJ4uhYwmwHtuo';