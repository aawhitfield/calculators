// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

enum Refinancing{
  cashOut,
  noCashOut,
}

const String tableRefinance = 'refinance';

class RefinanceFields {
  static final List<String> values = [
    id, financingType, loanPercent, interestRate, term, closingCosts,
  ];

  static const String id = '_id';
  static const String financingType = 'financingType';
  static const String loanPercent = 'loanPercent';
  static const String interestRate = 'interestRate';
  static const String term = 'term';
  static const String closingCosts = 'closingCosts';

}


class RefinancingUtils {
  Refinancing refinancingMethod;

  RefinancingUtils(this.refinancingMethod);

  String get name {
    switch(refinancingMethod) {
      case Refinancing.cashOut : return 'Cash Out';
      case Refinancing.noCashOut : return 'No Cash Out';
    }
  }

  static Refinancing getFinancingType(String name) {
    if (name == 'No Cash Out') {
      return Refinancing.noCashOut;
    } else {
      return Refinancing.cashOut;
    }
  }
}

class RefinanceOptions extends ChangeNotifier {
  int? id;
  Refinancing refinancingMethod;
  double loanPercentage;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double closingCosts;
  double monthlyPayment;


  RefinanceOptions({this.refinancingMethod = Refinancing.cashOut,
    this.loanPercentage = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.closingCosts = 0, this.monthlyPayment = 0, this.id,
  });

  RefinanceOptions copy({
    int? id,
    Refinancing? refinancingMethod,
    double? loanPercentage,
    double? loanAmount,
    double? downPaymentAmount,
    double? interestRate,
    int? term,
    double? closingCosts,
    double? monthlyPayment,
  }) => RefinanceOptions(
    id: id ?? this.id,
    refinancingMethod: refinancingMethod ?? this.refinancingMethod,
    loanPercentage: loanPercentage ?? this.loanPercentage,
    loanAmount: loanAmount ?? this.loanAmount,
    downPaymentAmount: downPaymentAmount ?? this.downPaymentAmount,
    interestRate: interestRate ?? this.interestRate,
    term: term ?? this.term,
    closingCosts: closingCosts ?? this.closingCosts,
    monthlyPayment: monthlyPayment ?? this.monthlyPayment,
  );

  Map<String, Object?> toJson() => {
    RefinanceFields.id: id,
    RefinanceFields.financingType: RefinancingUtils(refinancingMethod).name,
    RefinanceFields.loanPercent: loanPercentage,
    RefinanceFields.interestRate: interestRate,
    RefinanceFields.term: term,
    RefinanceFields.closingCosts: closingCosts,
  };

  static RefinanceOptions fromJson(Map<String, Object?> json) => RefinanceOptions(
    id: json[RefinanceFields.id] as int?,
    refinancingMethod: RefinancingUtils.getFinancingType(json[RefinanceFields.financingType] as String),
    loanPercentage: json[RefinanceFields.loanPercent] as double,
    interestRate: json[RefinanceFields.interestRate] as double,
    term: json[RefinanceFields.term] as int,
    closingCosts: json[RefinanceFields.closingCosts] as double,
  );

  void updateRefinanceData(RefinanceOptions newFinanceOptionData) {
    id = newFinanceOptionData.id;
    refinancingMethod = newFinanceOptionData.refinancingMethod;
    loanPercentage = newFinanceOptionData.loanPercentage;
    interestRate = newFinanceOptionData.interestRate;
    term = newFinanceOptionData.term;
    closingCosts = newFinanceOptionData.closingCosts;
    notifyListeners();
  }

  void updateFinancingType(Refinancing newValue) {
    refinancingMethod = newValue;
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

  void updateClosingCosts(newValue) {
    closingCosts = newValue;
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
    return Finance.ipmt(rate: rate, per: per, nper: nper, pv: pv).toDouble();
  }

  void reset() {
    refinancingMethod = Refinancing.cashOut;
    loanPercentage = loanAmount = downPaymentAmount = 0;
    interestRate = 0;
    term = 0;
    closingCosts = monthlyPayment = 0;
    id = null;
    notifyListeners();
  }

}