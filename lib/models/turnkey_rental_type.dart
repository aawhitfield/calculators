// organizes all information for a property

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/models/financing_type.dart';
import 'package:calculators/models/refinance.dart';
import 'package:finance/finance.dart';
import 'package:flutter/material.dart';

class TurnkeyRentalFields {
  static final List<String> values = [
    id, calculator, address, listPrice, sqft, afterRepairValue, purchasePrice,
    units, investors,
    rent, otherIncome,
    taxes, insurance, propertyManagementPercentage, vacancyPercentage, maintenancePercentage,
    otherExpensesPercentage,
    financingType, downPaymentPercent, interestRate, term, closingCosts,
  ];

  static const String id = 'id';
  static const String calculator = 'calculator';
  static const String address = 'address';
  static const String listPrice = 'listPrice';
  static const String sqft = 'sqft';
  static const String afterRepairValue = 'afterRepairValue';
  static const String purchasePrice = 'purchasePrice';
  static const String monthsToRehabRent = 'monthsToRehabRent';
  static const String units = 'units';
  static const String investors = 'investors';
  static const String rent = 'rent';
  static const String otherIncome = 'otherIncome';
  static const String taxes = 'taxes';
  static const String insurance = 'insurance';
  static const String propertyManagementPercentage = 'propertyManagementPercentage';
  static const String vacancyPercentage = 'vacancyPercentage';
  static const String maintenancePercentage = 'maintenancePercentage';
  static const String otherExpensesPercentage = 'otherExpensesPercentage';
  static const String financingType = 'financingType';
  static const String downPaymentPercent = 'downPaymentPercent';
  static const String interestRate = 'interestRate';
  static const String term = 'term';
  static const String closingCosts = 'closingCosts';
}

class TurnkeyRental extends ChangeNotifier{
  int? id;
  String address;
  double listPrice;
  int? sqft;
  double afterRepairValue;
  double purchasePrice;
  int units;
  int investors;
  double rent;
  double otherIncome;
  double totalIncome;
  double yearlyIncome;
  double taxesYearly;
  double taxesMonthly;
  double insuranceYearly;
  double insuranceMonthly;
  double propertyManagementPercentage;
  double propertyManagementMonthly;
  double vacancyPercentage;
  double vacancyMonthly;
  double maintenancePercentage;
  double maintenanceMonthly;
  double otherExpensesPercentage;
  double otherExpensesMonthly;
  double totalMonthlyExpenses;
  double totalAnnualExpenses;
  double noiMonthly;
  double noiAnnual;
  double afterRepairTotalExpensesMonthly;
  double afterRepairTotalExpensesYearly;
  double afterRepairNOIMonthly;
  double afterRepairNOIYearly;
  FinancingType financingType;
  double downPaymentPercent;
  double loanAmount;
  double downPaymentAmount;
  double interestRate;
  int term;
  double closingCosts;
  double monthlyPayment;
  bool willRefinance;
  double constructionDownPaymentPercentage;
  double constructionLoanAmount;
  double constructionDownPaymentAmount;
  double constructionInterestRate;
  int constructionTerm;
  double constructionMonthlyPayment;
  double debtService;
  double insuranceAndTaxes;
  double holdingCostsUtilities;
  double totalHoldingCosts;
  SellerFinancingType sellerFinancingType;
  double sellerLoanPercentage;
  double sellerLoanAmount;
  double sellerInterestRate;
  int amortization;
  int sellerTerm;
  double sellerMonthlyPayment;
  Refinancing refinancingType;
  double refinancingLoanToValue;
  double refinancingLoanAmount;
  double refinancingDownPaymentAmount;
  double refinancingInterestRate;
  int refinancingTerm;
  double refinancingClosingCosts;
  double refinancingMonthlyPayment;

