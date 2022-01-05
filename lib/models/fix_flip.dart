// organizes all information for a property

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:calculators/models/financing_type.dart';
import 'package:calculators/models/refinance.dart';
import 'package:finance/finance.dart';
import 'package:flutter/material.dart';

class FixFlipFields {
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
    holdingCostsUtilities,
    sellerFinancingType, sellerLoanPercent, sellerInterestRate, amortization, sellerTerm,
    refinancingType, refinancingLoanToValue, refinancingInterestRate, refinancingTerm, refinancingClosingCosts,
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
  static const String holdingCostsUtilities = 'holdingCostsUtilities';
  static const String sellerFinancingType = 'sellerFinancingType';
  static const String sellerLoanPercent = 'sellerLoanPercent';
  static const String sellerInterestRate = 'sellerInterestRate';
  static const String amortization = 'amortization';
  static const String sellerTerm = 'sellerTerm';
  static const String refinancingType = 'refinancingType';
  static const String refinancingLoanToValue = 'refinancingLoanToValue';
  static const String refinancingInterestRate = 'refinancingInterestRate';
  static const String refinancingTerm = 'refinancingTerm';
  static const String refinancingClosingCosts = 'refinancingClosingCosts';
}

class FixFlip extends ChangeNotifier{
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
  double totalRenovations;
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

