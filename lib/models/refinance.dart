enum Refinancing{
  cashOut,
  noCashOut,
}

class RefinancingUtils {
  Refinancing refinancingMethod;

  RefinancingUtils(this.refinancingMethod);

  String get name {
    switch(refinancingMethod) {
      case Refinancing.cashOut : return 'Cashout Refinance';
      case Refinancing.noCashOut : return 'No Cashout Refinance';
    }
  }

  static Refinancing getFinancingType(String name) {
    if (name == 'No Cashout Refinance') {
      return Refinancing.noCashOut;
    } else {
      return Refinancing.cashOut;
    }
  }
}