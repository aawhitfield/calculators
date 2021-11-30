// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

enum Refinancing{
  cashOut,
  noCashOut,
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
}

class RefinanceOptions extends ChangeNotifier {
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
    this.interestRate = 0, this.term = 0, this.closingCosts = 0, this.monthlyPayment = 0,
  });

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

}