  FixFlip({this.id, this.address = '', this.listPrice = 0, this.sqft,
    this.afterRepairValue = 0, this.purchasePrice = 0, this.monthsToRehabRent = 0,
    this.units = 0, this.investors = 0,
    this.foundation = 0, this.roof = 0, this.airConditioner = 0,
    this.paintingPatching = 0, this.kitchen = 0, this.windows = 0,
    this. plumbing = 0, this.flooring = 0, this.bathrooms = 0,
    this.appliances = 0, this.electrical = 0, this.yard = 0, this.cleaning = 0,
    this.baseboards = 0, this.exterior = 0,
    this.totalRenovations = 0,
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
    FixFlipFields.id: id,
    FixFlipFields.address: address,
    FixFlipFields.listPrice: listPrice,
    FixFlipFields.sqft: sqft,
    FixFlipFields.afterRepairValue: afterRepairValue,
    FixFlipFields.purchasePrice: purchasePrice,
    FixFlipFields.monthsToRehabRent: monthsToRehabRent,
    FixFlipFields.units: units,
    FixFlipFields.investors: investors,
    FixFlipFields.foundation: foundation,
    FixFlipFields.roof: roof,
    FixFlipFields.airConditioner: airConditioner,
    FixFlipFields.painting: paintingPatching,
    FixFlipFields.kitchen: kitchen,
    FixFlipFields.windows: windows,
    FixFlipFields.plumbing: plumbing,
    FixFlipFields.flooring: flooring,
    FixFlipFields.bathrooms: bathrooms,
    FixFlipFields.appliances: appliances,
    FixFlipFields.electrical: electrical,
    FixFlipFields.yard: yard,
    FixFlipFields.cleaning: cleaning,
    FixFlipFields.baseboards: baseboards,
    FixFlipFields.exterior: exterior,
    FixFlipFields.totalRenovations: totalRenovations,
    FixFlipFields.rent: rent,
    FixFlipFields.otherIncome: otherIncome,
    FixFlipFields.afterRepairRentPerMonth: afterRepairRentPerMonth,
    FixFlipFields.afterRepairOtherIncome: afterRepairOtherIncome,
    FixFlipFields.taxes: taxesYearly,
    FixFlipFields.insurance: insuranceYearly,
    FixFlipFields.propertyManagementPercentage: propertyManagementPercentage,
    FixFlipFields.vacancyPercentage: vacancyPercentage,
    FixFlipFields.maintenancePercentage: maintenancePercentage,
    FixFlipFields.otherExpensesPercentage: otherExpensesPercentage,
    FixFlipFields.financingType: FinancingTypeUtils(financingType).name,
    FixFlipFields.downPaymentPercent: downPaymentPercent,
    FixFlipFields.interestRate: interestRate,
    FixFlipFields.term: term,
    FixFlipFields.closingCosts: closingCosts,
    FixFlipFields.paymentTypeType: PaymentTypeUtils(paymentType).name,
    FixFlipFields.wantsToRefinance: wantsToRefinance,
    FixFlipFields.constructionDownPaymentPercentage: constructionDownPaymentPercentage,
    FixFlipFields.constructionInterestRate: constructionInterestRate,
    FixFlipFields.constructionTerm: constructionTerm,
    FixFlipFields.holdingCostsUtilities: holdingCostsUtilities,
    FixFlipFields.sellerFinancingType: SellerFinancingTypeUtils(sellerFinancingType).name,
    FixFlipFields.sellerLoanPercent: sellerLoanPercentage,
    FixFlipFields.sellerInterestRate: sellerInterestRate,
    FixFlipFields.amortization: amortization,
    FixFlipFields.sellerTerm: sellerTerm,
    FixFlipFields.refinancingType: RefinancingUtils(refinancingType).name,
    FixFlipFields.refinancingLoanToValue: refinancingLoanToValue,
    FixFlipFields.refinancingInterestRate: refinancingInterestRate,
    FixFlipFields.refinancingTerm: refinancingTerm,
    FixFlipFields.refinancingClosingCosts: refinancingClosingCosts,
    'calculatorType': 'BRRRR',
  };

  static FixFlip fromJson(Map<String, Object?> json) => FixFlip(
    id: json[FixFlipFields.id] as int?,
      address: json[FixFlipFields.address] as String,
      listPrice: json[FixFlipFields.listPrice] as double,
      sqft: json[FixFlipFields.sqft] as int?,
      afterRepairValue: json[FixFlipFields.afterRepairValue] as double,
      purchasePrice:  json[FixFlipFields.purchasePrice] as double,
      monthsToRehabRent: json[FixFlipFields.monthsToRehabRent] as int,
      units: json[FixFlipFields.units] as int,
      investors: json[FixFlipFields.investors] as int,
      foundation: json[FixFlipFields.foundation] as double,
      roof: json[FixFlipFields.roof] as double,
      airConditioner: json[FixFlipFields.airConditioner] as double,
      paintingPatching: json[FixFlipFields.painting] as double,
      kitchen: json[FixFlipFields.kitchen] as double,
      windows: json[FixFlipFields.windows] as double,
      plumbing: json[FixFlipFields.plumbing] as double,
      flooring: json[FixFlipFields.flooring] as double,
      bathrooms: json[FixFlipFields.bathrooms] as double,
      appliances: json[FixFlipFields.appliances] as double,
      electrical: json[FixFlipFields.electrical] as double,
      yard: json[FixFlipFields.yard] as double,
      cleaning: json[FixFlipFields.cleaning] as double,
      baseboards: json[FixFlipFields.baseboards] as double,
      exterior: json[FixFlipFields.exterior] as double,
      totalRenovations: json[FixFlipFields.totalRenovations] as double,
      rent: json[FixFlipFields.rent] as double,
      otherIncome:  json[FixFlipFields.otherIncome] as double,
      afterRepairRentPerMonth:  json[FixFlipFields.afterRepairRentPerMonth] as double,
      afterRepairOtherIncome:  json[FixFlipFields.afterRepairOtherIncome] as double,
      taxesYearly: json[FixFlipFields.taxes] as double,
      insuranceYearly: json[FixFlipFields.insurance] as double,
      propertyManagementPercentage: json[FixFlipFields.propertyManagementPercentage] as double,
      vacancyPercentage: json[FixFlipFields.vacancyPercentage] as double,
      maintenancePercentage: json[FixFlipFields.maintenancePercentage] as double,
      otherExpensesPercentage:  json[FixFlipFields.otherExpensesPercentage] as double,
      financingType: FinancingTypeUtils.getFinancingType(json[FixFlipFields.financingType] as String),
      downPaymentPercent: json[FixFlipFields.downPaymentPercent] as double,
      interestRate: json[FixFlipFields.interestRate] as double,
      term: json[FixFlipFields.term] as int,
      closingCosts: json[FixFlipFields.closingCosts] as double,
      paymentType: PaymentTypeUtils.getPaymentType(json[FixFlipFields.paymentTypeType] as String),
      wantsToRefinance: (json[FixFlipFields.wantsToRefinance] as bool),
      constructionDownPaymentPercentage: json[FixFlipFields.constructionDownPaymentPercentage] as double,
      constructionInterestRate: json[FixFlipFields.constructionInterestRate] as double,
      constructionTerm: json[FixFlipFields.constructionTerm] as int,
      holdingCostsUtilities: json[FixFlipFields.holdingCostsUtilities] as double,
      sellerFinancingType: SellerFinancingTypeUtils.getFinancingType(json[FixFlipFields.financingType] as String),
      sellerLoanPercentage: json[FixFlipFields.sellerLoanPercent] as double,
      sellerInterestRate: json[FixFlipFields.sellerInterestRate] as double,
      amortization: json[FixFlipFields.amortization] as int,
      sellerTerm: json[FixFlipFields.sellerTerm] as int,
      refinancingType: RefinancingUtils.getFinancingType(json[FixFlipFields.financingType] as String),
      refinancingLoanToValue: json[FixFlipFields.refinancingLoanToValue] as double,
      refinancingInterestRate: json[FixFlipFields.refinancingInterestRate] as double,
      refinancingTerm: json[FixFlipFields.refinancingTerm] as int,
      refinancingClosingCosts: json[FixFlipFields.refinancingClosingCosts] as double,
  );

  void updateAll(FixFlip data) {
    id = data.id;
    address = data.address;
    listPrice = data.listPrice;
    sqft = data.sqft;
    afterRepairValue = data.afterRepairValue;
    purchasePrice = data.purchasePrice;
    monthsToRehabRent = data.monthsToRehabRent;
    units = data.units;
    investors = data.investors;
    foundation = data.foundation;
    roof = data.roof;
    airConditioner = data.airConditioner;
    paintingPatching = data.paintingPatching;
    kitchen = data.kitchen;
    windows = data.windows;
    plumbing = data.plumbing;
    flooring = data.flooring;
    bathrooms = data.bathrooms;
    appliances = data.appliances;
    electrical = data.electrical;
    yard = data.yard;
    cleaning = data.cleaning;
    baseboards = data.baseboards;
    exterior = data.exterior;
    totalRenovations = data.totalRenovations;
    rent = data.rent;
    otherIncome = data.otherIncome;
    totalIncome = data.totalIncome;
    yearlyIncome = data.yearlyIncome;
    afterRepairRentPerMonth = data.afterRepairRentPerMonth;
    afterRepairOtherIncome = data.afterRepairOtherIncome;
    totalIncomeAfterRepair = data.totalIncomeAfterRepair;
    yearlyIncomeAfterRepair = data.yearlyIncomeAfterRepair;
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
    paymentType = data.paymentType;
    wantsToRefinance = data.wantsToRefinance;
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
    if (totalRenovations == 0) {
      calculateTotalRenovations();
    }
    calculateTotalIncome();
    calculateYearlyIncome();
    calculateTotalIncomeAfterRepair();
    calculateYearlyIncomeAfterRepair();
    calculateAfterRepairTotalExpensesMonthly();
    calculateNOIMonthly();
    calculateNOIAnnually();
    calculateAfterRepairNOIMonthly();
    calculateAfterRepairNOIYearly();
    calculateLoanAmount();
    calculateAllRefinanceCalculations();
    calculateSellerFinanceCalculations();
    calculateAllHoldingCosts();
  }

  void updateProperty(FixFlip newProperty) {
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
        + yard + cleaning + baseboards + exterior;
    notifyListeners();
    return totalRenovations;
  }

  void updateFoundation(double newFoundation) {
    foundation = newFoundation;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateRoof(double newRoof) {
    roof = newRoof;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateAirConditioner(double newAirConditioner) {
    airConditioner = newAirConditioner;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updatePaintingPatching (double newPainting) {
    paintingPatching = newPainting;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateKitchen(double newKitchen) {
    kitchen = newKitchen;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateWindows (double newWindows) {
    windows = newWindows;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updatePlumbing(double newPlumbing) {
    plumbing = newPlumbing;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateFlooring(double newFlooring) {
    flooring = newFlooring;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateBathrooms(double newBathrooms) {
    bathrooms = newBathrooms;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateAppliances(double newAppliances) {
    appliances = newAppliances;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateElectrical(double newElectrical) {
    electrical = newElectrical;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateYard(double newYard) {
    yard = newYard;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateCleaning(double newCleaning) {
    cleaning = newCleaning;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateBaseboards(double newBaseboards) {
    baseboards = newBaseboards;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateExterior(double newExterior) {
    exterior = newExterior;
    calculateTotalRenovations();
    notifyListeners();
  }

  void updateRenovation(FixFlip newRenovation) {
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
    totalRenovations = newRenovation.totalRenovations;
    notifyListeners();
  }

  void updateIncome(FixFlip newIncome) {
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

  void updateExpenses(FixFlip newExpense) {
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

  void updateFinanceOptionData(FixFlip newFinanceOptionData) {
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

  void updateFinanceOptionConstruction(FixFlip newFinanceOptionConstructionProvider) {
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
    constructionMonthlyPayment = calculateMonthlyPaymentInterestOnly(
      rate: constructionInterestRate / 12,
      nper: constructionTerm,
      pv: -1 * constructionLoanAmount,
      per: 1,
    );
    notifyListeners();
  }

  void updateHoldingCostsUtilities(newValue) {
    holdingCostsUtilities = newValue;
    notifyListeners();
  }

  void calculateAllHoldingCosts() {
    double mp = (calculateMonthlyPaymentInterestOnly(
      rate: interestRate / 12,
      nper: term,
      pv: -1 * loanAmount,
      per: 1,
    ));

    debtService =
        (mp + sellerMonthlyPayment + constructionMonthlyPayment) * monthsToRehabRent;

    insuranceAndTaxes = (taxesMonthly + insuranceMonthly) * monthsToRehabRent;
    totalHoldingCosts = (debtService + insuranceAndTaxes + holdingCostsUtilities) * monthsToRehabRent;
    notifyListeners();
  }

  void updateSellerFinanceOptionData(FixFlip newFinanceOptionData) {
    sellerFinancingType = newFinanceOptionData.sellerFinancingType;
    sellerLoanPercentage = newFinanceOptionData.sellerLoanPercentage;
    sellerInterestRate = newFinanceOptionData.sellerInterestRate;
    sellerTerm = newFinanceOptionData.sellerTerm;
    notifyListeners();
  }

  void updateSellerFinancingType(newValue) {
    sellerFinancingType = newValue;
    notifyListeners();
  }

  void updateSellerLoanPercentage(newValue) {
    sellerLoanPercentage = newValue;
    notifyListeners();
  }

  void updateSellerLoanAmount(newValue) {
    sellerLoanAmount = newValue;
    notifyListeners();
  }

  void updateSellerInterestRate(newValue) {
    sellerInterestRate = newValue;
    notifyListeners();
  }

  void updateAmortization(newValue) {
    amortization = newValue;
    notifyListeners();
  }

  void updateSellerTerm(newValue) {
    sellerTerm = newValue;
    notifyListeners();
  }

  void updateSellerMonthlyPayment(newValue) {
    sellerMonthlyPayment = newValue;
    notifyListeners();
  }

  void calculateSellerFinanceCalculations() {
    sellerLoanAmount = sellerLoanPercentage * downPaymentAmount;
    if (sellerInterestRate != 0 && sellerTerm != 0 && sellerLoanAmount != 0) {
      if(sellerFinancingType == SellerFinancingType.payment) {
        sellerMonthlyPayment = calculateMonthlyPayment(rate: sellerInterestRate / 12, nper: sellerTerm * 12, pv: -1 * sellerLoanAmount);
      }
      else {
        sellerMonthlyPayment = calculateMonthlyPaymentInterestOnly(rate: sellerInterestRate / 12, nper: 1, pv: amortization, per: -1 * sellerLoanAmount);
      }
    }
    notifyListeners();
  }

  void updateRefinancingType(Refinancing newValue) {
    refinancingType = newValue;
    notifyListeners();
  }

  void updateRefinancingLoanToValue(newValue) {
    refinancingLoanToValue = newValue;
    notifyListeners();
  }

  void updateRefinancingLoanAmount(newValue) {
    refinancingLoanAmount = newValue;
    notifyListeners();
  }

  void updateRefinancingDownPayment(newValue) {
    refinancingDownPaymentAmount = newValue;
    notifyListeners();
  }

  void updateRefinancingInterestRate(newValue) {
    refinancingInterestRate = newValue;
    notifyListeners();
  }

  void updateRefinancingTerm(newValue) {
    refinancingTerm = newValue;
    notifyListeners();
  }

  void updateRefinancingClosingCosts(newValue) {
    refinancingClosingCosts = newValue;
    notifyListeners();
  }

  void updateRefinancingMonthlyPayment(newValue) {
    refinancingMonthlyPayment = newValue;
    notifyListeners();
  }

  void calculateAllRefinanceCalculations() {
    refinancingMonthlyPayment = Finance.pmt(
      rate: refinancingInterestRate / 12,
      nper: refinancingTerm * 12,
      pv: -1 * refinancingLoanAmount,
    ) as double;
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
    = cleaning = baseboards = exterior = totalRenovations = 0;
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