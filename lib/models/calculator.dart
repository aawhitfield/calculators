import 'package:flutter/foundation.dart';

enum Calculator {
  residentialREI,
  fixAndFlip,
}

class CalculatorUtils {

  static String getName(Calculator calculator) {
    switch (calculator) {
      case Calculator.residentialREI :
        return 'Residential REI';
      case Calculator.fixAndFlip :
        return 'Fix and Flip';
    }
  }

  static Calculator toType(String name) {
    switch(name) {
      case 'Residential REI': return Calculator.residentialREI;
      case 'Fix and Flip': return Calculator.fixAndFlip;
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
    }
  }

  void updateCurrentCalculator(Calculator newValue) {
    type = newValue;
    notifyListeners();
  }
}