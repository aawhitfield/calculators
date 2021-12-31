// organizes all information for a property

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/models/financing_type.dart';
import 'package:finance/finance.dart';
import 'package:flutter/material.dart';

class BRRRRFields {
  static final List<String> values = [
    id, calculator, address, listPrice, sqft, afterRepairValue, purchasePrice, monthsToRehabRent,
    units, investors,
    foundation, roof, airConditioner, painting, kitchen, windows, plumbing,
    flooring, bathrooms, appliances, electrical, yard, cleaning, baseboards, exterior,
    demo, elevators, build28, otherRenovations, tenPercent, totalRenovations,
    rent, otherIncome, afterRepairRentPerMonth, afterRepairOtherIncome,
    taxes, insurance, propertyManagementPercentage, vacancyPercentage, maintenancePercentage,
    otherExpensesPercentage,
    financingType, downPaymentPercent, interestRate, term, closingCosts, paymentTypeType, wantsToRefinance,
    constructionDownPaymentPercentage, constructionInterestRate, constructionTerm,

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
  static const String foundation = 'foundation';
  static const String roof = 'roof';
  static const String airConditioner = 'airConditioner';
  static const String painting = 'painting';
  static const String kitchen = 'kitchen';
  static const String windows = 'windows';
  static const String plumbing = 'plumbing';
  static const String flooring = 'flooring';
  static const String bathrooms = 'bathrooms';
  static const String appliances = 'appliances';
  static const String electrical = 'electrical';
  static const String yard = 'yard';
  static const String cleaning = 'cleaning';
  static const String baseboards = 'baseboards';
  static const String exterior = 'exterior';
  static const String demo = 'demo';
  static const String elevators = 'elevators';
  static const String build28 = 'build28';
  static const String otherRenovations = 'otherRenovations';
  static const String tenPercent = 'tenPercent';
  static const String totalRenovations = 'totalRenovations';
  static const String rent = 'rent';
  static const String otherIncome = 'otherIncome';
  static const String afterRepairRentPerMonth = 'afterRepairRentPerMonth';
  static const String afterRepairOtherIncome = 'afterRepairOtherIncome';
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
  static const String paymentTypeType = 'paymentTypeType';
  static const String wantsToRefinance = 'wantsToRefinance';
  static const String constructionDownPaymentPercentage = 'constructionDownPaymentPercentage';
  static const String constructionInterestRate = 'constructionInterestRate';
  static const String constructionTerm = 'constructionTerm';
}

class BRRRR extends ChangeNotifier{
  int? id;
  String address;
  double listPrice;
  int? sqft;
  double afterRepairValue;
  double purchasePrice;
  int monthsToRehabRent;
  int units;
  int investors;
  double foundation;
  double roof;
  double airConditioner;
  double paintingPatching;
  double kitchen;
  double windows;
  double plumbing;
  double flooring;
  double bathrooms;
  double appliances;
  double electrical;
  double yard;
  double cleaning;
  double baseboards;
  double exterior;
  double demo;
  double elevators;
  double build28Units;
  double otherRenovations;
  double totalRenovations;
  double tenPercentExtra;
  double rent;
  double otherIncome;
  double totalIncome;
  double yearlyIncome;
  double afterRepairRentPerMonth;
  double afterRepairOtherIncome;
  double totalIncomeAfterRepair;
  double yearlyIncomeAfterRepair;
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
  PaymentType paymentType;
  bool wantsToRefinance;
  double constructionDownPaymentPercentage;
  double constructionLoanAmount;
  double constructionDownPaymentAmount;
  double constructionInterestRate;
  int constructionTerm;
  double constructionMonthlyPayment;

  BRRRR({this.id, required this.address, required this.listPrice, this.sqft,
    this.afterRepairValue = 0, this.purchasePrice = 0, this.monthsToRehabRent = 0,
    this.units = 0, this.investors = 0,
    this.foundation = 0, this.roof = 0, this.airConditioner = 0,
    this.paintingPatching = 0, this.kitchen = 0, this.windows = 0,
    this. plumbing = 0, this.flooring = 0, this.bathrooms = 0,
    this.appliances = 0, this.electrical = 0, this.yard = 0, this.cleaning = 0,
    this.baseboards = 0, this.exterior = 0, this.demo = 0, this.elevators = 0,
    this.build28Units = 0, this.otherRenovations = 0, this.totalRenovations = 0, this.tenPercentExtra = 0,
    this.rent = 0, this.otherIncome = 0, this.totalIncome = 0,
    this.yearlyIncome = 0, this.afterRepairRentPerMonth = 0, this.afterRepairOtherIncome = 0,
    this.totalIncomeAfterRepair = 0, this.yearlyIncomeAfterRepair = 0,
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
    this.willRefinance = false, this.paymentType = PaymentType.principalAndInterest,
    this.wantsToRefinance = false,
    this.constructionDownPaymentPercentage = 0, this.constructionLoanAmount = 0, this.constructionDownPaymentAmount = 0,
    this.constructionInterestRate = 0, this.constructionTerm = 0, this.constructionMonthlyPayment = 0,
  });
  

