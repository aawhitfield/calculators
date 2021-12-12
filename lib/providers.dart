import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/expenses.dart';
import 'package:calculators/models/financing_option_construction_provider.dart';
import 'package:calculators/models/financing_type.dart';
import 'package:calculators/models/fix_flip_selling_costs.dart';
import 'package:calculators/models/income.dart';
import 'package:calculators/models/options.dart';
import 'package:calculators/models/renovations.dart';
import 'package:calculators/models/seller_financing_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/property.dart';
import 'models/refinance.dart';

final propertyProvider = ChangeNotifierProvider<Property>((ref) => Property(
      calculator: Calculator.residentialREI,
      address: '',//Address(street: '', line2: '', city: '', state: '', zip: ''),
      listPrice: 0,
    ));

final renovationsProvider = ChangeNotifierProvider<Renovation>(
  (ref) => Renovation(),
);

final incomeProvider = ChangeNotifierProvider<Income>(
  (ref) => Income(),
);

final financeProvider = ChangeNotifierProvider<FinanceOptionData>(
  (ref) => FinanceOptionData(),
);

final sellerFinanceProvider = ChangeNotifierProvider<SellerFinanceOptionData>(
      (ref) => SellerFinanceOptionData(),
);

final refinanceProvider = ChangeNotifierProvider<RefinanceOptions>(
      (ref) => RefinanceOptions(),
);

final expensesProvider = ChangeNotifierProvider<Expenses>(
  (ref) => Expenses(),
);

final financeConstructionProvider =
    ChangeNotifierProvider<FinanceOptionConstructionProvider>(
  (ref) => FinanceOptionConstructionProvider(),
);


final optionsProvider =
ChangeNotifierProvider<Options>(
      (ref) => Options(),
);

final calculatorProvider = ChangeNotifierProvider<CurrentCalculator>(
    (ref) => CurrentCalculator(),
);

final ffSellingCostsProvider = ChangeNotifierProvider<FixFlipSellingCosts>(
    (ref) => FixFlipSellingCosts(),
);

void resetAllData(WidgetRef ref) {
  ref.read(expensesProvider).reset();
  ref.read(financeConstructionProvider).reset();
  ref.read(financeProvider).reset();
  ref.read(incomeProvider).reset();
  ref.read(optionsProvider).reset();
  ref.read(propertyProvider).reset();
  ref.read(refinanceProvider).reset();
  ref.read(renovationsProvider).reset();
  ref.read(sellerFinanceProvider).reset();
  ref.read(ffSellingCostsProvider).reset();
}