  TurnkeyRental({this.id, this.address = '', this.listPrice = 0, this.sqft,
    this.afterRepairValue = 0, this.purchasePrice = 0,
    this.units = 0, this.investors = 0,
    this.rent = 0, this.otherIncome = 0, this.totalIncome = 0,
    this.yearlyIncome = 0,
    this.taxesYearly = 0, this.taxesMonthly = 0, this.propertyManagementPercentage = 0,
    this.propertyManagementMonthly = 0, this.vacancyPercentage = 0, this.vacancyMonthly = 0,
    this.maintenancePercentage = 0, this.maintenanceMonthly = 0, this.otherExpensesPercentage = 0,
    this.otherExpensesMonthly = 0, this.totalMonthlyExpenses = 0, this.totalAnnualExpenses = 0,
    this.noiMonthly = 0, this.noiAnnual = 0, this.insuranceMonthly = 0, this.insuranceYearly = 0,
    this.afterRepairNOIMonthly = 0, this.afterRepairNOIYearly = 0, this.afterRepairTotalExpensesMonthly = 0, 
    this.afterRepairTotalExpensesYearly = 0,
    this.financingType = FinancingType.commercial,
    this.downPaymentPercent = 0, this.loanAmount = 0, this.downPaymentAmount = 0,
    this.interestRate = 0, this.term = 0, this.closingCosts = 0, this.monthlyPayment = 0,
    this.willRefinance = false,
    this.constructionDownPaymentPercentage = 0, this.constructionLoanAmount = 0, this.constructionDownPaymentAmount = 0,
    this.constructionInterestRate = 0, this.constructionTerm = 0, this.constructionMonthlyPayment = 0,
    this.debtService = 0, this.insuranceAndTaxes = 0, this.holdingCostsUtilities = 0,
    this.totalHoldingCosts = 0,
    this.sellerFinancingType = SellerFinancingType.payment,
    this.sellerLoanPercentage = 0, this.sellerLoanAmount = 0,
    this.sellerInterestRate = 0, this.amortization = 0, this.sellerTerm = 0, this.sellerMonthlyPayment = 0,
    this.refinancingType = Refinancing.cashOut,
    this.refinancingLoanToValue = 0, this.refinancingLoanAmount = 0, this.refinancingDownPaymentAmount = 0,
    this.refinancingInterestRate = 0, this.refinancingTerm = 0, this.refinancingClosingCosts = 0, this.refinancingMonthlyPayment = 0,
  });
  

  Map<String, Object?> toJson() => {
    TurnkeyRentalFields.id: id,
    TurnkeyRentalFields.address: address,
    TurnkeyRentalFields.listPrice: listPrice,
    TurnkeyRentalFields.sqft: sqft,
    TurnkeyRentalFields.afterRepairValue: afterRepairValue,
    TurnkeyRentalFields.purchasePrice: purchasePrice,
    TurnkeyRentalFields.units: units,
    TurnkeyRentalFields.investors: investors,
    TurnkeyRentalFields.rent: rent,
    TurnkeyRentalFields.otherIncome: otherIncome,
    TurnkeyRentalFields.taxes: taxesYearly,
    TurnkeyRentalFields.insurance: insuranceYearly,
    TurnkeyRentalFields.propertyManagementPercentage: propertyManagementPercentage,
    TurnkeyRentalFields.vacancyPercentage: vacancyPercentage,
    TurnkeyRentalFields.maintenancePercentage: maintenancePercentage,
    TurnkeyRentalFields.otherExpensesPercentage: otherExpensesPercentage,
    TurnkeyRentalFields.financingType: FinancingTypeUtils(financingType).name,
    TurnkeyRentalFields.downPaymentPercent: downPaymentPercent,
    TurnkeyRentalFields.interestRate: interestRate,
    TurnkeyRentalFields.term: term,
    TurnkeyRentalFields.closingCosts: closingCosts,
    'calculatorType': 'Turnkey Rental',
  };