  Map<String, Object?> toJson() => {
    BRRRRFields.id: id,
    BRRRRFields.address: address,
    BRRRRFields.listPrice: listPrice,
    BRRRRFields.sqft: sqft,
    BRRRRFields.afterRepairValue: afterRepairValue,
    BRRRRFields.purchasePrice: purchasePrice,
    BRRRRFields.monthsToRehabRent: monthsToRehabRent,
    BRRRRFields.units: units,
    BRRRRFields.investors: investors,
    BRRRRFields.foundation: foundation,
    BRRRRFields.roof: roof,
    BRRRRFields.airConditioner: airConditioner,
    BRRRRFields.painting: paintingPatching,
    BRRRRFields.kitchen: kitchen,
    BRRRRFields.windows: windows,
    BRRRRFields.plumbing: plumbing,
    BRRRRFields.flooring: flooring,
    BRRRRFields.bathrooms: bathrooms,
    BRRRRFields.appliances: appliances,
    BRRRRFields.electrical: electrical,
    BRRRRFields.yard: yard,
    BRRRRFields.cleaning: cleaning,
    BRRRRFields.baseboards: baseboards,
    BRRRRFields.exterior: exterior,
    BRRRRFields.demo: demo,
    BRRRRFields.elevators: elevators,
    BRRRRFields.build28: build28Units,
    BRRRRFields.otherRenovations: otherRenovations,
    BRRRRFields.tenPercent: tenPercentExtra,
    BRRRRFields.totalRenovations: totalRenovations,
    BRRRRFields.rent: rent,
    BRRRRFields.otherIncome: otherIncome,
    BRRRRFields.afterRepairRentPerMonth: afterRepairRentPerMonth,
    BRRRRFields.afterRepairOtherIncome: afterRepairOtherIncome,
    BRRRRFields.taxes: taxesYearly,
    BRRRRFields.insurance: insuranceYearly,
    BRRRRFields.propertyManagementPercentage: propertyManagementPercentage,
    BRRRRFields.vacancyPercentage: vacancyPercentage,
    BRRRRFields.maintenancePercentage: maintenancePercentage,
    BRRRRFields.otherExpensesPercentage: otherExpensesPercentage,
    BRRRRFields.financingType: FinancingTypeUtils(financingType).name,
    BRRRRFields.downPaymentPercent: downPaymentPercent,
    BRRRRFields.interestRate: interestRate,
    BRRRRFields.term: term,
    BRRRRFields.closingCosts: closingCosts,
    BRRRRFields.paymentTypeType: PaymentTypeUtils(paymentType).name,
    BRRRRFields.wantsToRefinance: wantsToRefinance,
    BRRRRFields.constructionDownPaymentPercentage: constructionDownPaymentPercentage,
    BRRRRFields.constructionInterestRate: constructionInterestRate,
    BRRRRFields.constructionTerm: constructionTerm,
  };

