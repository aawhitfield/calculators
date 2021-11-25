enum FinancingType {
  commercial,
}

class FinancingTypeUtils {
  final FinancingType financingType;

  FinancingTypeUtils(this.financingType);

  String get name {
    switch(financingType) {
      case FinancingType.commercial : return 'Commercial';
    }
  }
}