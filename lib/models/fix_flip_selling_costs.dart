import 'package:flutter/foundation.dart';

class FixFlipSellingCosts extends ChangeNotifier{
  double realtorFeesPercentage;
  double realtorFees;
  double taxes;
  double sellersClosingCosts;
  double buyersClosingCosts;
  double otherClosingCosts;
  double totalClosingCosts;

  FixFlipSellingCosts({
    this.realtorFeesPercentage = 0,
    this.realtorFees = 0,
    this.taxes = 0,
    this.sellersClosingCosts = 0,
    this.buyersClosingCosts = 0,
    this.otherClosingCosts = 0,
    this.totalClosingCosts = 0,
  });

  void updateRealtorFeesPercentage (double newValue) {
    realtorFeesPercentage = newValue;
    notifyListeners();
  }

  void updateRealtorFees(double newValue) {
    realtorFees = newValue;
    calculateTotal();
    notifyListeners();
  }

  void updateTaxes(double newValue) {
    taxes = newValue;
    calculateTotal();
    notifyListeners();
  }

  void updateSellersClosingCosts(double newValue) {
    sellersClosingCosts = newValue;
    calculateTotal();
    notifyListeners();
  }

  void updateBuyersClosingCosts(double newValue) {
    buyersClosingCosts = newValue;
    calculateTotal();
    notifyListeners();
  }

  void updateOtherClosingCosts(double newValue) {
    otherClosingCosts = newValue;
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    totalClosingCosts = realtorFees + taxes + sellersClosingCosts + buyersClosingCosts
        + otherClosingCosts;
    notifyListeners();
  }

  void reset() {
    realtorFeesPercentage = realtorFees = taxes = sellersClosingCosts = 0;
    buyersClosingCosts = otherClosingCosts = totalClosingCosts = 0;
    notifyListeners();
  }
}