  static BRRRR fromJson(Map<String, Object?> json) => BRRRR(
    id: json[BRRRRFields.id] as int?,
      address: json[BRRRRFields.address] as String,
      listPrice: json[BRRRRFields.listPrice] as double,
      sqft: json[BRRRRFields.sqft] as int?,
      afterRepairValue: json[BRRRRFields.afterRepairValue] as double,
      purchasePrice:  json[BRRRRFields.purchasePrice] as double,
      monthsToRehabRent: json[BRRRRFields.monthsToRehabRent] as int,
      units: json[BRRRRFields.units] as int,
      investors: json[BRRRRFields.investors] as int,
      foundation: json[BRRRRFields.foundation] as double,
      roof: json[BRRRRFields.roof] as double,
      airConditioner: json[BRRRRFields.airConditioner] as double,
      paintingPatching: json[BRRRRFields.painting] as double,
      kitchen: json[BRRRRFields.kitchen] as double,
      windows: json[BRRRRFields.windows] as double,
      plumbing: json[BRRRRFields.plumbing] as double,
      flooring: json[BRRRRFields.flooring] as double,
      bathrooms: json[BRRRRFields.bathrooms] as double,
      appliances: json[BRRRRFields.appliances] as double,
      electrical: json[BRRRRFields.electrical] as double,
      yard: json[BRRRRFields.yard] as double,
      cleaning: json[BRRRRFields.cleaning] as double,
      baseboards: json[BRRRRFields.baseboards] as double,
      exterior: json[BRRRRFields.exterior] as double,
      demo: json[BRRRRFields.demo] as double,
      elevators: json[BRRRRFields.elevators] as double,
      build28Units: json[BRRRRFields.build28] as double,
      otherRenovations: json[BRRRRFields.otherRenovations] as double,
      tenPercentExtra: json[BRRRRFields.tenPercent] as double,
      totalRenovations: json[BRRRRFields.totalRenovations] as double,
      rent: json[BRRRRFields.rent] as double,
      otherIncome:  json[BRRRRFields.otherIncome] as double,
      afterRepairRentPerMonth:  json[BRRRRFields.afterRepairRentPerMonth] as double,
      afterRepairOtherIncome:  json[BRRRRFields.afterRepairOtherIncome] as double,
      taxesYearly: json[BRRRRFields.taxes] as double,
      insuranceYearly: json[BRRRRFields.insurance] as double,
      propertyManagementPercentage: json[BRRRRFields.propertyManagementPercentage] as double,
      vacancyPercentage: json[BRRRRFields.vacancyPercentage] as double,
      maintenancePercentage: json[BRRRRFields.maintenancePercentage] as double,
      otherExpensesPercentage:  json[BRRRRFields.otherExpensesPercentage] as double,
      financingType: FinancingTypeUtils.getFinancingType(json[BRRRRFields.financingType] as String),
      downPaymentPercent: json[BRRRRFields.downPaymentPercent] as double,
      interestRate: json[BRRRRFields.interestRate] as double,
      term: json[BRRRRFields.term] as int,
      closingCosts: json[BRRRRFields.closingCosts] as double,
      paymentType: PaymentTypeUtils.getPaymentType(json[BRRRRFields.paymentTypeType] as String),
      wantsToRefinance: (json[BRRRRFields.wantsToRefinance] as bool),
      constructionDownPaymentPercentage: json[BRRRRFields.constructionDownPaymentPercentage] as double,
      constructionInterestRate: json[BRRRRFields.constructionInterestRate] as double,
      constructionTerm: json[BRRRRFields.constructionTerm] as int,
  );

