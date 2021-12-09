import 'package:flutter/foundation.dart';

const String tableIncome = 'income';

class IncomeFields {
  static final List<String> values = [
    id, rent, other
  ];

  static const String id = '_id';
  static const String rent = 'rent';
  static const String other = 'other';
}


class Income extends ChangeNotifier {
  int? id;
  double rent;
  double other;
  double total;

  Income({this.id, this.rent = 0, this.other = 0, this.total = 0});

  Income copy({
    int? id,
    double? rent,
    double? other,
  }) => Income(
      id: id ?? this.id,
      rent:  rent ?? this.rent,
      other: other ?? this.other
  );

  Map<String, Object?> toJson() => {
    IncomeFields.id: id,
    IncomeFields.rent: rent,
    IncomeFields.other: other,

  };

  static Income fromJson(Map<String, Object?> json) => Income(
    id: json[IncomeFields.id] as int?,
    rent: json[IncomeFields.rent] as double,
    other:  json[IncomeFields.other] as double,
  );

  void updateIncome(Income newIncome) {
    id = newIncome.id;
    rent = newIncome.rent;
    other = newIncome.other;
    notifyListeners();
  }

  void updateRent(double newValue) {
    rent = newValue;
    notifyListeners();
  }

  void updateOther(double newValue) {
    other = newValue;
    notifyListeners();
  }

  void calculateTotal() {
    total = rent + other;
    notifyListeners();
  }

  void reset() {
    rent = other = total = 0;
    notifyListeners();
  }
}