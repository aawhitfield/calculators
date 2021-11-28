import 'package:flutter/foundation.dart';

class Expenses extends ChangeNotifier {
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
    this.noiMonthly = 0, this.noiAnnual = 0,
  });

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
}