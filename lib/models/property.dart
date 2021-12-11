// organizes all information for a property

import 'package:calculators/models/calculator.dart';
import 'package:flutter/material.dart';

const String tableProperty = 'properties';

class PropertyFields {
  static final List<String> values = [
    id, calculator, address, listPrice, sqft, afterRepairValue, purchasePrice, monthsToRehabRent,
    units, investors
  ];

  static const String id = '_id';
  static const String calculator = 'calculator';
  static const String address = 'address';
  static const String listPrice = 'listPrice';
  static const String sqft = 'sqft';
  static const String afterRepairValue = 'afterRepairValue';
  static const String purchasePrice = 'purchasePrice';
  static const String monthsToRehabRent = 'monthsToRehabRent';
  static const String units = 'units';
  static const String investors = 'investors';
}

class Property extends ChangeNotifier{
  int? id;
  Calculator calculator;
  String address;
  double listPrice;
  int? sqft;
  double afterRepairValue;
  double purchasePrice;
  int monthsToRehabRent;
  int units;
  int investors;

  Property({this.id, required this.calculator, required this.address, required this.listPrice, this.sqft,
    this.afterRepairValue = 0, this.purchasePrice = 0, this.monthsToRehabRent = 0,
    this.units = 0, this.investors = 0,
  });

  Property copy({
    int? id,
    Calculator? calculator,
    String? address,
    double? listPrice,
    int? sqft,
    double? afterRepairValue,
    double? purchasePrice,
    int? monthsToRehabRent,
    int? units,
    int? investors,
}) => Property(
      id: id ?? this.id,
      calculator:  calculator ?? this.calculator,
      address: address ?? this.address,
      listPrice: listPrice ?? this.listPrice,
      sqft: sqft ?? this.sqft,
      afterRepairValue: afterRepairValue ?? this.afterRepairValue,
      purchasePrice:  purchasePrice ?? this.purchasePrice,
      monthsToRehabRent: monthsToRehabRent ?? this.monthsToRehabRent,
      units: units ?? this.units,
      investors: investors ?? this.investors
  );

  Map<String, Object?> toJson() => {
    PropertyFields.id: id,
    PropertyFields.calculator: CalculatorUtils.getName(calculator),
    PropertyFields.address: address,
    PropertyFields.listPrice: listPrice,
    PropertyFields.sqft: sqft,
    PropertyFields.afterRepairValue: afterRepairValue,
    PropertyFields.purchasePrice: purchasePrice,
    PropertyFields.monthsToRehabRent: monthsToRehabRent,
    PropertyFields.units: units,
    PropertyFields.investors: investors,
  };

  static Property fromJson(Map<String, Object?> json) => Property(
    id: json[PropertyFields.id] as int?,
      calculator: CalculatorUtils.toType(json[PropertyFields.calculator] as String),
      address: json[PropertyFields.address] as String,
      listPrice: json[PropertyFields.listPrice] as double,
      sqft: json[PropertyFields.sqft] as int?,
      afterRepairValue: json[PropertyFields.afterRepairValue] as double,
      purchasePrice:  json[PropertyFields.purchasePrice] as double,
      monthsToRehabRent: json[PropertyFields.monthsToRehabRent] as int,
      units: json[PropertyFields.units] as int,
      investors: json[PropertyFields.investors] as int,
  );

  void updateProperty(Property newProperty) {
    id = newProperty.id;
    calculator = newProperty.calculator;
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
  void updateCalculator(Calculator newCalculator) {
    calculator = newCalculator;
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
    notifyListeners();
  }
}