// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:finance/finance.dart';
import 'package:flutter/foundation.dart';

class QuickMaxFields {
  static final List<String> values = [
    calculatorType, address, arv, purchasePrice, rehab, financingType,
    downPaymentPercentage, interestRate, termInYears,
    closingCosts, taxesPerYear, insurancePerYear,
    utilitiesPerMonth, paymentType, monthsOfHolding, rehabCosts,
  ];

  static const String calculatorType = 'calculatorType';
  static const String address = 'address';
  static const String arv = 'arv';
  static const String purchasePrice = 'purchasePrice';
  static const String rehab = 'rehab';
  static const String financingType = 'financingType';
  static const String downPaymentPercentage = 'downPaymentPercentage';
  static const String interestRate = 'interestRate';
  static const String termInYears = 'termInYears';
  static const String closingCosts = 'closingCosts';
  static const String taxesPerYear = 'taxesPerYear';
  static const String insurancePerYear = 'insurancePerYear';
  static const String utilitiesPerMonth = 'utilitiesPerMonth';
  static const String paymentType = 'paymentType';
  static const String monthsOfHolding = 'monthsOfHolding';
  static const String rehabCosts = 'rehabCosts';
  }

class QuickMaxOffer with ChangeNotifier {
  Calculator calculatorType;
  String address;
  double arv;
  double purchasePrice;
  double rehab;
  double totalHoldingCosts;
  FinancingType financingType;
  double downPaymentPercentage;
  double loanAmount;
  double downPayment;
  double interestRate;
  int termInYears;
  double closingCosts;
  double taxesPerYear;
  double taxesPerMonth;
  double insurancePerYear;
  double insurancePerMonth;
  double utilitiesPerMonth;
  PaymentType paymentType;
  double monthlyPayment;
  int monthsOfHolding;
  double rehabCosts;
  double maxOffer;
  double rehabFunds;

  QuickMaxOffer({
    this.calculatorType = Calculator.quickMaxOffer,
    this.address = '',
    this.arv = 0,
    this.purchasePrice = 0,
    this.rehab = 0,
    this.totalHoldingCosts = 0,
    this.financingType = FinancingType.commercial,
    this.downPaymentPercentage = 0,
    this.loanAmount = 0,
    this.downPayment = 0,
    this.interestRate = 0,
    this.termInYears = 0,
    this.closingCosts = 0,
    this.taxesPerMonth = 0,
    this.taxesPerYear = 0,
    this.insurancePerYear = 0,
    this.insurancePerMonth = 0,
    this.utilitiesPerMonth = 0,
    this.paymentType = PaymentType.principalAndInterest,
    this.monthlyPayment = 0,
    this.monthsOfHolding = 0,
    this.rehabCosts = 0,
    this.maxOffer = 0,
    this.rehabFunds = 0,
  });

  Map<String, Object?> toJson() =>
      {
        QuickMaxFields.calculatorType: CalculatorUtils.getName(calculatorType),
        QuickMaxFields.address: address,
        QuickMaxFields.arv: arv,
        QuickMaxFields.purchasePrice: purchasePrice,
        QuickMaxFields.rehab: rehab,
        QuickMaxFields.financingType: financingType.name,
        QuickMaxFields.downPaymentPercentage: downPaymentPercentage,
        QuickMaxFields.interestRate: interestRate,
        QuickMaxFields.termInYears: termInYears,
        QuickMaxFields.closingCosts: closingCosts,
        QuickMaxFields.taxesPerYear: taxesPerYear,
        QuickMaxFields.insurancePerYear: insurancePerYear,
        QuickMaxFields.utilitiesPerMonth: utilitiesPerMonth,
        QuickMaxFields.paymentType: PaymentTypeUtils(paymentType).name,
        QuickMaxFields.monthsOfHolding: monthsOfHolding,
        QuickMaxFields.rehabCosts: rehabCosts,
      };

  static QuickMaxOffer fromJson(Map<String, Object?> json) => QuickMaxOffer(
      calculatorType: CalculatorUtils.toType(json[QuickMaxFields.calculatorType] as String),
      address: json[QuickMaxFields.address] as String,
      arv: json[QuickMaxFields.arv] as double,
      purchasePrice: (json.containsKey('purchasePrice')) ? (json[QuickMaxFields.purchasePrice] as double) : 0,
      rehab: (json.containsKey('rehab')) ? (json[QuickMaxFields.rehab] as double) : 0,
      financingType: FinancingTypeUtils.getFinancingType(json[QuickMaxFields.financingType] as String),
      downPaymentPercentage: json[QuickMaxFields.downPaymentPercentage] as double,
      interestRate: json[QuickMaxFields.interestRate] as double,
      termInYears: json[QuickMaxFields.termInYears] as int,
      closingCosts: json[QuickMaxFields.closingCosts] as double,
      taxesPerYear: json[QuickMaxFields.taxesPerYear] as double,
      insurancePerYear: json[QuickMaxFields.insurancePerYear] as double,
      utilitiesPerMonth: json[QuickMaxFields.utilitiesPerMonth] as double,
      paymentType: (json.containsKey('paymentType')) ? PaymentTypeUtils.getPaymentType(json[QuickMaxFields.paymentType] as String) : PaymentType.principalAndInterest,
      monthsOfHolding: json[QuickMaxFields.monthsOfHolding] as int,
      rehabCosts: json[QuickMaxFields.rehabCosts] as double,
  );

