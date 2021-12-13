import 'package:flutter/foundation.dart';

const String tableClosingCosts = 'closingCosts';

class ClosingCostsFields {
  static final List<String> values = [
    id, realtorsFeesPercentage, sellersClosingCosts, buyersClosingCosts,
  ];

  static const String id = '_id';
  static const String realtorsFeesPercentage = 'realtorsFeesPercentage';
  static const String sellersClosingCosts = 'sellersClosingCosts';
  static const String buyersClosingCosts = 'buyersClosingCosts';
}



class FixFlipSellingCosts extends ChangeNotifier{
  int? id;
  double realtorFeesPercentage;
  double realtorFees;
  double taxes;
  double sellersClosingCosts;
  double buyersClosingCosts;
  double otherClosingCosts;
  double totalClosingCosts;

  FixFlipSellingCosts({
    this.id,
    this.realtorFeesPercentage = 0,
    this.realtorFees = 0,
    this.taxes = 0,
    this.sellersClosingCosts = 0,
    this.buyersClosingCosts = 0,
    this.otherClosingCosts = 0,
    this.totalClosingCosts = 0,
  });

  FixFlipSellingCosts copy({
    int? id,
    double? realtorFeesPercentage,
    double? realtorFees,
    double? taxes,
    double? sellersClosingCosts,
    double? buyersClosingCosts,
    double? otherClosingCosts,
    double? totalClosingCosts,
  }) => FixFlipSellingCosts(
    id: id ?? this.id,
    realtorFeesPercentage: realtorFeesPercentage ?? this.realtorFeesPercentage,
    realtorFees: realtorFees ?? this.realtorFees,
    taxes: taxes ?? this.taxes,
    sellersClosingCosts:  sellersClosingCosts ?? this.sellersClosingCosts,
    buyersClosingCosts: buyersClosingCosts ?? this.buyersClosingCosts,
    otherClosingCosts: otherClosingCosts ?? this.otherClosingCosts,
    totalClosingCosts: totalClosingCosts ?? this.totalClosingCosts,
  );

  Map<String, Object?> toJson() => {
    ClosingCostsFields.id: id,
    ClosingCostsFields.realtorsFeesPercentage: realtorFeesPercentage,
    ClosingCostsFields.sellersClosingCosts: sellersClosingCosts,
    ClosingCostsFields.buyersClosingCosts: buyersClosingCosts
  };

  static FixFlipSellingCosts fromJson(Map<String, Object?> json) => FixFlipSellingCosts(
    id: json[ClosingCostsFields.id] as int?,
    realtorFeesPercentage: json[ClosingCostsFields.realtorsFeesPercentage] as double,
    sellersClosingCosts: json[ClosingCostsFields.sellersClosingCosts] as double,
    buyersClosingCosts: json[ClosingCostsFields.buyersClosingCosts] as double,
  );

  void updateFixFlipSellingCostsData(FixFlipSellingCosts newData) {
    id = newData.id;
    realtorFees = newData.realtorFees;
    realtorFeesPercentage = newData.realtorFeesPercentage;
    taxes = newData.taxes;
    sellersClosingCosts = newData.sellersClosingCosts;
    buyersClosingCosts = newData.buyersClosingCosts;
    otherClosingCosts = newData.otherClosingCosts;
    totalClosingCosts = newData.totalClosingCosts;
    notifyListeners();
  }


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

  double calculateTotal() {
    totalClosingCosts = realtorFees + taxes + sellersClosingCosts + buyersClosingCosts
        + otherClosingCosts;
    notifyListeners();
    return totalClosingCosts;
  }

  double calculateTotalOnly() {
    totalClosingCosts = realtorFees + taxes + sellersClosingCosts + buyersClosingCosts
        + otherClosingCosts;
    return totalClosingCosts;
  }

  void reset() {
    realtorFeesPercentage = realtorFees = taxes = sellersClosingCosts = 0;
    buyersClosingCosts = otherClosingCosts = totalClosingCosts = 0;
    notifyListeners();
  }
}
