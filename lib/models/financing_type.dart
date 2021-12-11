// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

enum FinancingType {
  commercial,
  commercialWithConstruction,
  conventional,
  hardMoney,
  hardMoneyWithConstruction,
}

enum PaymentType {
  principalAndInterest,
  interestOnly,
}

const String tableFinance = 'finance';

class FinanceFields {
  static final List<String> values = [
    id, financingType, loanPercent, interestRate, term, closingCosts, paymentTypeType,
  ];

  static const String id = '_id';
  static const String financingType = 'financingType';
  static const String loanPercent = 'loanPercent';
  static const String interestRate = 'interestRate';
  static const String term = 'term';
  static const String closingCosts = 'closingCosts';
  static const String paymentTypeType = 'paymentTypeType';

}


class FinancingTypeUtils {
  final FinancingType financingType;

  FinancingTypeUtils(this.financingType);

  String get name {
    switch(financingType) {
      case FinancingType.commercial : return 'Commercial';
      case FinancingType.commercialWithConstruction : return 'Commercial + Construction';
      case FinancingType.conventional : return 'Conventional';
      case FinancingType.hardMoney : return 'Hard Money';
      case FinancingType.hardMoneyWithConstruction : return 'Hard Money + Construction';
    }
  }

  static FinancingType getFinancingType(String name) {
    if (name == 'Commercial + Construction') {
      return FinancingType.commercialWithConstruction;
    } else if (name == 'Conventional') {
      return FinancingType.conventional;
    } else if (name == 'Hard Money') {
      return FinancingType.hardMoney;
    } else if (name == 'Hard Money + Construction') {
      return FinancingType.hardMoneyWithConstruction;
    } else {
      return FinancingType.commercial;
    }
  }
}

class PaymentTypeUtils {
  final PaymentType paymentType;

  PaymentTypeUtils(this.paymentType);

  String get name {
    switch(paymentType) {
      case PaymentType.principalAndInterest : return 'Principal & Interest';
      case PaymentType.interestOnly : return 'Interest Only';
    }
  }

  static PaymentType getPaymentType(String name) {
    if (name == 'Interest Only') {
      return PaymentType.interestOnly;
    } else {
      return PaymentType.principalAndInterest;
    }
  }
}

class FinanceOptionData extends ChangeNotifier {
  int? id;
  FinancingType financingType;
  double loanPercentage;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double closingCosts;
  double monthlyPayment;
  bool willRefinance;
  PaymentType paymentType;

  FinanceOptionData({this.financingType = FinancingType.commercial,
    this.loanPercentage = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.closingCosts = 0, this.monthlyPayment = 0,
    this.willRefinance = false, this.paymentType = PaymentType.principalAndInterest, this.id,
  });

  FinanceOptionData copy({
    int? id,
    FinancingType? financingType,
    double? loanPercentage,
    double? loanAmount,
    double? downPaymentAmount,
    double? interestRate,
    int? term,
    double? closingCosts,
    double? monthlyPayment,
    bool? willRefinance,
    PaymentType? paymentType,
  }) => FinanceOptionData(
      id: id ?? this.id,
      financingType: financingType ?? this.financingType,
      loanPercentage: loanPercentage ?? this.loanPercentage,
      loanAmount: loanAmount ?? this.loanAmount,
      downPaymentAmount: downPaymentAmount ?? this.downPaymentAmount,
      interestRate: interestRate ?? this.interestRate,
      term: term ?? this.term,
      closingCosts: closingCosts ?? this.closingCosts,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      willRefinance: willRefinance ?? this.willRefinance,
      paymentType: paymentType ?? this.paymentType,
  );

  Map<String, Object?> toJson() => {
    FinanceFields.id: id,
    FinanceFields.financingType: FinancingTypeUtils(financingType).name,
    FinanceFields.loanPercent: loanPercentage,
    FinanceFields.interestRate: interestRate,
    FinanceFields.term: term,
    FinanceFields.closingCosts: closingCosts,
    FinanceFields.paymentTypeType: PaymentTypeUtils(paymentType).name
  };

  static FinanceOptionData fromJson(Map<String, Object?> json) => FinanceOptionData(
    id: json[FinanceFields.id] as int?,
    financingType: FinancingTypeUtils.getFinancingType(json[FinanceFields.financingType] as String),
    loanPercentage: json[FinanceFields.loanPercent] as double,
    interestRate: json[FinanceFields.interestRate] as double,
    term: json[FinanceFields.term] as int,
    closingCosts: json[FinanceFields.closingCosts] as double,
    paymentType: PaymentTypeUtils.getPaymentType(json[FinanceFields.paymentTypeType] as String),
  );

  void updateFinanceOptionData(FinanceOptionData newFinanceOptionData) {
    id = newFinanceOptionData.id;
    financingType = newFinanceOptionData.financingType;
    loanPercentage = newFinanceOptionData.loanPercentage;
    interestRate = newFinanceOptionData.interestRate;
    term = newFinanceOptionData.term;
    closingCosts = newFinanceOptionData.closingCosts;
    paymentType = newFinanceOptionData.paymentType;
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

  void updateClosingCosts(newValue) {
    closingCosts = newValue;
    notifyListeners();
  }

  void updateMonthlyPayment(newValue) {
    monthlyPayment = newValue;
    notifyListeners();
  }

  void updatePaymentType(PaymentType newValue) {
    paymentType = newValue;
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

  void updateWillRefinance(bool newValue) {
    willRefinance = newValue;
    notifyListeners();
  }

  void reset() {
    financingType = FinancingType.commercial;
    loanPercentage = 0;
    loanAmount = 0;
    downPaymentAmount = 0;
    interestRate = 0;
    term = 0;
    closingCosts = 0;
    monthlyPayment = 0;
    willRefinance = false;
    paymentType = PaymentType.principalAndInterest;
    id = null;
    notifyListeners();
  }
}