  void updateAll(QuickMaxOffer data) {
    calculatorType = data.calculatorType;
    address = data.address;
    arv = data.arv;
    purchasePrice = data.purchasePrice;
    rehab = data.rehab;
    totalHoldingCosts = data.totalHoldingCosts;
    financingType = data.financingType;
    downPaymentPercentage = data.downPaymentPercentage;
    loanAmount = data.loanAmount;
    downPayment = data.downPayment;
    interestRate = data.interestRate;
    termInYears = data.termInYears;
    closingCosts = data.closingCosts;
    taxesPerYear = data.taxesPerYear;
    taxesPerMonth = data.taxesPerMonth;
    insurancePerYear = data.insurancePerYear;
    insurancePerMonth = data.insurancePerMonth;
    utilitiesPerMonth = data.utilitiesPerMonth;
    paymentType = data.paymentType;
    monthlyPayment = data.monthlyPayment;
    monthsOfHolding = data.monthsOfHolding;
    rehabCosts = data.rehabCosts;
    maxOffer = data.maxOffer;
  }

  void calculateLoanAmount() {
    loanAmount = arv - downPayment;
    notifyListeners();
  }

  void calculateDownPayment() {
    downPayment = (1 - downPaymentPercentage) * arv;
    notifyListeners();
  }

  void calculateTaxesPerMonth() {
    taxesPerMonth = taxesPerYear / 12;
    notifyListeners();
  }

  void calculateInsurancePerMonth() {
    insurancePerMonth = insurancePerYear / 12;
    notifyListeners();
  }

  void calculateTotalHoldingCosts() {
    if(paymentType == PaymentType.principalAndInterest) {
      monthlyPayment = calculateMonthlyPayment(rate: interestRate / 12, nper: termInYears * 12, pv: -1 * loanAmount);
    } else if(paymentType == PaymentType.interestOnly) {
      monthlyPayment = calculateMonthlyPaymentInterestOnly(rate: interestRate / 12, nper: termInYears, pv: -1 * loanAmount, per: 1);
    }
    totalHoldingCosts = (taxesPerMonth +
            insurancePerMonth +
            utilitiesPerMonth +
            monthlyPayment) *
        monthsOfHolding;
    notifyListeners();
  }

  void calculateMaxOffer() {
    maxOffer = arv - rehab - totalHoldingCosts - closingCosts - downPayment;
    rehabFunds = maxOffer - purchasePrice;
    notifyListeners();
  }

  void calculateAllQuickMaxOffer() {
    calculateLoanAmount();
    calculateDownPayment();
    calculateTaxesPerMonth();
    calculateInsurancePerMonth();
    calculateTotalHoldingCosts();
    calculateMaxOffer();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updateAfterRepairValue(double newAfterRepairValue) {
    arv = newAfterRepairValue;
    notifyListeners();
  }

  void updatePurchasePrice(double newValue) {
    purchasePrice = newValue;
    notifyListeners();
  }

  void updateRehab(double newValue) {
    rehab = newValue;
    notifyListeners();
  }

  void updateFinancingType(newValue) {
    financingType = newValue;
    notifyListeners();
  }

  void updateDownPaymentPercentage(newValue) {
    downPaymentPercentage = newValue;
    notifyListeners();
  }

  void updateInterestRate(newValue) {
    interestRate = newValue;
    notifyListeners();
  }

  void updateTerm(newValue) {
    termInYears = newValue;
    notifyListeners();
  }

  void updateTaxesPerYear(newValue) {
    taxesPerYear = newValue;
    notifyListeners();
  }

  void updateInsurancePerYear(newValue) {
    insurancePerYear = newValue;
    notifyListeners();
  }

  void updateUtilitiesPerMonth(newValue) {
    utilitiesPerMonth = newValue;
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

  void updatePaymentType(PaymentType newValue) {
    paymentType = newValue;
    if(paymentType == PaymentType.principalAndInterest) {
      monthlyPayment = calculateMonthlyPayment(rate: interestRate / 12, nper: termInYears * 12, pv: -1 * loanAmount);
    } else if(paymentType == PaymentType.interestOnly) {
      monthlyPayment = calculateMonthlyPaymentInterestOnly(rate: interestRate / 12, nper: termInYears, pv: -1 * loanAmount, per: 1);
    }
    notifyListeners();
  }

  void updateMonthsOfHolding(newValue) {
    monthsOfHolding = newValue;
    notifyListeners();
  }

  void updateRehabCosts(newValue) {
    rehabCosts = newValue;
    notifyListeners();
  }

  void updateClosingCosts(newValue) {
    closingCosts = newValue;
    notifyListeners();
  }

  void reset() {
    calculatorType = Calculator.quickMaxOffer;
    address = '';
    arv = 0;
    purchasePrice = 0;
    rehab = 0;
    totalHoldingCosts = 0;
    financingType = FinancingType.commercial;
    downPaymentPercentage = 0;
    loanAmount = 0;
    downPayment = 0;
    interestRate = 0;
    termInYears = 0;
    closingCosts = 0;
    taxesPerMonth = 0;
    taxesPerYear = 0;
    insurancePerYear = 0;
    insurancePerMonth = 0;
    utilitiesPerMonth = 0;
    paymentType = PaymentType.principalAndInterest;
    monthlyPayment = 0;
    monthsOfHolding = 0;
    rehabCosts = 0;
    maxOffer = 0;
    rehabFunds = 0;
  }
}