  void updateProperty(BRRRR newProperty) {
    id = newProperty.id;
    address = newProperty.address;
    listPrice = newProperty.listPrice;
    sqft = newProperty.sqft;
    afterRepairValue = newProperty.afterRepairValue;
    purchasePrice = newProperty.purchasePrice;
    monthsToRehabRent = newProperty.monthsToRehabRent;
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

  void updateMonthsToRehabRent(int newMonths) {
    monthsToRehabRent = newMonths;
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

  void updateTotalRenovations(double newTotal) {
    totalRenovations = newTotal;
    notifyListeners();
  }

  double calculateTotalRenovations() {
    totalRenovations = foundation + roof + airConditioner + paintingPatching + kitchen
        + windows + plumbing + flooring + bathrooms + appliances + electrical
        + yard + cleaning + baseboards + exterior + demo + elevators + build28Units
        + otherRenovations + tenPercentExtra;
    notifyListeners();
    return totalRenovations;
  }

  double calculateTenPercentExtra() {
    double subtotal = foundation + roof + airConditioner + paintingPatching + kitchen
        + windows + plumbing + flooring + bathrooms + appliances + electrical
        + yard + cleaning + baseboards + exterior + demo + elevators + build28Units
        + otherRenovations;
    tenPercentExtra = subtotal * 0.1;
    notifyListeners();
    return tenPercentExtra;
  }

  void updateFoundation(double newFoundation) {
    foundation = newFoundation;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateRoof(double newRoof) {
    roof = newRoof;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateAirConditioner(double newAirConditioner) {
    airConditioner = newAirConditioner;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updatePaintingPatching (double newPainting) {
    paintingPatching = newPainting;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateKitchen(double newKitchen) {
    kitchen = newKitchen;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateWindows (double newWindows) {
    windows = newWindows;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updatePlumbing(double newPlumbing) {
    plumbing = newPlumbing;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateFlooring(double newFlooring) {
    flooring = newFlooring;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateBathrooms(double newBathrooms) {
    bathrooms = newBathrooms;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateAppliances(double newAppliances) {
    appliances = newAppliances;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateElectrical(double newElectrical) {
    electrical = newElectrical;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateYard(double newYard) {
    yard = newYard;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateCleaning(double newCleaning) {
    cleaning = newCleaning;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateBaseboards(double newBaseboards) {
    baseboards = newBaseboards;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateExterior(double newExterior) {
    exterior = newExterior;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateDemo(double newDemo) {
    demo = newDemo;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateElevators(double newElevators) {
    elevators = newElevators;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateBuildUnits(double newBuildUnits) {
    build28Units = newBuildUnits;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateOtherRenovations(double newOther) {
    otherRenovations = newOther;
    calculateTenPercentExtra();
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateRenovation(BRRRR newRenovation) {
    foundation = newRenovation.foundation;
    roof = newRenovation.roof;
    airConditioner = newRenovation.airConditioner;
    paintingPatching = newRenovation.paintingPatching;
    kitchen = newRenovation.kitchen;
    windows = newRenovation.windows;
    plumbing = newRenovation.plumbing;
    flooring = newRenovation.flooring;
    bathrooms = newRenovation.bathrooms;
    appliances = newRenovation.appliances;
    electrical = newRenovation.electrical;
    yard = newRenovation.yard;
    cleaning = newRenovation.cleaning;
    baseboards = newRenovation.baseboards;
    exterior = newRenovation.exterior;
    demo = newRenovation.demo;
    elevators = newRenovation.elevators;
    build28Units = newRenovation.build28Units;
    otherRenovations = newRenovation.otherRenovations;
    totalRenovations = newRenovation.totalRenovations;
    tenPercentExtra = newRenovation.tenPercentExtra;
    notifyListeners();
  }

  void updateIncome(BRRRR newIncome) {
    rent = newIncome.rent;
    otherIncome = newIncome.otherIncome;
    afterRepairRentPerMonth = newIncome.afterRepairRentPerMonth;
    afterRepairOtherIncome = newIncome.afterRepairOtherIncome;
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

  void updateRepairRentPerMonth(double newValue) {
    afterRepairRentPerMonth = newValue;
    notifyListeners();
  }

  void updateAfterRepairOtherIncome(double newValue) {
    afterRepairOtherIncome = newValue;
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

  void calculateTotalIncomeAfterRepair() {
    totalIncomeAfterRepair = afterRepairRentPerMonth + afterRepairOtherIncome;
    notifyListeners();
  }

  void calculateYearlyIncomeAfterRepair() {
    yearlyIncomeAfterRepair = totalIncomeAfterRepair * 12;
    notifyListeners();
  }

  void updateExpenses(BRRRR newExpense) {
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

  void updateInsurance(double newValue) {
    insuranceYearly = newValue;
    insuranceMonthly = insuranceYearly / 12;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updatePropertyManagement(double newValue) {
    propertyManagementPercentage = newValue;
    propertyManagementMonthly = propertyManagementPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateVacancy(double newValue) {
    vacancyPercentage = newValue;
    vacancyMonthly = vacancyPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateMaintenance(double newValue) {
    maintenancePercentage = newValue;
    maintenanceMonthly = maintenancePercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
  }

  void updateOther(double newValue) {
    otherExpensesPercentage = newValue;
    otherExpensesMonthly = otherExpensesPercentage * rent;
    updateTotalMonthlyExpenses(calculateTotalExpensesMonthly());
    notifyListeners();
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

  double calculateAfterRepairNOIMonthly() {
    afterRepairNOIMonthly = afterRepairRentPerMonth - afterRepairTotalExpensesMonthly;
    notifyListeners();
    return afterRepairNOIMonthly;
  }

  double calculateAfterRepairNOIYearly() {
    afterRepairNOIYearly = yearlyIncomeAfterRepair - afterRepairTotalExpensesYearly;
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
    calculateAfterRepairNOIMonthly();
    calculateAfterRepairNOIYearly();
  }

  void calculateAfterRepairExpenses() {
    afterRepairTotalExpensesMonthly = taxesMonthly + insuranceMonthly
        + propertyManagementMonthly + vacancyMonthly + maintenanceMonthly
        + otherExpensesMonthly;
    afterRepairTotalExpensesYearly = afterRepairTotalExpensesMonthly * 12;
    afterRepairNOIMonthly = afterRepairRentPerMonth - afterRepairTotalExpensesMonthly;
    afterRepairNOIYearly = yearlyIncome - afterRepairTotalExpensesYearly;
    notifyListeners();
  }

  void updateFinanceOptionData(BRRRR newFinanceOptionData) {
    id = newFinanceOptionData.id;
    financingType = newFinanceOptionData.financingType;
    downPaymentPercent = newFinanceOptionData.downPaymentPercent;
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

  void updateWantsToRefinance(bool newValue) {
    wantsToRefinance = newValue;
    notifyListeners();
  }

  void calculateLoanAmount() {
    loanAmount = (1 - downPaymentPercent) * purchasePrice;
    notifyListeners();
  }

  void calculateAllFinanceOptions() {
    calculateLoanAmount();
  }

  void updateFinanceOptionConstruction(BRRRR newFinanceOptionConstructionProvider) {
    constructionDownPaymentPercentage = newFinanceOptionConstructionProvider.constructionDownPaymentPercentage;
    constructionInterestRate = newFinanceOptionConstructionProvider.constructionInterestRate;
    constructionTerm = newFinanceOptionConstructionProvider.constructionTerm;
    notifyListeners();
  }

  void updateConstructionDownPaymentPercentage(newValue) {
    constructionDownPaymentPercentage = newValue;
    notifyListeners();
  }

  void updateConstructionLoanAmount(newValue) {
    constructionLoanAmount = newValue;
    notifyListeners();
  }

  void updateConstructionDownPayment(newValue) {
    constructionDownPaymentAmount = newValue;
    notifyListeners();
  }

  void updateConstructionInterestRate(newValue) {
    constructionInterestRate = newValue;
    notifyListeners();
  }

  void updateConstructionTerm(newValue) {
    constructionTerm = newValue;
    notifyListeners();
  }

  void updateConstructionMonthlyPayment(newValue) {
    constructionMonthlyPayment = newValue;
    notifyListeners();
  }

  void calculateAllConstructionCalculations() {
    constructionLoanAmount = (1 - constructionDownPaymentPercentage) * totalRenovations;
    constructionDownPaymentAmount = totalRenovations - constructionLoanAmount;
    notifyListeners();
  }

  void reset() {
    address = '';
    listPrice = 0;
    sqft = 0;
    afterRepairValue = 0;
    purchasePrice = 0;
    monthsToRehabRent = 0;
    units = 0;
    investors = 0;
    id = null;
    foundation = roof = airConditioner = paintingPatching = kitchen = windows
    = plumbing = flooring = bathrooms = appliances = electrical = yard
    = cleaning = baseboards = exterior = demo = elevators = build28Units
    = otherRenovations = totalRenovations = tenPercentExtra = 0;
    rent = otherIncome = totalIncome = yearlyIncome = afterRepairRentPerMonth
      = afterRepairOtherIncome = totalIncomeAfterRepair = yearlyIncomeAfterRepair = 0;
    taxesYearly = taxesMonthly = insuranceMonthly = insuranceYearly =
        propertyManagementPercentage = propertyManagementMonthly = vacancyPercentage
    = vacancyMonthly = maintenancePercentage = maintenanceMonthly = otherExpensesPercentage
    = otherExpensesMonthly = totalMonthlyExpenses = totalAnnualExpenses = noiMonthly = noiAnnual = 0;
    afterRepairTotalExpensesMonthly = afterRepairTotalExpensesYearly =
      afterRepairNOIMonthly = afterRepairNOIYearly = 0;
    financingType = FinancingType.commercial;
    downPaymentAmount = 0;
    loanAmount = 0;
    downPaymentAmount = 0;
    interestRate = 0;
    term = 0;
    closingCosts = 0;
    monthlyPayment = 0;
    willRefinance = false;
    paymentType = PaymentType.principalAndInterest;
    wantsToRefinance = false;
    constructionDownPaymentPercentage = 0;
    constructionLoanAmount = 0;
    constructionDownPaymentAmount = 0;
    constructionInterestRate = 0;
    constructionTerm = 0;
    constructionMonthlyPayment = 0;
    notifyListeners();
  }
}