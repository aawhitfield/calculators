import 'package:flutter/foundation.dart';

enum Calculator {
  brrrr,
  fixAndFlip,
  quickMaxOffer,
}

class CalculatorUtils {

  static String getName(Calculator calculator) {
    switch (calculator) {
      case Calculator.brrrr :
        return 'Residential REI';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
      case Calculator.quickMaxOffer :
        return 'Quick Max Offer';
    }
  }

  static Calculator toType(String name) {
    switch(name) {
      case 'BRRRR': return Calculator.brrrr;
      case 'Fix and Flip': return Calculator.fixAndFlip;
      case 'Quick Max Offer': return Calculator.quickMaxOffer;
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
    }
  }

  void updateCurrentCalculator(Calculator newValue) {
    type = newValue;
    notifyListeners();
  }
}