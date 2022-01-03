// To parse this JSON data, do
//
//     final savedCalculator = savedCalculatorFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

class SavedCalculator with ChangeNotifier{
  SavedCalculator({
    required this.address,
    required this.calculatorType,
    required this.uid,
  });

  String address;
  String calculatorType;
  String uid;

  factory SavedCalculator.fromJson(String str) => SavedCalculator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SavedCalculator.fromMap(Map<String, dynamic> json) => SavedCalculator(
    address: json["address"],
    calculatorType: json["calculatorType"],
    uid: json["uid"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "calculatorType": calculatorType,
    "uid": uid,
  };

  void updateAll(SavedCalculator newValues) {
    address = newValues.address;
    calculatorType = newValues.calculatorType;
    uid = newValues.uid;
    notifyListeners();
  }

  void reset() {
    address = '';
    calculatorType = 'BRRRR';
    uid = '';
    notifyListeners();
  }
}
