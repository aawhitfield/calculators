import 'package:flutter/foundation.dart';

enum Calculator {
  brrrr,
  fixAndFlip,
  quickMaxOffer,
  turnkeyRental
}

class CalculatorUtils {

  static String getName(Calculator calculator) {
    switch (calculator) {
      case Calculator.brrrr :
        return 'BRRRR';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
      case Calculator.quickMaxOffer :
        return 'Quick Max Offer';
      case Calculator.turnkeyRental :
        return 'Turnkey Rental';
    }
  }

  static Calculator toType(String name) {
    switch(name) {
      case 'BRRRR': return Calculator.brrrr;
      case 'Fix and Flip': return Calculator.fixAndFlip;
      case 'Quick Max Offer': return Calculator.quickMaxOffer;
      case 'Turnkey Rental' : return Calculator.turnkeyRental;
      default: return Calculator.brrrr;
    }
  }
}

class CurrentCalculator extends ChangeNotifier{
  Calculator type;

  CurrentCalculator({this.type = Calculator.brrrr});

  String get name {
    switch (type) {
      case Calculator.brrrr :
        return 'BRRRR';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
      case Calculator.quickMaxOffer:
        return 'Quick Max Offer';
      case Calculator.turnkeyRental :
        return 'Turnkey Rental';
    }
  }

  void updateCurrentCalculator(Calculator newValue) {
    type = newValue;
    notifyListeners();
  }
}