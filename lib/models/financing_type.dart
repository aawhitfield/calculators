import 'package:flutter/foundation.dart';

enum FinancingType {
  commercial,
  construction,
  conventional,
  hardMoney,
  sellerFinance,
  sellerFinanceInterest,
}

class FinancingTypeUtils {
  final FinancingType financingType;

  FinancingTypeUtils(this.financingType);

  String get name {
    switch(financingType) {
      case FinancingType.commercial : return 'Commercial';
      case FinancingType.construction : return 'Construction';
      case FinancingType.conventional : return 'Conventional';
      case FinancingType.hardMoney : return 'Hard Money';
      case FinancingType.sellerFinance : return 'Seller Finance';
      case FinancingType.sellerFinanceInterest : return 'Seller Finance Interest';
    }
  }
}

class FinanceOptionData extends ChangeNotifier {
  FinancingType financingType;
  double loanPercentage;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double closingCosts;
  double monthlyPayment;

  FinanceOptionData({this.financingType = FinancingType.commercial,
    this.loanPercentage = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.closingCosts = 0, this.monthlyPayment = 0,
  });

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

  void updateClosingCosts(newValue) {
    closingCosts = newValue;
    notifyListeners();
  }

  void updateMonthlyPayment(newValue) {
    monthlyPayment = newValue;
    notifyListeners();
  }

  double calculateMonthlyPayment() {
    switch(financingType) {
      case FinancingType.conventional :
      case FinancingType.commercial :
      case FinancingType.sellerFinance :
        return 0; // TODO: Add monthly payment calculation
      case FinancingType.construction :
      case FinancingType.hardMoney :
      case FinancingType.sellerFinanceInterest :
        return 1;
    }
  }
}