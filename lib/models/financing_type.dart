
enum FinancingType {
  commercial,
  commercialWithConstruction,
  conventional,
  hardMoney,
  hardMoneyWithConstruction,
  sellerFinancing,
}

enum PaymentType {
  principalAndInterest,
  interestOnly,
}

class FinancingTypeUtils {
  final FinancingType financingType;

  FinancingTypeUtils(this.financingType);

  String get name {
    switch(financingType) {
      case FinancingType.commercial : return 'Commercial';
      case FinancingType.commercialWithConstruction : return 'Commercial with Construction';
      case FinancingType.conventional : return 'Conventional';
      case FinancingType.hardMoney : return 'Hard Money';
      case FinancingType.hardMoneyWithConstruction : return 'Hard Money with Construction';
      case FinancingType.sellerFinancing : return 'Seller Financing';
    }
  }

  static FinancingType getFinancingType(String name) {
    if (name == 'Commercial + Construction') {
      return FinancingType.commercialWithConstruction;
    } else if (name == 'Conventional') {
      return FinancingType.conventional;
    } else if (name == 'Hard Money') {
      return FinancingType.hardMoney;
    } else if (name == 'Hard Money + Construction') {
      return FinancingType.hardMoneyWithConstruction;
    } else if (name == 'Seller Financing') {
      return FinancingType.sellerFinancing;
    } else {
      return FinancingType.commercial;
    }
  }
}

class PaymentTypeUtils {
  final PaymentType paymentType;

  PaymentTypeUtils(this.paymentType);

  String get name {
    switch(paymentType) {
      case PaymentType.principalAndInterest : return 'Principal & Interest';
      case PaymentType.interestOnly : return 'Interest Only';
    }
  }

  static PaymentType getPaymentType(String name) {
    if (name == 'Interest Only') {
      return PaymentType.interestOnly;
    } else {
      return PaymentType.principalAndInterest;
    }
  }
}