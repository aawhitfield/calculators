import 'package:flutter/foundation.dart';

const String tableExpenses = 'expenses';

class ExpensesFields {
  static final List<String> values = [
    id, taxes, propertyManagement, vacancy, maintenance, other
  ];

  static const String id = '_id';
  static const String taxes = 'taxes';
  static const String propertyManagement = 'propertyManagement';
  static const String vacancy = 'vacancy';
  static const String maintenance = 'maintenance';
  static const String other = 'other';
}

class Expenses extends ChangeNotifier {
  int? id;
  double taxes;
  double propertyManagement;
  double vacancy;
  double maintenance;
  double other;
  double totalMonthlyExpenses;
  double totalAnnualExpenses;
  double noiMonthly;
  double noiAnnual;

  Expenses({this.taxes = 0, this.propertyManagement = 0,
    this.vacancy = 0, this.maintenance = 0, this.other = 0,
    this.totalMonthlyExpenses = 0, this.totalAnnualExpenses = 0,
    this.noiMonthly = 0, this.noiAnnual = 0, this.id,
  });

  Expenses copy({
    int? id,
    double? taxes,
    double? propertyManagement,
    double? vacancy,
    double? maintenance,
    double? other,
    double? totalMonthlyExpenses,
    double? totalAnnualExpenses,
    double? noiMonthly,
    double? noiAnnual,
  }) => Expenses(
      id: id ?? this.id,
      taxes:  taxes ?? this.taxes,
      propertyManagement: propertyManagement ?? this.propertyManagement,
      vacancy: vacancy ?? this.vacancy,
      maintenance: maintenance ?? this.maintenance,
      other: other ?? this.other,
      totalMonthlyExpenses: totalMonthlyExpenses ?? this.totalMonthlyExpenses,
      totalAnnualExpenses: totalAnnualExpenses ?? this.totalAnnualExpenses,
      noiMonthly: noiMonthly ?? this.noiMonthly,
      noiAnnual: noiAnnual?? this.noiAnnual,
  );

  Map<String, Object?> toJson() => {
    ExpensesFields.id: id,
    ExpensesFields.taxes: taxes,
    ExpensesFields.propertyManagement: propertyManagement,
    ExpensesFields.vacancy: vacancy,
    ExpensesFields.maintenance: maintenance,
    ExpensesFields.other: other,

  };

  static Expenses fromJson(Map<String, Object?> json) => Expenses(
    id: json[ExpensesFields.id] as int?,
    taxes: json[ExpensesFields.taxes] as double,
    propertyManagement: json[ExpensesFields.propertyManagement] as double,
    vacancy: json[ExpensesFields.vacancy] as double,
    maintenance: json[ExpensesFields.maintenance] as double,
    other:  json[ExpensesFields.other] as double,
  );

  void updateExpenses(Expenses newExpense) {
    id = newExpense.id;
    taxes = newExpense.taxes;
    propertyManagement = newExpense.propertyManagement;
    vacancy = newExpense.vacancy;
    maintenance = newExpense.maintenance;
    other = newExpense.other;
    notifyListeners();
  }

  void updateTaxes(double newValue) {
    taxes = newValue;
    notifyListeners();
  }

  void updatePropertyManagement(double newValue) {
    propertyManagement = newValue;
    notifyListeners();
  }

  void updateVacancy(double newValue) {
    vacancy = newValue;
    notifyListeners();
  }

  void updateMaintenance(double newValue) {
    maintenance = newValue;
    notifyListeners();
  }

  void updateOther(double newValue) {
    other = newValue;
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

  double calculateTotalExpensesMonthly(double totalMonthlyIncome) {
    totalMonthlyExpenses = taxes / 12  +
        propertyManagement * totalMonthlyIncome
        + vacancy * totalMonthlyIncome
        + maintenance * totalMonthlyIncome
        + other * totalMonthlyIncome;
    totalAnnualExpenses = totalMonthlyExpenses * 12;
    return totalMonthlyExpenses;
  }

  double calculateTotalAnnualExpenses() {
    totalAnnualExpenses = totalMonthlyExpenses * 12;
    return totalAnnualExpenses;
  }

  double calculateNOIMonthly(double totalMonthlyIncome) {
    noiMonthly = totalMonthlyIncome - totalMonthlyExpenses;
    return noiMonthly;
  }

  double calculateNOIAnnually(double totalMonthlyIncome) {
    noiAnnual = totalMonthlyIncome * 12 - totalAnnualExpenses;
    return noiAnnual;
  }

  void reset() {
    taxes = propertyManagement = vacancy = maintenance = other = totalMonthlyExpenses
      = totalAnnualExpenses = noiMonthly = noiAnnual = 0;
    id = null;
    notifyListeners();
  }
}