  static TurnkeyRental fromJson(Map<String, Object?> json) => TurnkeyRental(
    id: json[TurnkeyRentalFields.id] as int?,
      address: json[TurnkeyRentalFields.address] as String,
      listPrice: json[TurnkeyRentalFields.listPrice] as double,
      sqft: json[TurnkeyRentalFields.sqft] as int?,
      afterRepairValue: json[TurnkeyRentalFields.afterRepairValue] as double,
      purchasePrice:  json[TurnkeyRentalFields.purchasePrice] as double,
      units: json[TurnkeyRentalFields.units] as int,
      investors: json[TurnkeyRentalFields.investors] as int,
      rent: json[TurnkeyRentalFields.rent] as double,
      otherIncome:  json[TurnkeyRentalFields.otherIncome] as double,
      taxesYearly: json[TurnkeyRentalFields.taxes] as double,
      insuranceYearly: json[TurnkeyRentalFields.insurance] as double,
      propertyManagementPercentage: json[TurnkeyRentalFields.propertyManagementPercentage] as double,
      vacancyPercentage: json[TurnkeyRentalFields.vacancyPercentage] as double,
      maintenancePercentage: json[TurnkeyRentalFields.maintenancePercentage] as double,
      otherExpensesPercentage:  json[TurnkeyRentalFields.otherExpensesPercentage] as double,
      financingType: FinancingTypeUtils.getFinancingType(json[TurnkeyRentalFields.financingType] as String),
      downPaymentPercent: json[TurnkeyRentalFields.downPaymentPercent] as double,
      interestRate: json[TurnkeyRentalFields.interestRate] as double,
      term: json[TurnkeyRentalFields.term] as int,
      closingCosts: json[TurnkeyRentalFields.closingCosts] as double,
  );

  void updateAll(TurnkeyRental data) {
    id = data.id;
    address = data.address;
    listPrice = data.listPrice;
    sqft = data.sqft;
    afterRepairValue = data.afterRepairValue;
    purchasePrice = data.purchasePrice;
    units = data.units;
    investors = data.investors;
    rent = data.rent;
    otherIncome = data.otherIncome;
    totalIncome = data.totalIncome;
    yearlyIncome = data.yearlyIncome;
    taxesYearly = data.taxesYearly;
    taxesMonthly = data.taxesMonthly;
    propertyManagementPercentage = data.propertyManagementPercentage;
    propertyManagementMonthly = data.propertyManagementMonthly;
    vacancyPercentage = data.vacancyPercentage;
    vacancyMonthly = data.vacancyMonthly;
    maintenancePercentage = data.maintenancePercentage;
    maintenanceMonthly = data.maintenanceMonthly;
    otherExpensesPercentage = data.otherExpensesPercentage;
    otherExpensesMonthly = data.otherExpensesMonthly;
    totalMonthlyExpenses = data.totalMonthlyExpenses;
    totalAnnualExpenses = data.totalAnnualExpenses;
    noiMonthly = data.noiMonthly;
    noiAnnual = data.noiAnnual;
    insuranceMonthly = data.insuranceMonthly;
    insuranceYearly = data.insuranceYearly;
    afterRepairNOIMonthly = data.afterRepairNOIMonthly;
    afterRepairNOIYearly = data.afterRepairNOIYearly;
    afterRepairTotalExpensesMonthly = data.afterRepairTotalExpensesMonthly;
    afterRepairTotalExpensesYearly = data.afterRepairTotalExpensesYearly;
    financingType = data.financingType;
    downPaymentPercent = data.downPaymentPercent;
    loanAmount = data.loanAmount;
    downPaymentAmount = data.downPaymentAmount;
    interestRate = data.interestRate;
    term = data.term;
    closingCosts = data.closingCosts;
    monthlyPayment = data.monthlyPayment;
    willRefinance = data.willRefinance;
    constructionDownPaymentPercentage = data.constructionDownPaymentPercentage;
    constructionLoanAmount = data.constructionLoanAmount;
    constructionDownPaymentAmount = data.constructionDownPaymentAmount;
    constructionInterestRate = data.constructionInterestRate;
    constructionTerm = data.constructionTerm;
    constructionMonthlyPayment = data.constructionMonthlyPayment;
    debtService = data.debtService;
    insuranceAndTaxes = data.insuranceAndTaxes;
    holdingCostsUtilities = data.holdingCostsUtilities;
    totalHoldingCosts = data.totalHoldingCosts;
    sellerFinancingType = data.sellerFinancingType;
    sellerLoanPercentage = data.sellerLoanPercentage;
    sellerLoanAmount = data.sellerLoanAmount;
    sellerInterestRate = data.sellerInterestRate;
    amortization = data.amortization;
    sellerTerm = data.sellerTerm;
    sellerMonthlyPayment = data.sellerMonthlyPayment;
    refinancingType = data.refinancingType;
    refinancingLoanToValue = data.refinancingLoanToValue;
    refinancingLoanAmount = data.refinancingLoanAmount;
    refinancingDownPaymentAmount = data.refinancingDownPaymentAmount;
    refinancingInterestRate = data.refinancingInterestRate;
    refinancingTerm = data.refinancingTerm;
    refinancingClosingCosts = data.refinancingClosingCosts;
    refinancingMonthlyPayment = data.refinancingMonthlyPayment;
    calculateAll();
    notifyListeners();
  }

