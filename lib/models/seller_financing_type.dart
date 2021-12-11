// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

enum SellerFinancingType {
  payment,
  interest,
}

const String tableSellerFinance = 'finance_down_payment';

class SellerFinanceFields {
  static final List<String> values = [
    id, financingType, loanPercent, interestRate, term,
  ];

  static const String id = '_id';
  static const String financingType = 'financingType';
  static const String loanPercent = 'loanPercent';
  static const String interestRate = 'interestRate';
  static const String term = 'term';
}


class SellerFinancingTypeUtils {
  final SellerFinancingType sellerFinancingType;

  SellerFinancingTypeUtils(this.sellerFinancingType);

  String get name {
    switch(sellerFinancingType) {
      case SellerFinancingType.payment : return 'Seller Finance Repayment';
      case SellerFinancingType.interest : return 'Seller Finance Interest';
    }
  }

  static SellerFinancingType getFinancingType(String name) {
    if (name == 'Seller Finance Interest') {
      return SellerFinancingType.interest;
    } else {
      return SellerFinancingType.payment;
    }
  }
}

class SellerFinanceOptionData extends ChangeNotifier {
  int? id;
  SellerFinancingType financingType;
  double loanPercentage;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double monthlyPayment;

  SellerFinanceOptionData({this.financingType = SellerFinancingType.payment,
    this.loanPercentage = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.monthlyPayment = 0, this.id,
  });

  SellerFinanceOptionData copy({
    int? id,
    SellerFinancingType? financingType,
    double? loanPercentage,
    double? loanAmount,
    double? interestRate,
    int? term,
    double? monthlyPayment,
  }) => SellerFinanceOptionData(
    id: id ?? this.id,
    financingType: financingType ?? this.financingType,
    loanPercentage: loanPercentage ?? this.loanPercentage,
    loanAmount: loanAmount ?? this.loanAmount,
    interestRate: interestRate ?? this.interestRate,
    term: term ?? this.term,
    monthlyPayment: monthlyPayment ?? this.monthlyPayment,
  );

  Map<String, Object?> toJson() => {
    SellerFinanceFields.id: id,
    SellerFinanceFields.financingType: SellerFinancingTypeUtils(financingType).name,
    SellerFinanceFields.loanPercent: loanPercentage,
    SellerFinanceFields.interestRate: interestRate,
    SellerFinanceFields.term: term,

  };

  static SellerFinanceOptionData fromJson(Map<String, Object?> json) => SellerFinanceOptionData(
    id: json[SellerFinanceFields.id] as int?,
    financingType: SellerFinancingTypeUtils.getFinancingType(json[SellerFinanceFields.financingType] as String),
    loanPercentage: json[SellerFinanceFields.loanPercent] as double,
    interestRate: json[SellerFinanceFields.interestRate] as double,
    term: json[SellerFinanceFields.term] as int,
  );

  void updateSellerFinanceOptionData(SellerFinanceOptionData newFinanceOptionData) {
    id = newFinanceOptionData.id;
    financingType = newFinanceOptionData.financingType;
    loanPercentage = newFinanceOptionData.loanPercentage;
    interestRate = newFinanceOptionData.interestRate;
    term = newFinanceOptionData.term;
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
        return Finance.ipmt(rate: rate, per: per, nper: nper, pv: pv).toDouble();
  }


  void reset() {
    financingType = SellerFinancingType.payment;
    loanPercentage = loanAmount = downPaymentAmount = interestRate = 0;
    term = 0;
    id = null;
    notifyListeners();
  }
}