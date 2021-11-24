import 'package:calculators/location.dart';
import 'package:calculators/property_costs.dart';
import 'package:calculators/renovations_calculator.dart';
import 'package:intl/intl.dart';

List<Type> kResidentialREIQuestions = [
  Location,
  RenovationsCalculator,
  PropertyCosts,
];

NumberFormat kCurrencyFormat = NumberFormat("#,##0.##", "en_US");