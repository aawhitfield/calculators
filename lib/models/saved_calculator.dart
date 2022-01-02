// To parse this JSON data, do
//
//     final savedCalculator = savedCalculatorFromMap(jsonString);

import 'dart:convert';

class SavedCalculator {
  SavedCalculator({
    required this.address,
    required this.calculatorType,
    required this.uid,
  });

  final String address;
  final String calculatorType;
  final String uid;

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
}
