import 'package:flutter/foundation.dart';

enum Calculator {
  residentialREI,
  fixAndFlip,
  quickMaxOffer,
}

class CalculatorUtils {

  static String getName(Calculator calculator) {
    switch (calculator) {
      case Calculator.residentialREI :
        return 'Residential REI';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
      case Calculator.quickMaxOffer :
        return 'Quick Max Offer';
    }
  }

  static Calculator toType(String name) {
    switch(name) {
      case 'Residential REI': return Calculator.residentialREI;
      case 'Fix and Flip': return Calculator.fixAndFlip;
      case 'Quick Max Offer': return Calculator.quickMaxOffer;
      default: return Calculator.residentialREI;
    }
  }
}

class CurrentCalculator extends ChangeNotifier{
  Calculator type;

  CurrentCalculator({this.type = Calculator.residentialREI});

  String get name {
    switch (type) {
      case Calculator.residentialREI :
        return 'Residential REI';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
      case Calculator.quickMaxOffer:
        return 'Quick Max Offer';
    }
  }

  void updateCurrentCalculator(Calculator newValue) {
    type = newValue;
    notifyListeners();
  }
}