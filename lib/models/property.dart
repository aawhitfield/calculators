// organizes all information for a property

import 'package:flutter/material.dart';

class BRRRRFields {
  static final List<String> values = [
    id, calculator, address, listPrice, sqft, afterRepairValue, purchasePrice, monthsToRehabRent,
    units, investors
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

  BRRRR({this.id, required this.address, required this.listPrice, this.sqft,
    this.afterRepairValue = 0, this.purchasePrice = 0, this.monthsToRehabRent = 0,
    this.units = 0, this.investors = 0,
  });

  BRRRR copy({
    int? id,
    String? address,
    double? listPrice,
    int? sqft,
    double? afterRepairValue,
    double? purchasePrice,
    int? monthsToRehabRent,
    int? units,
    int? investors,
}) => BRRRR(
      id: id ?? this.id,
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
    BRRRRFields.id: id,
    BRRRRFields.address: address,
    BRRRRFields.listPrice: listPrice,
    BRRRRFields.sqft: sqft,
    BRRRRFields.afterRepairValue: afterRepairValue,
    BRRRRFields.purchasePrice: purchasePrice,
    BRRRRFields.monthsToRehabRent: monthsToRehabRent,
    BRRRRFields.units: units,
    BRRRRFields.investors: investors,
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