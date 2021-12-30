// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

import 'financing_type.dart';


const String tableFinanceConstruction = 'financeConstruction';

class FinanceConstructionFields {
  static final List<String> values = [
    id, loanPercent, interestRate, term
  ];

  static const String id = '_id';
  static const String loanPercent = 'loanPercent';
  static const String interestRate = 'interestRate';
  static const String term = 'term';

}

class FinanceOptionConstructionProvider extends ChangeNotifier {
  int? id;
  FinancingType financingType;
  double loanPercentage;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double monthlyPayment;

  FinanceOptionConstructionProvider({this.financingType = FinancingType.commercial,
    this.loanPercentage = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.monthlyPayment = 0, this.id,
  });

  FinanceOptionConstructionProvider copy({
    int? id,
    FinancingType? financingType,
    double? loanPercentage,
    double? loanAmount,
    double? downPaymentAmount,
    double? interestRate,
    int? term,
    double? monthlyPayment,
  }) => FinanceOptionConstructionProvider(
    id: id ?? this.id,
    financingType: financingType ?? this.financingType,
    loanPercentage: loanPercentage ?? this.loanPercentage,
    loanAmount: loanAmount ?? this.loanAmount,
    downPaymentAmount: downPaymentAmount ?? this.downPaymentAmount,
    interestRate: interestRate ?? this.interestRate,
    term: term ?? this.term,
    monthlyPayment: monthlyPayment ?? this.monthlyPayment,
  );

  Map<String, Object?> toJson() => {
    FinanceConstructionFields.id: id,
    FinanceConstructionFields.loanPercent: loanPercentage,
    FinanceConstructionFields.interestRate: interestRate,
    FinanceConstructionFields.term: term,
  };

  static FinanceOptionConstructionProvider fromJson(Map<String, Object?> json) => FinanceOptionConstructionProvider(
    // id: json[FinanceFields.id] as int?,
    // financingType: FinancingTypeUtils.getFinancingType(json[FinanceFields.financingType] as String),
    // loanPercentage: json[FinanceFields.loanPercent] as double,
    // interestRate: json[FinanceFields.interestRate] as double,
    // term: json[FinanceFields.term] as int,
  );

  void updateFinanceOptionConstruction(FinanceOptionConstructionProvider newFinanceOptionConstructionProvider) {
    id = newFinanceOptionConstructionProvider.id;
    financingType = newFinanceOptionConstructionProvider.financingType;
    loanPercentage = newFinanceOptionConstructionProvider.loanPercentage;
    interestRate = newFinanceOptionConstructionProvider.interestRate;
    term = newFinanceOptionConstructionProvider.term;
    notifyListeners();
  }

  void updateFinancingType(newValue) {
    financingType = newValue;
    notifyListeners();
  }

  void updateLoanPercentage(newValue) {
    loanPercentage = newValue;
    notifyListeners();
  }

  void updateLoanAmount(newValue) {
    loanAmount = newValue;
    notifyListeners();
  }

  void updateDownPayment(newValue) {
    downPaymentAmount = newValue;
    notifyListeners();
  }

  void updateInterestRate(newValue) {
    interestRate = newValue;
    notifyListeners();
  }

  void updateTerm(newValue) {
    term = newValue;
    notifyListeners();
  }

  void updateMonthlyPayment(newValue) {
    monthlyPayment = newValue;
    notifyListeners();
  }

  double calculateMonthlyPayment({
    required num rate, required num nper, required num pv}) {
        return Finance.pmt(rate: rate, nper: nper, pv: pv).toDouble();
  }

  double calculateMonthlyPaymentInterestOnly({
    required num rate, required num nper, required num pv, required num per}) {
        double payment = Finance.ipmt(rate: rate, per: per, nper: nper, pv: pv).toDouble();
        return payment;
  }

  void reset() {
    financingType = FinancingType.commercial;
    loanPercentage = 0;
    loanAmount = 0;
    downPaymentAmount = 0;
    interestRate = 0;
    term = 0;
    monthlyPayment = 0;
    id = null;
    notifyListeners();
  }
}