  void calculateAll() {
    calculateAllExpenses();
    calculateTotalIncome();
    calculateYearlyIncome();
    calculateAfterRepairTotalExpensesMonthly();
    calculateNOIMonthly();
    calculateNOIAnnually();
    calculateLoanAmount();
    calculateDownPaymentAmount();
  }

  void calculateDownPaymentAmount() {
    loanAmount = (1 - downPaymentPercent) * purchasePrice;
    downPaymentAmount = purchasePrice - loanAmount;
    notifyListeners();
  }

  void updateProperty(TurnkeyRental newProperty) {
    id = newProperty.id;
    address = newProperty.address;
    listPrice = newProperty.listPrice;
    sqft = newProperty.sqft;
    afterRepairValue = newProperty.afterRepairValue;
    purchasePrice = newProperty.purchasePrice;
    units = newProperty.units;
    investors = newProperty.investors;
    notifyListeners();
  }


  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updateListPrice(double newListPrice) {
    listPrice = newListPrice;
    notifyListeners();
  }

  void updateSqft(int newSqft) {
    sqft = newSqft;
    notifyListeners();
  }

  void updateAfterRepairValue(double newAfterRepairValue) {
    afterRepairValue = newAfterRepairValue;
    notifyListeners();
  }

  void updatePurchasePrice(double newPurchasePrice) {
    purchasePrice = newPurchasePrice;
    notifyListeners();
  }

  void updateUnits (int newUnits) {
    units = newUnits;
    notifyListeners();
  }

  void updateInvestors (int newInvestors) {
    investors = newInvestors;
    notifyListeners();
  }

  void updateIncome(TurnkeyRental newIncome) {
    rent = newIncome.rent;
    otherIncome = newIncome.otherIncome;
    notifyListeners();
  }

  void updateRent(double newValue) {
    rent = newValue;
    notifyListeners();
  }

  void updateOtherIncome(double newValue) {
    otherIncome = newValue;
    notifyListeners();
  }

  void calculateTotalIncome() {
    totalIncome = rent + otherIncome;
    notifyListeners();
  }

  void calculateYearlyIncome() {
    yearlyIncome = totalIncome * 12;
    notifyListeners();
  }

  void updateExpenses(TurnkeyRental newExpense) {
    taxesYearly = newExpense.taxesYearly;
    propertyManagementPercentage = newExpense.propertyManagementPercentage;
    vacancyPercentage = newExpense.vacancyPercentage;
    maintenancePercentage = newExpense.maintenancePercentage;
    otherExpensesPercentage = newExpense.otherExpensesPercentage;
    notifyListeners();
  }

