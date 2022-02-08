import 'package:calculators/inputs/brrrr/expenses_input.dart';
import 'package:calculators/inputs/brrrr/finance_option_construction_loan.dart';
import 'package:calculators/inputs/brrrr/finance_option_seller_financed.dart';
import 'package:calculators/inputs/brrrr/finance_options.dart';
import 'package:calculators/inputs/fixflip/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/inputs/brrrr/holding_costs.dart';
import 'package:calculators/inputs/brrrr/income_input.dart';
import 'package:calculators/inputs/brrrr/location.dart';
import 'package:calculators/inputs/brrrr/property_costs.dart';
import 'package:calculators/inputs/brrrr/refinance_input.dart';
import 'package:calculators/inputs/brrrr/renovations_calculator.dart';
import 'package:calculators/inputs/fixflip/ff_expenses_input.dart';
import 'package:calculators/inputs/fixflip/ff_finance_construction.dart';
import 'package:calculators/inputs/fixflip/ff_finance_options.dart';
import 'package:calculators/inputs/fixflip/ff_finance_seller_financed.dart';
import 'package:calculators/inputs/fixflip/ff_holding_costs.dart';
import 'package:calculators/inputs/fixflip/ff_location.dart';
import 'package:calculators/inputs/fixflip/ff_property_costs.dart';
import 'package:calculators/inputs/fixflip/ff_renovations_calculator.dart';
import 'package:calculators/inputs/turnkey/tr_expenses_input.dart';
import 'package:calculators/inputs/turnkey/tr_finance_options.dart';
import 'package:calculators/inputs/turnkey/tr_income_input.dart';
import 'package:calculators/inputs/turnkey/tr_property_costs.dart';
import 'package:calculators/models/turnkey_rental_type.dart';
import 'package:calculators/outputs/fix_flip_statement.dart';
import 'package:calculators/outputs/report.dart';
import 'package:calculators/outputs/turnkey/report_turnkey_rental.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


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
  Report,
];

List<Type> kFixFlipQuestions = [
  FixFlipLocation,
  FixFlipRenovationsCalculator,
  FixFlipPropertyCosts,
  FixFlipExpensesInput,
  FixFlipFinanceOptions,
  FixFlipFinanceConstruction,
  FixFlipFinanceSellerFinanced,
  FixFlipHoldingCosts,
  FixAndFlipSellingCostsInput,
  FixFlipStatement,
];

List<Type> kTurnKeyRentalQuestions = [
  TurnkeyRental,
  TurnkeyRentalPropertyCosts,
  TurnkeyRentalIncomeInput,
  TurnkeyRentalExpensesInput,
  TurnkeyRentalFinanceOptions,
  TurnkeyRentalReport,
];

NumberFormat kCurrencyFormat = NumberFormat("#,##0.00", "en_US");
NumberFormat kWholeNumber = NumberFormat("###.#", "en_US");

String kGoogleAPIkey = 'AIzaSyD60flaZZs5lNOKU0uzCOiJ4uhYwmwHtuo';

GlobalKey<FormState> turnkeyPropertyKey = GlobalKey<FormState>();
GlobalKey<FormState> turnkeySquareFeetKey = GlobalKey<FormState>();
GlobalKey<FormState> turnkeyPropertyCostsKey = GlobalKey<FormState>();
GlobalKey<FormState> turnkeyIncomeKey = GlobalKey<FormState>();
GlobalKey<FormState> ffAddressKey = GlobalKey<FormState>();