  void updateTaxes(double newValue) {
    taxesYearly = newValue;
    taxesMonthly = taxesYearly / 12;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateTaxesMonthly(double newValue) {
    taxesMonthly = newValue;
    taxesYearly = taxesMonthly * 12;
    calculateAllExpenses();
    notifyListeners();
  }

  void updateInsurance(double newValue) {
    insuranceYearly = newValue;
    insuranceMonthly = insuranceYearly / 12;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateInsuranceMonthly(double newValue) {
    insuranceMonthly = newValue;
    insuranceYearly = insuranceMonthly * 12;
    calculateAllExpenses();
    notifyListeners();
  }

  void updatePropertyManagement(double newValue) {
    propertyManagementPercentage = newValue;
    propertyManagementMonthly = propertyManagementPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updatePropertyManagementMonthly(double newValue) {
    propertyManagementMonthly = newValue;
    if (rent != 0) {
      propertyManagementPercentage = propertyManagementMonthly / rent;
    }
    else {
      propertyManagementPercentage = 0.0;
    }
    calculateAllExpenses();
    notifyListeners();
  }

  void updateVacancy(double newValue) {
    vacancyPercentage = newValue;
    vacancyMonthly = vacancyPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateVacancyMonthly(double newValue) {
    vacancyMonthly = newValue;
    if (rent != 0) {
      vacancyPercentage = vacancyMonthly / rent;
    }
    else {
      vacancyPercentage = 0.0;
    }
    calculateAllExpenses();
    notifyListeners();
  }

  void updateMaintenance(double newValue) {
    maintenancePercentage = newValue;
    maintenanceMonthly = maintenancePercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateMaintenanceMonthly(double newValue) {
    maintenanceMonthly = newValue;
    if(rent != 0) {
      maintenancePercentage = maintenanceMonthly / rent;
    }
    else {
      maintenancePercentage = 0.0;
    }
    calculateAllExpenses();
    notifyListeners();
  }

  void updateOther(double newValue) {
    otherExpensesPercentage = newValue;
    otherExpensesMonthly = otherExpensesPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateOtherMonthly(double newValue) {
    otherExpensesMonthly = newValue;
    if(rent != 0) {
      otherExpensesPercentage = otherExpensesMonthly / rent;
    }
    else {
      otherExpensesPercentage = 0.0;
    }
    calculateAllExpenses();
  }

  void updateTotalMonthlyExpenses(double newValue) {
    totalMonthlyExpenses = newValue;
    notifyListeners();
  }

  void updateTotalAnnualExpenses(double newValue) {
    totalAnnualExpenses = newValue;
    notifyListeners();
  }

  void updateNOIMonthly(double newValue) {
    noiMonthly = newValue;
    notifyListeners();
  }

  void updateNOIAnnual(double newValue) {
    noiAnnual = newValue;
    notifyListeners();
  }

  double calculateMonthlyTaxes() {
    taxesMonthly = taxesYearly / 12;
    notifyListeners();
    return taxesMonthly;
  }

  double calculateMonthlyInsurance() {
    insuranceMonthly = insuranceYearly / 12;
    notifyListeners();
    return insuranceMonthly;
  }

  double calculatePropertyManagement() {
    propertyManagementMonthly = propertyManagementPercentage * rent;
    notifyListeners();
    return propertyManagementMonthly;
  }

  double calculateVacancy() {
    vacancyMonthly = vacancyPercentage * rent;
    notifyListeners();
    return vacancyMonthly;
  }

  double calculateMaintenance() {
    maintenanceMonthly = maintenancePercentage * rent;
    notifyListeners();
    return maintenanceMonthly;
  }

  double calculateOtherExpenses() {
    otherExpensesMonthly = otherExpensesPercentage * rent;
    notifyListeners();
    return otherExpensesMonthly;
  }

  double calculateTotalExpensesMonthly() {
    totalMonthlyExpenses = taxesMonthly + insuranceMonthly +
        propertyManagementMonthly + vacancyMonthly + maintenanceMonthly
        + otherExpensesMonthly;
    totalAnnualExpenses = totalMonthlyExpenses * 12;
    updateTotalAnnualExpenses(totalAnnualExpenses);
    return totalMonthlyExpenses;
  }

  double calculateTotalExpensesYearly() {
    totalAnnualExpenses = totalMonthlyExpenses * 12;
    notifyListeners();
    return totalAnnualExpenses;
  }

  double calculateTotalAnnualExpenses() {
    totalAnnualExpenses = totalMonthlyExpenses * 12;
    return totalAnnualExpenses;
  }

  double calculateNOIMonthly() {
    noiMonthly = totalIncome - totalMonthlyExpenses;
    return noiMonthly;
  }

  double calculateNOIAnnually() {
    noiAnnual = totalIncome * 12 - totalAnnualExpenses;
    return noiAnnual;
  }

  double calculateAfterRepairTotalExpensesMonthly() {
    afterRepairTotalExpensesMonthly = taxesMonthly + insuranceMonthly
        + propertyManagementMonthly + vacancyMonthly + maintenanceMonthly
        + otherExpensesMonthly;
    notifyListeners();
    return afterRepairTotalExpensesMonthly;
  }

  double calculateAfterRepairTotalExpensesYearly() {
    afterRepairTotalExpensesYearly = afterRepairTotalExpensesMonthly * 12;
    notifyListeners();
    return afterRepairTotalExpensesYearly;
  }

  void calculateAllExpenses() {
    calculateMonthlyTaxes();
    calculateMonthlyInsurance();
    calculatePropertyManagement();
    calculateVacancy();
    calculateMaintenance();
    calculateOtherExpenses();
    calculateTotalExpensesMonthly();
    calculateTotalExpensesYearly();
    calculateNOIMonthly();
    calculateNOIAnnually();
    calculateAfterRepairTotalExpensesMonthly();
    calculateAfterRepairTotalExpensesYearly();
  }

  void updateFinanceOptionData(TurnkeyRental newFinanceOptionData) {
    id = newFinanceOptionData.id;
    financingType = newFinanceOptionData.financingType;
    downPaymentPercent = newFinanceOptionData.downPaymentPercent;
    interestRate = newFinanceOptionData.interestRate;
    term = newFinanceOptionData.term;
    closingCosts = newFinanceOptionData.closingCosts;
    notifyListeners();
  }

  void updateFinancingType(newValue) {
    financingType = newValue;
    notifyListeners();
  }

  void updateDownPaymentPercentage(newValue) {
    downPaymentPercent = newValue;
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

  void updateWillRefinance(bool newValue) {
    willRefinance = newValue;
    notifyListeners();
  }

  void calculateLoanAmount() {
    loanAmount = (1 - downPaymentPercent) * purchasePrice;
    notifyListeners();
  }

  void calculateAllFinanceOptions() {
    calculateLoanAmount();
  }


  void reset() {
    address = '';
    listPrice = 0;
    sqft = 0;
    afterRepairValue = 0;
    purchasePrice = 0;
    units = 0;
    investors = 0;
    id = null;
    rent = otherIncome = totalIncome = yearlyIncome = 0;
    taxesYearly = taxesMonthly = insuranceMonthly = insuranceYearly =
        propertyManagementPercentage = propertyManagementMonthly = vacancyPercentage
    = vacancyMonthly = maintenancePercentage = maintenanceMonthly = otherExpensesPercentage
    = otherExpensesMonthly = totalMonthlyExpenses = totalAnnualExpenses = noiMonthly = noiAnnual = 0;
    afterRepairTotalExpensesMonthly = afterRepairTotalExpensesYearly =
      afterRepairNOIMonthly = afterRepairNOIYearly = 0;
    financingType = FinancingType.commercial;
    downPaymentPercent = 0;
    loanAmount = 0;
    downPaymentAmount = 0;
    interestRate = 0;
    term = 0;
    closingCosts = 0;
    monthlyPayment = 0;
    willRefinance = false;
    constructionDownPaymentPercentage = 0;
    constructionLoanAmount = 0;
    constructionDownPaymentAmount = 0;
    constructionInterestRate = 0;
    constructionTerm = 0;
    constructionMonthlyPayment = 0;
    sellerFinancingType = SellerFinancingType.payment;
    sellerLoanPercentage = sellerLoanAmount = sellerInterestRate = 0;
    sellerTerm = 0;
    refinancingType = Refinancing.cashOut;
    refinancingLoanToValue = refinancingLoanAmount = refinancingDownPaymentAmount = 0;
    refinancingInterestRate = 0;
    refinancingTerm = 0;
    refinancingClosingCosts = refinancingMonthlyPayment = 0;
    notifyListeners();
  }
}